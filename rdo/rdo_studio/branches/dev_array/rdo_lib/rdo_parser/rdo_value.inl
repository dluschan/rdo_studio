/*
 * copyright: (c) RDO-Team, 2009
 * filename : rdo_value.inl
 * author   : ������ ������
 * date     : 21.04.2010
 * bref     : 
 * indent   : 4T
 */

// ====================================================================== INCLUDES
// ====================================================================== SYNOPSIS
// ===============================================================================

OPEN_RDO_PARSER_NAMESPACE

inline RDOValue::RDOValue(CREF(rsint) value)
	: RDOParserSrcInfo(rdoRuntime::RDOValue(value).getAsString())
	, m_value(value)
	, m_type (rdo::Factory<RDOType__int>::create())
{}

inline RDOValue::RDOValue(CREF(ruint) value)
	: RDOParserSrcInfo(rdoRuntime::RDOValue(value).getAsString())
	, m_value(value)
	, m_type (rdo::Factory<RDOType__int>::create())
{}

inline RDOValue::RDOValue(CREF(double) value)
	: RDOParserSrcInfo(rdoRuntime::RDOValue(value).getAsString())
	, m_value(value )
	, m_type (rdo::Factory<RDOType__real>::create())
{}

inline RDOValue::RDOValue(CREF(tstring) value)
	: RDOParserSrcInfo(value   )
	, m_value         (value   )
	, m_type          (rdo::Factory<RDOType__string>::create())
{}

inline RDOValue::RDOValue(CREF(RDOValue) value)
	: RDOParserSrcInfo(value.src_info())
	, m_value         (value.value()   )
	, m_type          (value.type()    )
{}

CLOSE_RDO_PARSER_NAMESPACE
