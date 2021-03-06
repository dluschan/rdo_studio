/*!
  \copyright (c) RDO-Team, 2013
  \file      app/rdo_studio/plugins/game5/src/plugin_game5_graph_dialog.h
  \author    Чернов Алексей (ChernovAlexeyOlegovich@gmail.com)
  \date      22.09.2013
  \brief     
  \indent    4T
*/

#ifndef _RDO_PLUGIN_GAME5_GRAPH_DIALOG_H_
#define _RDO_PLUGIN_GAME5_GRAPH_DIALOG_H_

// ----------------------------------------------------------------------- INCLUDES
#include "utils/src/common/warning_disable.h"
#include <vector>
#include "ui_plugin_game5_graph_dialog.h"
#include "utils/src/common/warning_enable.h"
// ----------------------------------------------------------------------- SYNOPSIS
#include "app/rdo_studio/plugins/game5/src/graph_node.h"
// --------------------------------------------------------------------------------

class PluginGame5GraphDialog
	: public QDialog
	, public Ui_PluginGame5GraphDialog
{

Q_OBJECT
public:
	PluginGame5GraphDialog(QWidget* parent);
	~PluginGame5GraphDialog();

	void updateGraph(const std::vector<unsigned int>& startBoardState);

public slots:
	void onPluginAction(const std::vector<unsigned int>& boardState);
	void emitShowNodeInfoDlg();

signals:
	void updateNodeInfoDlg(GraphNode* node);
	void showNodeInfoDlg  ();

private:
	struct UnbuiltRange
	{
		unsigned int firstNode;
		unsigned int range;
	};

	struct SortStruct
	{
		SortStruct(PluginGame5GraphDialog* pDlg) : m_pDlg(pDlg) {};
		PluginGame5GraphDialog* m_pDlg;

		bool operator() (int i, int j)
		{
			const int iParentOLO = m_pDlg->m_graphNodeList[i]->getParentGraphNode()->getGraphOnLevelOrder();
			const int jParentOLO = m_pDlg->m_graphNodeList[j]->getParentGraphNode()->getGraphOnLevelOrder();

			return iParentOLO < jParentOLO;
		}
	};

	QString m_traceTimeStamp;
	GraphNode* m_clickedNode;
	std::vector<GraphNode*> m_graphNodeList;
	int m_nodeWidth;
	int m_nodeHeight;

	void quickSort(std::vector<int>& vector);

	std::vector<int> getSolutionNodes() const;
	void updateCheckedNode(GraphNode* node);
	QString     getTraceTimeStamp() const;
	QString     getTraceFile() const;
	QStringList parseTrace() const;

	QString getTraceInfo() const;
	int parseTraceInfo(const QString& key) const;
};

#endif // _RDO_PLUGIN_GAME5_GRAPH_DIALOG_H_
