/*!
  \copyright (c) RDO-Team, 2011
  \file      std_fun.inl
  \author    ����� ������� (dluschan@rk9.bmstu.ru)
  \date      31.07.2011
  \brief     ����������� ������� �����
  \indent    4T
*/

// ----------------------------------------------------------------------- INCLUDES
// ----------------------------------------------------------------------- SYNOPSIS
#include "simulator/runtime/rdocalc.h"
#include "simulator/runtime/rdo_runtime.h"
// --------------------------------------------------------------------------------

OPEN_RDO_RUNTIME_NAMESPACE

// --------------------------------------------------------------------------------
// -------------------- RDOFunCalcStd
// --------------------------------------------------------------------------------
template <class F>
inline RDOFunCalcStd<F>::RDOFunCalcStd(CREF(function_type) pFunction)
	: m_pFunction(pFunction)
{}

template <class F>
REF(RDOValue) RDOFunCalcStd<F>::doCalc(CREF(LPRDORuntime) pRuntime)
{
	calc<F::arity>(pRuntime);
	return m_value;
}

template <>
void calc<1>(CREF(LPRDORuntime) pRuntime)
{
	m_value = m_pFunction(getParam<F::arg1_type>(pRuntime, 0));
}

template <>
void calc<2>(CREF(LPRDORuntime) pRuntime)
{
	m_value = m_pFunction(getParam<F::arg1_type>(pRuntime, 0), getParam<F::arg2_type>(pRuntime, 1));
}

template <>
double getParam<double>(CREF(LPRDORuntime) pRuntime, ruint paramNumber)
{
	return pRuntime->getFuncArgument(paramNumber).getDouble();
}

template <>
int getParam<int>(CREF(LPRDORuntime) pRuntime, ruint paramNumber)
{
	return pRuntime->getFuncArgument(paramNumber).getInt();
}

CLOSE_RDO_RUNTIME_NAMESPACE
