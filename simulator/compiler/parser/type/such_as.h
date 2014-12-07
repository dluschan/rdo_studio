#ifndef _RDOPARSER_TYPE_SUCH_AS_H_
#define _RDOPARSER_TYPE_SUCH_AS_H_

// ----------------------------------------------------------------------- INCLUDES
// ----------------------------------------------------------------------- SYNOPSIS
#include "simulator/compiler/parser/type/info.h"
#include "simulator/compiler/parser/param.h"
// --------------------------------------------------------------------------------

OPEN_RDO_PARSER_NAMESPACE

// --------------------------------------------------------------------------------
// -------------------- RDOTypeParamSuchAs
// --------------------------------------------------------------------------------
class RDOTypeParamSuchAs: public TypeInfo
{
DECLARE_FACTORY(RDOTypeParamSuchAs);
public:
	const LPRDOParam& getParam() const;

private:
	RDOTypeParamSuchAs(const LPRDOParam& pParam);
	virtual ~RDOTypeParamSuchAs();

	LPRDOParam m_pParam;
};
DECLARE_POINTER(RDOTypeParamSuchAs);

CLOSE_RDO_PARSER_NAMESPACE

#endif // _RDOPARSER_TYPE_SUCH_AS_H_
