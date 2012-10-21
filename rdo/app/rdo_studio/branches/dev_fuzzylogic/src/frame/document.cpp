/*!
  \copyright (c) RDO-Team, 2003-2012
  \file      app/rdo_studio_mfc/src/frame/document.cpp
  \author    ������ ������ (rdo@rk9.bmstu.ru)
  \date      06.03.2003
  \brief     
  \indent    4T
*/

// ---------------------------------------------------------------------------- PCH
#include "app/rdo_studio_mfc/pch/stdpch.h"
// ----------------------------------------------------------------------- INCLUDES
// ----------------------------------------------------------------------- SYNOPSIS
#include "app/rdo_studio_mfc/src/frame/document.h"
#include "app/rdo_studio_mfc/src/model/model.h"
#include "app/rdo_studio_mfc/src/frame/manager.h"
// --------------------------------------------------------------------------------

#ifdef _DEBUG
#define new DEBUG_NEW
#undef THIS_FILE
static char THIS_FILE[] = __FILE__;
#endif

// --------------------------------------------------------------------------------
// -------------------- RDOStudioFrameDoc
// --------------------------------------------------------------------------------
IMPLEMENT_DYNCREATE(RDOStudioFrameDoc, CDocument)

BEGIN_MESSAGE_MAP(RDOStudioFrameDoc, CDocument)
END_MESSAGE_MAP()

RDOStudioFrameDoc::RDOStudioFrameDoc():
	CDocument(),
	frame( NULL )
{
}

RDOStudioFrameDoc::~RDOStudioFrameDoc()
{
}

BOOL RDOStudioFrameDoc::OnNewDocument()
{
	if ( !CDocument::OnNewDocument() ) return FALSE;
	return TRUE;
}

void RDOStudioFrameDoc::Serialize(CArchive& ar)
{
	if (ar.IsStoring()) {
	} else {
	}
}

#ifdef _DEBUG
void RDOStudioFrameDoc::AssertValid() const
{
	CDocument::AssertValid();
}

void RDOStudioFrameDoc::Dump(CDumpContext& dc) const
{
	CDocument::Dump(dc);
}
#endif