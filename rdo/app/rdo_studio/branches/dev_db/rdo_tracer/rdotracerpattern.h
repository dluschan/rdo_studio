/*!
  \copyright (c) RDO-Team, 2003-2012
  \file      rdotracerpattern.h
  \author    ������� �����
  \date      11.03.2003
  \brief     
  \indent    4T
*/

#ifndef _RDO_STUDIO_TRACER_RDOTRACERPATTERN_H_
#define _RDO_STUDIO_TRACER_RDOTRACERPATTERN_H_

// ----------------------------------------------------------------------- INCLUDES
// ----------------------------------------------------------------------- SYNOPSIS
#include "app/rdo_studio/src/chart/chart_tree_item.h"
// --------------------------------------------------------------------------------

// --------------------------------------------------------------------------------
// -------------------- TracerPattern
// --------------------------------------------------------------------------------
enum TracerPatternKind {
	RDOPK_UNDEFINED = ~0,
	RDOPK_OPERATION = 0,
	RDOPK_IRREGULAREVENT,
	RDOPK_RULE,
	RDOPK_KEYBOARD
};

class TracerPattern : public ChartTreeItem
{
protected:
	TracerPatternKind patKind;
public:
	TracerPattern( const TracerPatternKind kind );
	virtual ~TracerPattern();

	tstring Name;
	TracerPatternKind getPatternKind() const { return patKind; };
};

#endif // _RDO_STUDIO_TRACER_RDOTRACERPATTERN_H_