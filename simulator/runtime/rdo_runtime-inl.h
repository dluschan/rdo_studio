// ----------------------------------------------------------------------- INCLUDES
// ----------------------------------------------------------------------- SYNOPSIS
#include "simulator/runtime/namespace.h"
// --------------------------------------------------------------------------------

OPEN_RDO_RUNTIME_NAMESPACE

// --------------------------------------------------------------------------------
// -------------------- RDOResults
// --------------------------------------------------------------------------------
template<class T>
inline RDOResults& RDOResults::operator<< (const T& value)
{
    getOStream() << value;
    return *this;
}

CLOSE_RDO_RUNTIME_NAMESPACE