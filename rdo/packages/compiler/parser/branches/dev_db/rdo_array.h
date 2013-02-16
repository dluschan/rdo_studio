/*!
  \copyright (c) RDO-Team, 2011
  \file      simulator/compiler/parser/rdo_array.h
  \author    ������ ������
  \date      
  \brief     
  \indent    4T
*/

#ifndef _RDOPARSER_VALUE_ARRAY_H_
#define _RDOPARSER_VALUE_ARRAY_H_

// ----------------------------------------------------------------------- INCLUDES
// ----------------------------------------------------------------------- SYNOPSIS
#include "simulator/compiler/parser/rdo_value.h"
#include "simulator/compiler/parser/type/array.h"
#include "simulator/runtime/type/type_db_i.h"
// --------------------------------------------------------------------------------

OPEN_RDO_PARSER_NAMESPACE

// --------------------------------------------------------------------------------
// -------------------- RDOArrayValue
// --------------------------------------------------------------------------------
OBJECT(RDOArrayValue) IS INSTANCE_OF(RDOParserSrcInfo)
AND INSTANCE_OF(rdo::runtime::ISerializeTypeInDB)
{
DECLARE_FACTORY(RDOArrayValue);
public:
	typedef std::vector<LPRDOValue> Container;

	void insertItem(CREF(LPRDOValue) pValue);

	CREF(LPRDOArrayType)          getArrayType      () const;
	 REF(LPRDOArrayType)          getArrayType      ();
	rdo::runtime::RDOValue        getRArray         () const;
	rdo::runtime::LPRDOArrayValue createRuntimeValue() const;
	tstring                       getAsString       () const;
	CREF(Container)               getContainer      () const;

	virtual void serializeInDB(REF(IDB) db) const;

private:
	RDOArrayValue(CREF(LPRDOArrayType) pArrayType);
	virtual ~RDOArrayValue();

	Container      m_container;
	LPRDOArrayType m_pArrayType;
};

CLOSE_RDO_PARSER_NAMESPACE

#endif // _RDOPARSER_VALUE_ARRAY_H_
