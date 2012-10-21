#ifndef _PR_METHOD_STDAFX_H_
#define _PR_METHOD_STDAFX_H_

#define VC_EXTRALEAN		// Exclude rarely-used stuff from Windows headers

#if _MSC_VER > 1200
#ifndef WINVER				// Allow use of features specific to Windows XP or later.
#define WINVER 0x0501		// Change this to the appropriate value to target other versions of Windows.
#endif
#endif

#include <afxwin.h>         // MFC core and standard components
#include <afxext.h>         // MFC extensions
#include <afxdtctl.h>		// MFC support for Internet Explorer 4 Common Controls
#ifndef _AFX_NO_AFXCMN_SUPPORT
#include <afxcmn.h>			// MFC support for Windows Common Controls
#endif // _AFX_NO_AFXCMN_SUPPORT

#pragma warning( disable : 4786 )

#include <math.h>
#include <map>
#include <vector>
#include <list>
#include <algorithm>

#include "utils/rdotypes.h"
#include "utils/rdomacros.h"
#include "app/rdo_studio_mfc/rdo_process/rp_misc/rdoprocess_string.h"

#endif // _PR_METHOD_STDAFX_H_