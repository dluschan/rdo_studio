/*!
  \copyright (c) RDO-Team, 2011
  \file      rdo_pattern.h
  \authors   ������ ������ (rdo@rk9.bmstu.ru)
  \authors   ����� ������� (dluschan@rk9.bmstu.ru)
  \date      13.04.2008
  \brief     �������� �������� ������ ��� �������� ���� ����� ����������� � �������
  \indent    4T
*/

#ifndef _LIB_RUNTIME_PATTERN_H_
#define _LIB_RUNTIME_PATTERN_H_

// ----------------------------------------------------------------------- INCLUDES
// ----------------------------------------------------------------------- SYNOPSIS
#include "rdo_lib/rdo_runtime/rdotrace.h"
#include "rdo_lib/rdo_runtime/rdo_resource.h"
#include "rdo_lib/rdo_runtime/rdocalc.h"
#include "rdo_lib/rdo_runtime/rdo_runtime.h"
// --------------------------------------------------------------------------------

OPEN_RDO_RUNTIME_NAMESPACE

class RDOEvent;
class RDORule;
class RDOKeyboard;

/*!
  \class     RDOPattern
  \brief     ������� ����� ��� ��������� ����������� � �������
*/
OBJECT(RDOPattern)
	IS  INSTANCE_OF(RDORuntimeObject  )
	AND INSTANCE_OF(RDOTraceableObject)
{
DECLARE_FACTORY(RDOPattern);

public:
	void addPreSelectRelRes(CREF(LPRDOCalc) pCalc);

protected:
	RDOPattern(rbool trace);
	virtual ~RDOPattern();

	typedef  std::vector<LPRDOCalc>                   CalcList;
	typedef  std::vector<RDOResource::ConvertStatus>  ConvertStatusList;

	CalcList m_preSelectRelRes;

	void preSelectRelRes(CREF(LPRDORuntime) pRuntime);

	void  runCalcs    (REF(CalcList) calcList, CREF(LPRDORuntime) pRuntime);
	rbool runCalcsBool(REF(CalcList) calcList, CREF(LPRDORuntime) pRuntime);
};

/*!
  \class     RDOPatternEvent
  \brief     ������� �������
*/
CLASS(RDOPatternEvent): INSTANCE_OF(RDOPattern)
{
DECLARE_FACTORY(RDOPatternEvent);
friend class RDOEvent;

public:
	void addConvertorStatus(RDOResource::ConvertStatus status);

	void addConvertorCalc  (CREF(LPRDOCalc) pCalc);
	void addEraseCalc      (CREF(LPRDOCalc) pCalc);

	void convertEvent(CREF(LPRDORuntime) pRuntime);
	void convertErase(CREF(LPRDORuntime) pRuntime);

	double getNextTimeInterval(CREF(LPRDORuntime) pRuntime);

	LPIEvent createActivity(LPIBaseOperationContainer parent, CREF(LPRDORuntime) pRuntime, CREF(tstring) oprName);

private:
	RDOPatternEvent(rbool trace);
	virtual ~RDOPatternEvent();

	LPRDOCalc         m_timeCalc;
	CalcList          m_convertor;
	ConvertStatusList m_convertorStatus;
	CalcList          m_erase;
};
DECLARE_POINTER(RDOPatternEvent);

/*!
  \class     RDOPatternRule
  \brief     ������� ����������� ���� rule
*/
CLASS(RDOPatternRule): INSTANCE_OF(RDOPattern)
{
DECLARE_FACTORY(RDOPatternRule);
friend class RDORule;

public:
	void addConvertorStatus(RDOResource::ConvertStatus status);

	void addChoiceFromCalc (CREF(LPRDOCalc) pCalc);
	void addConvertorCalc  (CREF(LPRDOCalc) pCalc);
	void addEraseCalc      (CREF(LPRDOCalc) pCalc);

	void convertRule (CREF(LPRDORuntime) pRuntime);
	void convertErase(CREF(LPRDORuntime) pRuntime);

	rbool choiceFrom (CREF(LPRDORuntime) pRuntime);

	LPIRule createActivity(LPIBaseOperationContainer parent, CREF(LPRDORuntime) pRuntime, CREF(tstring) _oprName);
	LPIRule createActivity(LPIBaseOperationContainer parent, CREF(LPRDORuntime) pRuntime, CREF(LPRDOCalc) condition, CREF(tstring) _oprName);

private:
	RDOPatternRule(rbool trace);
	virtual ~RDOPatternRule();

	CalcList          m_choiceFrom;
	CalcList          m_convertor;
	ConvertStatusList m_convertorStatus;
	CalcList          m_erase;
};
DECLARE_POINTER(RDOPatternRule);

/*!
  \class     RDOPatternOperation
  \brief     ������� ����������� ���� operation
*/
CLASS(RDOPatternOperation): INSTANCE_OF(RDOPattern)
{
DECLARE_FACTORY(RDOPatternOperation);
friend class RDOOperation;

public:
	void addConvertorBeginStatus(RDOResource::ConvertStatus status);
	void addConvertorEndStatus  (RDOResource::ConvertStatus status);

	void addChoiceFromCalc      (CREF(LPRDOCalc) pCalc);
	void addConvertorBeginCalc  (CREF(LPRDOCalc) pCalc);
	void addConvertorEndCalc    (CREF(LPRDOCalc) pCalc);
	void addEraseBeginCalc      (CREF(LPRDOCalc) pCalc);
	void addEraseEndCalc        (CREF(LPRDOCalc) pCalc);
	void setTime                (CREF(LPRDOCalc) pCalc);

	void convertBegin           (CREF(LPRDORuntime) pRuntime);
	void convertEnd             (CREF(LPRDORuntime) pRuntime);
	void convertBeginErase      (CREF(LPRDORuntime) pRuntime);
	void convertEndErase        (CREF(LPRDORuntime) pRuntime);

	rbool  choiceFrom           (CREF(LPRDORuntime) pRuntime);
	double getNextTimeInterval  (CREF(LPRDORuntime) pRuntime);

	LPIOperation createActivity(LPIBaseOperationContainer parent, CREF(LPRDORuntime) pRuntime, CREF(tstring) _oprName);
	LPIOperation createActivity(LPIBaseOperationContainer parent, CREF(LPRDORuntime) pRuntime, CREF(LPRDOCalc) condition, CREF(tstring) _oprName);

protected:
	RDOPatternOperation(rbool trace);
	virtual ~RDOPatternOperation();

private:
	LPRDOCalc         m_timeCalc;
	CalcList          m_choiceFrom;

	CalcList          m_convertorBegin;
	ConvertStatusList m_convertorBeginStatus;
	CalcList          m_eraseBegin;

	CalcList          m_convertorEnd;
	ConvertStatusList m_convertorEndStatus;
	CalcList          m_eraseEnd;
};
DECLARE_POINTER(RDOPatternOperation);

/*!
  \class     RDOPatternKeyboard
  \brief     ������� ����������� ���� keyboard
*/
CLASS(RDOPatternKeyboard): INSTANCE_OF(RDOPatternOperation)
{
DECLARE_FACTORY(RDOPatternKeyboard);
public:
	LPIKeyboard createActivity(LPIBaseOperationContainer parent, CREF(LPRDORuntime) pRuntime, CREF(tstring) _oprName);
	LPIKeyboard createActivity(LPIBaseOperationContainer parent, CREF(LPRDORuntime) pRuntime, CREF(LPRDOCalc) condition, CREF(tstring) _oprName);

private:
	RDOPatternKeyboard(rbool trace);
	virtual ~RDOPatternKeyboard();
};
DECLARE_POINTER(RDOPatternKeyboard);

CLOSE_RDO_RUNTIME_NAMESPACE

#include "rdo_lib/rdo_runtime/rdo_pattern.inl"

#endif // _LIB_RUNTIME_PATTERN_H_
