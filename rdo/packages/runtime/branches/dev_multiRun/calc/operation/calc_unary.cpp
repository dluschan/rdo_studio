/*!
  \copyright (c) RDO-Team, 2011
  \file      calc_unary.cpp
  \authors   ���� ���������
  \authors   ������ ������ (rdo@rk9.bmstu.ru)
  \date      13.03.2011
  \brief     ������� ���������
  \indent    4T
*/

// ---------------------------------------------------------------------------- PCH
#include "simulator/runtime/pch/stdpch.h"
// ----------------------------------------------------------------------- INCLUDES
// ----------------------------------------------------------------------- SYNOPSIS
#include "simulator/runtime/calc/operation/calc_unary.h"
#include "simulator/runtime/rdo_runtime.h"
// --------------------------------------------------------------------------------

OPEN_RDO_RUNTIME_NAMESPACE

// --------------------------------------------------------------------------------
// -------------------- ������� ��������
// --------------------------------------------------------------------------------
RDOValue RDOCalcDoubleToIntByResult::doCalc(CREF(LPRDORuntime) pRuntime)
{
	RDOValue value = m_pOperation->calcValue(pRuntime);
	return m_round
		? value.getInt()
		: value;
}

// --------------------------------------------------------------------------------
// -------------------- RDOCalcInt (���������� � ������)
// --------------------------------------------------------------------------------
RDOValue RDOCalcInt::doCalc(CREF(LPRDORuntime) pRuntime)
{
	RDOValue res = m_pOperation->calcValue(pRuntime);
	return res > 0
		? RDOValue((int)(res.getDouble() + 0.5))
		: RDOValue((int)(res.getDouble() - 0.5));
}

CLOSE_RDO_RUNTIME_NAMESPACE