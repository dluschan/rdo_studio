#include "stdafx.h"
#include "rdoprocess_mainfrm.h"
#include "rdoprocess_app.h"
#include "rdoprocess_string.h"
#include "resource.h"

#ifdef _DEBUG
#define new DEBUG_NEW
#undef THIS_FILE
static char THIS_FILE[] = __FILE__;
#endif

// ----------------------------------------------------------------------------
// ---------- RDOPROCMainFrame
// ----------------------------------------------------------------------------
IMPLEMENT_DYNAMIC(RDOPROCMainFrame, CMDIFrameWnd)

BEGIN_MESSAGE_MAP(RDOPROCMainFrame, CMDIFrameWnd)
	//{{AFX_MSG_MAP(RDOPROCMainFrame)
	ON_WM_CREATE()
	ON_UPDATE_COMMAND_UI(ID_FLOW_CONNECTOR, OnUpdateFlowConnector)
	ON_UPDATE_COMMAND_UI(ID_FLOW_ROTATE, OnUpdateFlowRotate)
	ON_UPDATE_COMMAND_UI(ID_FLOW_SELECT, OnUpdateFlowSelect)
	ON_COMMAND(ID_FLOW_SELECT, OnFlowSelect)
	ON_COMMAND(ID_FLOW_ROTATE, OnFlowRotate)
	ON_COMMAND(ID_FLOW_CONNECTOR, OnFlowConnector)
	//}}AFX_MSG_MAP
END_MESSAGE_MAP()

static UINT indicators[] =
{
	ID_SEPARATOR,           // status line indicator
	ID_INDICATOR_CAPS,
	ID_INDICATOR_NUM,
	ID_INDICATOR_SCRL,
};

RDOPROCMainFrame::RDOPROCMainFrame()
{
}

RDOPROCMainFrame::~RDOPROCMainFrame()
{
}

int RDOPROCMainFrame::OnCreate(LPCREATESTRUCT lpCreateStruct)
{
	if (CMDIFrameWnd::OnCreate(lpCreateStruct) == -1)
		return -1;

	bool winxp = false;
	OSVERSIONINFO osv;
	osv.dwOSVersionInfoSize = sizeof( OSVERSIONINFO );
	if ( ::GetVersionEx( &osv ) ) {
		winxp = osv.dwMajorVersion >= 5 && osv.dwMinorVersion == 1;
	}
	m_wndToolBar.CreateEx( this, winxp ? 0 : TBSTYLE_FLAT, WS_CHILD | WS_VISIBLE | CBRS_TOP | CBRS_GRIPPER | CBRS_TOOLTIPS | CBRS_FLOATING | CBRS_SIZE_DYNAMIC );
	m_wndToolBar.LoadToolBar( IDR_MAINFRAME );

	if (!m_wndStatusBar.Create(this) ||
		!m_wndStatusBar.SetIndicators(indicators,
		  sizeof(indicators)/sizeof(UINT)))
	{
		TRACE0("Failed to create status bar\n");
		return -1;      // fail to create
	}

	projectBar.Create( rp::string::format( ID_DOCK_PROJECT_BAR ).c_str(), this, 0 );
	projectBar.SetBarStyle( projectBar.GetBarStyle() | CBRS_TOOLTIPS | CBRS_FLYBY | CBRS_SIZE_DYNAMIC );
	projectBar.EnableDocking( CBRS_ALIGN_ANY );

	m_wndToolBar.EnableDocking( CBRS_ALIGN_ANY );

	EnableDocking( CBRS_ALIGN_ANY );

	DockControlBar( &m_wndToolBar );
	DockControlBar( &projectBar, AFX_IDW_DOCKBAR_LEFT );

	return 0;
}

BOOL RDOPROCMainFrame::PreCreateWindow(CREATESTRUCT& cs)
{
	if( !CMDIFrameWnd::PreCreateWindow(cs) )
		return FALSE;
	// TODO: Modify the Window class or styles here by modifying
	//  the CREATESTRUCT cs

	return TRUE;
}

#ifdef _DEBUG
void RDOPROCMainFrame::AssertValid() const
{
	CMDIFrameWnd::AssertValid();
}

void RDOPROCMainFrame::Dump(CDumpContext& dc) const
{
	CMDIFrameWnd::Dump(dc);
}

#endif

void RDOPROCMainFrame::OnUpdateFlowSelect( CCmdUI* pCmdUI )
{
	pCmdUI->Enable( rpapp.project.hasChild() );
}

void RDOPROCMainFrame::OnUpdateFlowConnector( CCmdUI* pCmdUI )
{
	pCmdUI->Enable( rpapp.project.hasChild() );
}

void RDOPROCMainFrame::OnUpdateFlowRotate( CCmdUI* pCmdUI )
{
	pCmdUI->Enable( rpapp.project.hasChild() );
}

void RDOPROCMainFrame::OnFlowSelect()
{
	rpapp.project.setFlowState( RDOPROCProject::flow_select );
}

void RDOPROCMainFrame::OnFlowConnector()
{
	rpapp.project.setFlowState( RDOPROCProject::flow_connector );
}

void RDOPROCMainFrame::OnFlowRotate()
{
	rpapp.project.setFlowState( RDOPROCProject::flow_rotate );
}
