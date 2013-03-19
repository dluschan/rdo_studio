/*!
  \copyright (c) RDO-Team, 2003-2012
  \file      main_window.cpp
  \author    Урусов Андрей (rdo@rk9.bmstu.ru)
  \date      20.02.2003
  \brief     
  \indent    4T
*/

// ---------------------------------------------------------------------------- PCH
#include "app/rdo_studio/pch/stdpch.h"
// ----------------------------------------------------------------------- INCLUDES
#include "utils/warning_disable.h"
#include <boost/bind.hpp>
#include <boost/foreach.hpp>
#include <boost/range/algorithm/find.hpp>
#include <QProcess>
#include <QTextCodec>
#include <QSettings>
#include <QMdiSubWindow>
#include "utils/warning_enable.h"
// ----------------------------------------------------------------------- SYNOPSIS
#include "app/rdo_studio/src/main_window.h"
#include "app/rdo_studio/src/application.h"
#include "app/rdo_studio/src/model/model.h"
#include "app/rdo_studio/src/about.h"
#include "app/rdo_studio/src/view_preferences.h"
#include "app/rdo_studio/src/model/model_tab_ctrl.h"
#include "app/rdo_studio/src/tracer/tracer.h"
#include "thirdparty/scintilla/include/Scintilla.h"
// --------------------------------------------------------------------------------

// --------------------------------------------------------------------------------
// -------------------- MainWindow::InsertMenuData
// --------------------------------------------------------------------------------
MainWindow::InsertMenuData::InsertMenuData(QObject* pParent, const QString& text, const Position& position)
	: QObject   (pParent )
	, m_text    (text    )
	, m_position(position)
{}

const QString& MainWindow::InsertMenuData::text() const
{
	return m_text;
}

const MainWindow::InsertMenuData::Position& MainWindow::InsertMenuData::position() const
{
	return m_position;
}

// --------------------------------------------------------------------------------
// -------------------- MainWindow
// --------------------------------------------------------------------------------
MainWindow::MainWindow()
	: m_updateTimerID(0)
	, m_pInsertMenuSignalMapper(NULL)
	, m_hasWindow(false)
	, m_pSeparator(NULL)
{
	setupUi(this);
	mdiArea->setOption(QMdiArea::DontMaximizeSubWindowOnActivation);

	createStatusBar ();
	createToolBar   ();
	createInsertMenu();

	addAction(actSearchFindNextCurrent);
	addAction(actSearchFindPreviousCurrent);
	addAction(actSearchLogNext);
	addAction(actSearchLogPrev);

	connect(menuFileReopen, &QMenu::triggered,   this, &MainWindow::onMenuFileReopen);
	connect(actFileExit,    &QAction::triggered, this, &QMainWindow::close);

	connect(mdiArea, &QMdiArea::subWindowActivated, this, &MainWindow::onSubWindowActivated);

	connect(actViewSettings, &QAction::triggered, this, &MainWindow::onViewOptions);
	connect(actHelpWhatsNew, &QAction::triggered, this, &MainWindow::onHelpWhatsNew);
	connect(actHelpAbout,    &QAction::triggered, this, &MainWindow::onHelpAbout);

	connect(toolBarModel, &QToolBar::orientationChanged, this, &MainWindow::onToolBarModelOrientationChanged);

	Scintilla_LinkLexers();

	loadMenuFileReopen  ();
	updateMenuFileReopen();
}

//! todo не вызывается диструктор
MainWindow::~MainWindow()
{}

void MainWindow::createStatusBar()
{
	m_pStatusBar = rdo::Factory<StatusBar>::create(this);
}

void MainWindow::createToolBar()
{
	m_pModelSpeedSlider = new QSlider(Qt::Horizontal, this);
	m_pModelSpeedSlider->setRange(0, 100);
	m_pModelSpeedSlider->setValue(100);
	m_pModelSpeedSlider->setMaximumSize(100, 100);

	toolBarModel->insertWidget(actModelFrameNext, m_pModelSpeedSlider);
	toolBarModel->insertSeparator(actModelFrameNext);
}

void MainWindow::createInsertMenu()
{
	ASSERT(!m_pInsertMenuSignalMapper);
	m_pInsertMenuSignalMapper = new QSignalMapper(this);

	class MenuItem
	{
	public:
		typedef  InsertMenuData::Position  Position;

		MenuItem(const char* title, const QString& resourceName = QString(), const Position& position = Position())
			: m_title   (title   )
			, m_position(position)
		{
			init(resourceName);
		}

		MenuItem(const QString& title, const QString& resourceName = QString(), const Position& position = Position())
			: m_title   (title   )
			, m_position(position)
		{
			init(resourceName);
		}

		const QString& title() const
		{
			return m_title;
		}

		const QString textForInsert() const
		{
			return !m_textForInsert.isEmpty()
				? m_textForInsert
				: m_title;
		}

		const Position& position() const
		{
			return m_position;
		}

	private:
		QString    m_title;
		QString    m_textForInsert;
		Position   m_position;

		void init(const QString& resourceName)
		{
			if (!resourceName.isEmpty())
			{
				QFile file(":/insert_menu_template/insert_menu_template/" + resourceName);
				if (file.open(QIODevice::ReadOnly) && file.isOpen())
				{
					m_textForInsert = file.readAll();
				}
			}
		}
	};

	typedef  rdo::vector<MenuItem>                         MenuItemList;
	typedef  std::list<std::pair<QString, MenuItemList> >  MenuList;

	MenuList menuList;
	menuList.push_back(
		std::make_pair(
			"PAT",
			MenuItemList
				(MenuItem("PAT operation", "pat_operation.txt", 9))
				(MenuItem("PAT rule", "pat_rule.txt", 9))
				(MenuItem("PAT keyboard", "pat_keyboard.txt", 9))
				("$Pattern")("operation")("event")("rule")("keyboard")("trace")("no_trace")("$Parameters")
				("$Relevant_resources")("Keep")("NoChange")("Create")("Erase")("NonExist")("$Time")("$Body")
				("Convert_begin")("Convert_end")("Convert_event")("Convert_rule")("Choice from")
				("Choice NoCheck")("first")("with_max")("with_min")("set")("$End")
		)
	);
	menuList.push_back(
		std::make_pair(
			"EVN",
			MenuItemList
				(MenuItem("EVN", "pat_event.txt", 9))
				("$Pattern")("trace")("no_trace")("$Parameters")("$Relevant_resources")("Keep")("NoChange")
				("Create")("Erase")("NonExist")("$Body")("Convert_event")("$End")
		)
	);
	menuList.push_back(
		std::make_pair(
			"PRC",
			MenuItemList
				(MenuItem("PRC", "prc.txt", 9))
				("$Process")("GENERATE")("SEIZE")("RELEASE")("ADVANCE")("QUEUE")("DEPART")("ASSIGN")("TERMINATE")
		)
	);
	menuList.push_back(
		std::make_pair(
			"RTP",
			MenuItemList
				(MenuItem("RTP permanent", "rtp_permanent.txt", 15))
				(MenuItem("RTP temporary", "rtp_temporary.txt", 15))
				("$Resource_type")("permanent")("temporary")("$Parameters")("integer")("real")("enum")("string")
				("bool")("true")("false")("such_as")("$End")
		)
	);
	menuList.push_back(
		std::make_pair(
			"RSS",
			MenuItemList
				(MenuItem("RSS", "rss.txt", 13))
				("$Resources")("trace")("no_trace")("$End")
		)
	);
	menuList.push_back(
		std::make_pair(
			"FRM",
			MenuItemList
				(MenuItem("FRM", "frm.txt", 7))
				("$Frame")("$Back_picture")("bitmap")("text")("line")("rect")("circle")("ellipse")("r_rect")
				("triang")("s_bmp")("active")("$End")
		)
	);
	menuList.push_back(
		std::make_pair(
			"FUN",
			MenuItemList
				(MenuItem("FUN algorithmic", "fun_algorithmic.txt", 10))
				(MenuItem("SQN", "fun_sequence.txt", 10))
				(MenuItem("CNS", "fun_const.txt", 12))
				("$Function")("$Type")("algorithmic")("list")("table")("normal")("uniform")("exponential")
				("triangular")("by_hist")("enumerative")("$Parameters")("$Body")("$Sequence")("$Constant")
				("$End")
		)
	);
	menuList.push_back(
		std::make_pair(
			"DPT",
			MenuItemList
				(MenuItem("DPT some", "dtp_some.txt", 16))
				(MenuItem("DPT prior", "dtp_prior.txt", 16))
				(MenuItem("DPT search", "dtp_search.txt", 16))
				("$Decision_point")("some")("search")("prior")("no_trace")("trace_stat")("trace_tops")("trace_all")
				("$Condition")("$Term_condition")("$Evaluate_by")("$Compare_tops")("YES")("NO")("$Activities")
				("value before")("value after")("$End")
		)
	);
	menuList.push_back(
		std::make_pair(
			"SMR",
			MenuItemList
				(MenuItem("SMR", "smr.txt", 17))
				("Frame_number")("Show_mode")("Animation")("Monitor")("NoShow")("Show_rate")("Run_StartTime")
				("Trace_StartTime")("Trace_EndTime")("Terminate_if")("Time_now")("Seconds")("Break_point")
		)
	);
	menuList.push_back(
		std::make_pair(
			"PMD",
			MenuItemList
				(MenuItem("PMD", "pmd.txt", 11))
				("$Results")("watch_par")("watch_state")("watch_quant")("watch_value")("get_value")("trace")
				("no_trace")("$End")
		)
	);
	menuList.push_back(std::make_pair("", MenuItemList()));
	menuList.push_back(
		std::make_pair(
			"Встроенные функции",
			MenuItemList("Abs")("ArcCos")("ArcSin")("ArcTan")("Cos")("Cotan")("Exist")("Exp")("Floor")("For_All")("Frac")
				("IAbs")("IMax")("IMin")("Int")("IntPower")("Ln")("Log10")("Log2")("LogN")("Max")("Min")("Not_Exist")
				("Not_For_All")("Power")("Round")("Select")("Sin")("Sqrt")("Tan")
		)
	);
	menuList.push_back(
		std::make_pair(
			"Процедурный язык",
			MenuItemList
				(MenuItem("if", "algo_if.txt", 4))
				("else")
				(MenuItem("if-else", "algo_if_else.txt", 4))
				(MenuItem("for", "algo_for.txt", 5))
				("return")
				(MenuItem("Локальная переменная", "algo_local_variable.txt"))
		)
	);

	BOOST_FOREACH(const MenuList::value_type& menu, menuList)
	{
		if (menu.first.isEmpty())
		{
			ASSERT(menu.second.empty());
			menuInsert->addSeparator();
			continue;
		}

		QMenu* pMenu = new QMenu(menu.first, this);
		menuInsert->addMenu(pMenu);

		BOOST_FOREACH(const MenuItem& menuItem, menu.second)
		{
			QAction* pAction = pMenu->addAction(menuItem.title());
			pAction->setEnabled(false);
			QObject::connect(pAction, SIGNAL(triggered(bool)), m_pInsertMenuSignalMapper, SLOT(map()));
			InsertMenuData* pInsertMenuData = new InsertMenuData(this, menuItem.textForInsert(), menuItem.position());
			m_pInsertMenuSignalMapper->setMapping(pAction, pInsertMenuData);
		}
	}
}

void MainWindow::init()
{
	// Кто-то должен поднять кернел и треды
	new rdo::gui::model::Model();

	style_editor.init( "editor" );
	style_editor.load();

	style_build.init( "build" );
	style_build.window->wordWrap          = true;
	style_build.window->showHorzScrollBar = false;
	style_build.load();

	style_debug.init( "debug" );
	style_debug.window->wordWrap          = true;
	style_debug.window->showHorzScrollBar = false;
	style_debug.load();

	style_trace.init( "trace" );
	style_trace.load();

	style_results.init( "results" );
	style_results.load();

	style_find.init( "find" );
	style_find.load();

	style_frame.init( "frame" );
	style_frame.load();

	style_chart.init( "chart" );
	style_chart.load();

	m_pDockBuild   = new DockBuild  (this);
	m_pDockDebug   = new DockDebug  (this);
	m_pDockTrace   = new DockTrace  (this);
	m_pDockResults = new DockResults(this);
	m_pDockFind    = new DockFind   (this);

	QObject::connect(m_pDockBuild, &QDockWidget::visibilityChanged, this, &MainWindow::onDockVisibleChanged);
	QObject::connect(m_pDockFind,  &QDockWidget::visibilityChanged, this, &MainWindow::onDockVisibleChanged);

	updateAllStyles();
	addDockWidget(Qt::BottomDockWidgetArea, m_pDockBuild);
	tabifyDockWidget(m_pDockBuild, m_pDockDebug  );
	tabifyDockWidget(m_pDockBuild, m_pDockTrace  );
	tabifyDockWidget(m_pDockBuild, m_pDockResults);
	tabifyDockWidget(m_pDockBuild, m_pDockFind   );
	m_pDockDebug->raise();

	m_pDockChartTree = new DockChartTree(this);
	m_pDockFrame     = new DockFrame    (this);
	addDockWidget(Qt::LeftDockWidgetArea, m_pDockChartTree);
	tabifyDockWidget(m_pDockChartTree, m_pDockFrame);
	m_pDockChartTree->raise();

	PTR(QMenu) pMenuDockView = new QMenu("Окна");
	ASSERT(pMenuDockView);
	menuView->insertMenu(actViewSettings, pMenuDockView);
	pMenuDockView->addAction(m_pDockBuild->toggleViewAction());
	pMenuDockView->addAction(m_pDockDebug->toggleViewAction());
	pMenuDockView->addAction(m_pDockTrace->toggleViewAction());
	pMenuDockView->addAction(m_pDockResults->toggleViewAction());
	pMenuDockView->addAction(m_pDockFind->toggleViewAction());
	pMenuDockView->addAction(m_pDockChartTree->toggleViewAction());
	pMenuDockView->addAction(m_pDockFrame->toggleViewAction());

	PTR(QMenu) pMenuToolbarView = new QMenu("Панели");
	ASSERT(pMenuToolbarView);
	menuView->insertMenu(actViewSettings, pMenuToolbarView);
	pMenuToolbarView->addAction(toolBarFile->toggleViewAction());
	pMenuToolbarView->addAction(toolBarEdit->toggleViewAction());
	pMenuToolbarView->addAction(toolBarZoom->toggleViewAction());
	pMenuToolbarView->addAction(toolBarModel->toggleViewAction());

	menuView->insertSeparator(actViewSettings);

	g_pTracer->registerClipboardFormat();

	PTR(IInit) pModelInit = dynamic_cast<PTR(IInit)>(g_pModel);
	ASSERT(pModelInit);
	pModelInit->init();
}

void MainWindow::setVisible(rbool visible)
{
	parent_type::setVisible(visible);
}

void MainWindow::closeEvent(QCloseEvent* event)
{
	if (g_pModel && !g_pModel->closeModel())
	{
		event->ignore();
	}

	if (event->isAccepted())
	{
		update_stop();
		style_editor.save();
		style_build.save();
		style_debug.save();
		style_trace.save();
		style_results.save();
		style_find.save();
		style_frame.save();
		style_chart.save();
	}
}

void MainWindow::onViewOptions()
{
	ViewPreferences dlg(this);
	dlg.exec();
}

void MainWindow::updateAllStyles()
{
	g_pModel->updateStyleOfAllModel();
	getDockBuild  ().getContext().setEditorStyle (&style_build  );
	getDockDebug  ().getContext().setEditorStyle (&style_debug  );
	getDockTrace  ().getContext().view().setStyle(&style_trace  );
	getDockResults().getContext().setEditorStyle (&style_results);
	getDockFind   ().getContext().setEditorStyle (&style_find   );
	g_pTracer->updateChartsStyles();
}

CREF(LPStatusBar) MainWindow::statusBar() const
{
	return m_pStatusBar;
}

void MainWindow::onHelpWhatsNew()
{
	QByteArray ba;
	ba.append("setSource qthelp://language/doc/rdo_studio_rus/html/rdo_whats_new.htm\n");
	g_pApp->callQtAssistant(ba);
}

void MainWindow::onHelpAbout()
{
	About dlg(this);
	dlg.exec();
}

void MainWindow::update_start()
{
	m_updateTimerID = startTimer(1000 / 30);
}

void MainWindow::update_stop()
{
	if (m_updateTimerID)
	{
		killTimer(m_updateTimerID);
		m_updateTimerID = 0;
	}
}

void MainWindow::timerEvent(QTimerEvent* event)
{
	parent_type::timerEvent(event);

	if (event->timerId() == m_updateTimerID)
	{
		update_stop();
		g_pModel->update();
		update_start();
	}
}

void MainWindow::showEvent(QShowEvent*)
{}

void MainWindow::hideEvent(QHideEvent*)
{}

void MainWindow::addSubWindow(QWidget* pWidget)
{
	ASSERT(pWidget);

	QList<QMdiSubWindow*> frameList = mdiArea->subWindowList();

	rbool maximized = frameList.empty();
	if (!maximized)
	{
		maximized = frameList.front()->isMaximized();
	}

	QMdiSubWindow* pFrame = mdiArea->addSubWindow(pWidget);

	IInit* pInitWidget = dynamic_cast<IInit*>(pWidget);
	if (pInitWidget)
	{
		pInitWidget->init();
	}
	pWidget->show();

	static const float sizeScale = 0.9f;
	QSize size(mdiArea->size());
	size.setWidth (int(float(size.width ()) * sizeScale));
	size.setHeight(int(float(size.height()) * sizeScale));
	pFrame->move  (frameList.size() * 4, frameList.size() * 4);
	pFrame->resize(size);

	if (maximized)
	{
		pFrame->showMaximized();
	}
}

void MainWindow::activateSubWindow(QWidget* pWidget)
{
	QMdiSubWindow* pSubWindow = dynamic_cast<QMdiSubWindow*>(pWidget);
	if (!pSubWindow)
		return;

	mdiArea->setActiveSubWindow(pSubWindow);
}

void MainWindow::connectOnActivateSubWindow(QObject* pObject)
{
	ASSERT(mdiArea);
	ASSERT(pObject);

	QObject::connect(mdiArea, SIGNAL(subWindowActivated(QMdiSubWindow*)), pObject, SLOT(onSubWindowActivated(QMdiSubWindow*)));
}

void MainWindow::onDockVisibleChanged(rbool visible)
{
	if (!visible)
		return;

	QDockWidget* pDock = dynamic_cast<QDockWidget*>(sender());
	ASSERT(pDock);

	rdo::gui::editor::Log* pLog = NULL;

	if (pDock == &getDockBuild())
	{
		pLog = &getDockBuild().getContext();
	}
	else if (pDock == &getDockFind())
	{
		pLog = &getDockFind().getContext();
	}

	if (!pLog)
		return;

	rdo::gui::model::TabCtrl* pEditorTab = g_pModel->getTab();
	if (pEditorTab)
	{
		for (int i = 0; i < pEditorTab->count(); ++i)
		{
			pEditorTab->getItemEdit(i)->setLog(*pLog);
		}
	}
}

void MainWindow::onToolBarModelOrientationChanged(Qt::Orientation orientation)
{
	m_pModelSpeedSlider->setOrientation(orientation);
}

void MainWindow::onMenuFileReopen(QAction* pAction)
{
	QString menuName = pAction->text();
	int pos = menuName.indexOf(' ');
	if (pos == -1)
		return;

	QString fileName = menuName.midRef(pos + 1).toString();
	if (!g_pModel->openModel(fileName) && g_pModel->isPrevModelClosed())
	{
		ReopenList::iterator it = std::find(m_reopenList.begin(), m_reopenList.end(), fileName);
		if (it != m_reopenList.end())
		{
			m_reopenList.erase(it);
		}
		updateMenuFileReopen();
	}
}

void MainWindow::insertMenuFileReopenItem(CREF(QString) item)
{
	if (!item.isEmpty())
	{
		ReopenList::iterator it = boost::range::find(m_reopenList, item);
		if (it != m_reopenList.end())
		{
			m_reopenList.erase(it);
		}

		m_reopenList.push_front(item);

		while (m_reopenList.size() > 10)
		{
			ReopenList::iterator it = m_reopenList.end();
			--it;
			m_reopenList.erase(it);
		}

		updateMenuFileReopen();
	}
}

void MainWindow::updateMenuFileReopen()
{
	menuFileReopen->clear();

	for (ReopenList::size_type reopenIndex = 0; reopenIndex < m_reopenList.size(); ++reopenIndex)
	{
		if (reopenIndex == 4)
		{
			menuFileReopen->addSeparator();
		}
		menuFileReopen->addAction(QString("%1. %2").arg(reopenIndex+1).arg(m_reopenList[reopenIndex]));
	}

	menuFileReopen->setEnabled(!menuFileReopen->isEmpty());

	saveMenuFileReopen();
}

void MainWindow::loadMenuFileReopen()
{
	m_reopenList.clear();

	QSettings settings;
	settings.beginGroup("reopen");

	QStringList groupList = settings.childKeys();
	std::vector<int> indexList;
	BOOST_FOREACH(const QString& index, groupList)
	{
		indexList.push_back(index.toInt());
	}
	std::sort(indexList.begin(), indexList.end());

	BOOST_FOREACH(int index, indexList)
	{
		QString value = settings.value(QString::number(index), QString()).toString();
		if (!value.isEmpty())
		{
			m_reopenList.push_back(value);
		}
	}

	settings.endGroup();
}

void MainWindow::saveMenuFileReopen() const
{
	QSettings settings;
	settings.beginGroup("reopen");

	ruint index = 1;
	BOOST_FOREACH(const QString& fileName, m_reopenList)
	{
		settings.setValue(QString::number(index++), fileName);
	}

	settings.endGroup();
}

void MainWindow::updateInsertMenu(rbool enabled)
{
	QList<QAction*> menuList = menuInsert->actions();
	BOOST_FOREACH(const QAction* pMenu, menuList)
	{
		if (pMenu->isSeparator())
			continue;

		QList<QAction*> itemList = pMenu->menu()->actions();
		BOOST_FOREACH(QAction* pItem, itemList)
		{
			pItem->setEnabled(enabled);
		}
	}
}

void MainWindow::onSubWindowActivated(QMdiSubWindow* window)
{
	if (window && m_pSubWindows.find(window) == m_pSubWindows.end())
	{
		addNewAction(window);
	}
	removeExcessActions();
	onUpdateActions(!mdiArea->subWindowList().empty());
}

void MainWindow::addNewAction(QMdiSubWindow* window)
{
	QList<QMdiSubWindow *> windowList = mdiArea->subWindowList();

	if (windowList.count() == 1)
		m_pSeparator = menuWindow->addSeparator();

	window->installEventFilter(this);

	QAction* pAction = menuWindow->addAction(window->windowTitle());
	m_pSubWindows[window] = pAction;
	//QObject::connect(pAction, &QAction::triggered, boost::bind(&QMdiArea::setActiveSubWindow, mdiArea, window));
}

void MainWindow::removeExcessActions()
{
	QList<QMdiSubWindow *> windowList = mdiArea->subWindowList();

	for (SubWindows::iterator it = m_pSubWindows.begin(); it != m_pSubWindows.end();)
	{
		if (!windowList.contains(it->first))
		{
			//QObject::disconnect(pAction, &QAction::triggered, boost::bind(&QMdiArea::setActiveSubWindow, mdiArea, window));
			menuWindow->removeAction(it->second);
			m_pSubWindows.erase(it++);
		}
		else
		{
			++it;
		}
	}

	if (m_pSeparator && windowList.empty())
	{
		menuWindow->removeAction(m_pSeparator);
		m_pSeparator = NULL;
	}
}

void MainWindow::onUpdateActions(rbool activated)
{
	updateAction(actWindowCascade       , activated, mdiArea, &QMdiArea::cascadeSubWindows);
	updateAction(actWindowTitleHorzontal, activated, mdiArea, &QMdiArea::tileSubWindows   );
}

bool MainWindow::eventFilter(QObject *target, QEvent *event)
{
	if (QMdiSubWindow* pSubWindow = static_cast<QMdiSubWindow*>(target))
	{
		if (event->type() == QEvent::WindowTitleChange && m_pSubWindows.find(pSubWindow) != m_pSubWindows.end())
		{
			m_pSubWindows[pSubWindow]->setText(pSubWindow->windowTitle());
			return true;
		}
	}

	return parent_type::eventFilter(target, event);
}
