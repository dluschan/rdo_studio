#ifndef RDOSTUDIOMODELDOC_H
#define RDOSTUDIOMODELDOC_H

#if _MSC_VER > 1000
#pragma once
#endif

#include "rdostudioeditbasedoc.h"

// ----------------------------------------------------------------------------
// ---------- RDOStudioModelDoc
// ----------------------------------------------------------------------------
class RDOStudioModelView;

class RDOStudioModelDoc: public RDOStudioEditBaseDoc
{
friend class RDOStudioModel;

DECLARE_DYNCREATE(RDOStudioModelDoc)

private:
	std::string name;
	bool running;

	RDOStudioModelDoc();

public:
	//{{AFX_VIRTUAL(RDOStudioModelDoc)
	public:
	virtual BOOL OnNewDocument();
	virtual void Serialize(CArchive& ar);
	virtual void OnCloseDocument();
	protected:
	virtual BOOL SaveModified();
	//}}AFX_VIRTUAL

protected:
	//{{AFX_MSG(RDOStudioModelDoc)
	//}}AFX_MSG
	DECLARE_MESSAGE_MAP()

public:
	virtual ~RDOStudioModelDoc();

	virtual void updateModify();

	RDOStudioModelView* getView() const;

	std::string getName() const;
	void setName( const std::string& str );

	bool isModify();
	bool isRunning() const { return running; };

#ifdef _DEBUG
	virtual void AssertValid() const;
	virtual void Dump(CDumpContext& dc) const;
#endif

};

//{{AFX_INSERT_LOCATION}}

#endif // RDOSTUDIOMODELDOC_H
