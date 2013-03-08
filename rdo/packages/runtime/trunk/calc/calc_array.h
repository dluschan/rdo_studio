/*!
  \copyright (c) RDO-Team, 2011
  \file      calc_array.h
  \author    ������ ������
  \date      03.12.2010
  \brief     ���������� ��� ������ - ������
  \indent    4T
*/

#ifndef _LIB_RUNTIME_CALC_ARRAY_H_
#define _LIB_RUNTIME_CALC_ARRAY_H_

// ----------------------------------------------------------------------- INCLUDES
// ----------------------------------------------------------------------- SYNOPSIS
#include "simulator/runtime/calc/calc_base.h"
#include "simulator/runtime/rdo_runtime.h"
// --------------------------------------------------------------------------------

OPEN_RDO_RUNTIME_NAMESPACE

//! ������ �������
CALC(RDOCalcArraySize)
{
DECLARE_FACTORY(RDOCalcArraySize)
private:
	RDOCalcArraySize(CREF(LPRDOCalc) pCalc);

	LPRDOCalc m_pCalc;

	DECLARE_ICalc;
};

//! ���������� ������� �������
CALC(RDOCalcArrayItem)
{
DECLARE_FACTORY(RDOCalcArrayItem)
private:
	RDOCalcArrayItem(CREF(LPRDOCalc) pArray, CREF(LPRDOCalc) pArrayInd);

	LPRDOCalc m_pArray;
	LPRDOCalc m_pArrayInd;

	DECLARE_ICalc;
};

//! ������������� ������� �������
CALC(RDOCalcSetArrayItem)
{
	DECLARE_FACTORY(RDOCalcSetArrayItem)
private:
	RDOCalcSetArrayItem(CREF(LPRDOCalc) pArray, CREF(LPRDOCalc) pArrayInd, CREF(LPRDOCalc) pSetItem);

	LPRDOCalc m_pArray;
	LPRDOCalc m_pArrayInd;
	LPRDOCalc m_pSetItem;

	DECLARE_ICalc;
};

CLOSE_RDO_RUNTIME_NAMESPACE

#endif // _LIB_RUNTIME_CALC_ARRAY_H_
