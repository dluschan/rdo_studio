/*!
  \copyright (c) RDO-Team, 2011
  \file      rdo_logic_dptprior.inl
  \author    Лущан Дмитрий (dluschan@rk9.bmstu.ru)
  \date      04.11.2009
  \brief     DPTPrior
  \indent    4T
*/

// ----------------------------------------------------------------------- INCLUDES
// ----------------------------------------------------------------------- SYNOPSIS
#include "simulator/runtime/rdo_runtime.h"
#include "simulator/runtime/rdo_priority.h"
// --------------------------------------------------------------------------------

OPEN_RDO_RUNTIME_NAMESPACE

// --------------------------------------------------------------------------------
// -------------------- RDOOrderDPTPrior
// --------------------------------------------------------------------------------
inline LPIBaseOperation RDOOrderDPTPrior::sort(CREF(LPRDORuntime) pRuntime, REF(BaseOperationList) container)
{
	BaseOperationList priorContainer;
	STL_FOR_ALL_CONST(container, it)
	{
		if (it->query_cast<IBaseOperation>()->onCheckCondition(pRuntime))
		{
			priorContainer.push_back(*it);
		}
	}

	if (priorContainer.empty())
		return NULL;

	STL_FOR_ALL_CONST(priorContainer, it)
	{
		LPIPriority pPattern = *it;
		if (pPattern)
		{
			LPRDOCalc pPriorCalc = pPattern->getPrior();
			if (pPriorCalc)
			{
				RDOValue value = pPriorCalc->calcValue(pRuntime);
				if (value < 0.0 || value > 1.0)
				{
					pRuntime->error().push(rdo::format("Приоритет активности вышел за пределы диапазона [0..1]: %s", value.getAsString().c_str()), pPriorCalc->srcInfo());
				}
			}
		}
	}
	std::sort(priorContainer.begin(), priorContainer.end(), RDODPTActivityCompare(pRuntime));
	return priorContainer.front();
}

// --------------------------------------------------------------------------------
// -------------------- RDODPTPrior
// --------------------------------------------------------------------------------
inline RDODPTPrior::RDODPTPrior(CREF(LPRDORuntime) pRuntime, LPIBaseOperationContainer pParent)
	: RDOLogicDPTPrior(pRuntime, pParent)
{
	pRuntime->getFreeDPTId();
}

inline RDODPTPrior::~RDODPTPrior()
{}

CLOSE_RDO_RUNTIME_NAMESPACE
