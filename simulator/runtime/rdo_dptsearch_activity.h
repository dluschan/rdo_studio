#pragma once

// ----------------------------------------------------------------------- INCLUDES
// ----------------------------------------------------------------------- SYNOPSIS
#include "simulator/runtime/rdo_rule_i.h"
#include "simulator/runtime/rdo_dptsearch_activity_i.h"
#include "simulator/runtime/calc/calc_base.h"
#include "simulator/runtime/rdotrace.h"
// --------------------------------------------------------------------------------

OPEN_RDO_RUNTIME_NAMESPACE

class RDODPTSearchActivity: public IDPTSearchActivity, public RDOTraceableObject
{
DECLARE_FACTORY(RDODPTSearchActivity);
private:
	RDODPTSearchActivity(const LPIRule& rule, ValueTime valueTime, const LPRDOCalc& pCost);

	LPIRule                        m_rule;
	LPRDOCalc                      m_pCost;
	IDPTSearchActivity::ValueTime  m_valueTime;

	DECLARE_IDPTSearchActivity;
};

CLOSE_RDO_RUNTIME_NAMESPACE
