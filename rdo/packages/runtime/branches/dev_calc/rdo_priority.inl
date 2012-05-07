/*!
  \copyright (c) RDO-Team, 2011
  \file      rdo_priority.inl
  \authors   ������ ������ (rdo@rk9.bmstu.ru)
  \authors   ����� ������� (dluschan@rk9.bmstu.ru)
  \date      03.10.2009
  \brief     �������� ���������� �����������. ������������ ��� ���������� ��.
  \indent    4T
*/

// ----------------------------------------------------------------------- INCLUDES
// ----------------------------------------------------------------------- SYNOPSIS
#include "utils/rdomacros.h"
#include "simulator/runtime/namespace.h"
// --------------------------------------------------------------------------------

OPEN_RDO_RUNTIME_NAMESPACE

// --------------------------------------------------------------------------------
// -------------------- RDOPatternPrior
// --------------------------------------------------------------------------------
inline RDOPatternPrior::RDOPatternPrior()
{}

inline RDOPatternPrior::~RDOPatternPrior()
{}

inline LPRDOCalc RDOPatternPrior::getPrior()
{
	return m_pPrior; 
}

inline rbool RDOPatternPrior::setPrior(CREF(LPRDOCalc) pPrior)
{
	m_pPrior = pPrior;
	return true;
}

// --------------------------------------------------------------------------------
// -------------------- RDODPTActivityCompare
// --------------------------------------------------------------------------------
inline RDODPTActivityCompare::RDODPTActivityCompare(CREF(LPRDORuntime) pRuntime)
	: m_pRuntime(pRuntime)
{}

inline rbool RDODPTActivityCompare::operator() (CREF(LPIBaseOperation) pOpr1, CREF(LPIBaseOperation) pOpr2)
{
	LPIPriority pPattern1 = pOpr1;
	LPIPriority pPattern2 = pOpr2;
	if (pPattern1 && pPattern2)
	{
		LPRDOCalc pPrior1 = pPattern1->getPrior();
		LPRDOCalc pPrior2 = pPattern2->getPrior();

		RDOValue value1;
		if (pPrior1)
		{
			pPrior1->calcValue(m_pRuntime);
			value1 = m_pRuntime->stack().pop();
		}
		else
		{
			value1 = RDOValue(0.0);
		}

		RDOValue value2;
		if (pPrior2)
		{
			pPrior2->calcValue(m_pRuntime);
			value2 = m_pRuntime->stack().pop();
		}
		else
		{
			RDOValue(0.0);
		}

		return value1 > value2;
	}
	return false;
}

CLOSE_RDO_RUNTIME_NAMESPACE
