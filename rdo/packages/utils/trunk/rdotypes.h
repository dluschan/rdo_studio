/*!
  \copyright (c) RDO-Team, 2011
  \file      rdotypes.h
  \authors   ������ ������ (rdo@rk9.bmstu.ru)
  \authors   ��������� ������� (lord.tiran@gmail.com)
  \date      18.04.2009
  \brief     ���������� ������� �����
  \indent    4T
*/

#ifndef _UTILS_RDOTYPES_H_
#define _UTILS_RDOTYPES_H_

// ----------------------------------------------------------------------- PLATFORM
#include "utils/platform.h"
// ----------------------------------------------------------------------- INCLUDES
#ifdef COMPILER_VISUAL_STUDIO
#   include <tchar.h>
#endif // COMPILER_VISUAL_STUDIO
#ifdef COMPILER_GCC
#   include <stdint.h>
#   define _T(x) x
#endif // COMPILER_GCC

#include <list>
#include <string>
// ----------------------------------------------------------------------- SYNOPSIS
// --------------------------------------------------------------------------------

//! ��� �������
typedef  char                        tchar;

//! ��� ������
typedef  std::basic_string<tchar>    tstring;

//! ANSI-������
typedef  std::basic_string<char>     astring;

//! Unicode-������
typedef  std::basic_string<wchar_t>  wstring;

//! ��������� ���
typedef  bool                        rbool;

//! ����� �������� ���
typedef  signed int                  rsint;

//! ����� ����������� ���
typedef  unsigned int                ruint;

//! ����� �������� 32-� ������ ���
#ifdef COMPILER_VISUAL_STUDIO
	typedef  long                    rsint32;
#elif defined COMPILER_GCC
	typedef  int32_t                 rsint32;
#endif

//! ����� ����������� 32-� ������ ���
#ifdef COMPILER_VISUAL_STUDIO
	typedef  unsigned long           ruint32;
#elif defined COMPILER_GCC
	typedef  uint32_t                ruint32;
#endif

//! ����� �������� 64-� ������ ���
#ifdef COMPILER_VISUAL_STUDIO
	typedef  signed long long int    rsint64;
#elif defined COMPILER_GCC
	typedef  int64_t                 rsint64;
#endif

//! ����� ����������� 64-� ������ ���
#ifdef COMPILER_VISUAL_STUDIO
	typedef  unsigned long long int  ruint64;
#elif defined COMPILER_GCC
	typedef  uint64_t                ruint64;
#endif

//! ��� �����
typedef  unsigned char               rbyte;

typedef std::list<tstring>           rtstringList;

#endif // _UTILS_RDOTYPES_H_
