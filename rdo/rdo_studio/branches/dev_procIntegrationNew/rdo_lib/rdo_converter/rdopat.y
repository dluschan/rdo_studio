/*
 * copyright: (c) RDO-Team, 2009
 * filename : rdopat.y
 * author   : �������� ����, ������ ������, ����� �������
 * date     : 12.07.2010
 * bref     : �������� PAT - �������� �������� ����������� ������
 * indent   : 4T
 */

%{
#define YYPARSE_PARAM lexer
#define YYLEX_PARAM lexer
%}

%pure-parser

%token RDO_Resource_type				257
%token RDO_permanent					258
%token RDO_Parameters					259
%token RDO_integer						260
%token RDO_real							261
%token RDO_End							262
%token RDO_temporary					263
%token RDO_IDENTIF						264
%token RDO_INT_CONST					265
%token RDO_REAL_CONST					266
%token RDO_such_as						267
%token RDO_dblpoint						268
%token RDO_Resources					269
%token RDO_trace						270
%token RDO_no_trace						271
%token RDO_IDENTIF_COLON				272
%token RDO_Constant						273
%token RDO_Body							274
%token RDO_Function						275
%token RDO_Type							276
%token RDO_algorithmic					277
%token RDO_table						278
%token RDO_list							279
%token RDO_Exist						281
%token RDO_Not_Exist					282
%token RDO_For_All						283
%token RDO_Not_For_All					284
%token RDO_neq							285
%token RDO_leq							286
%token RDO_geq							287
%token RDO_NoCheck						288
%token RDO_Calculate_if					289
%token RDO_or							290
%token RDO_and							291
%token RDO_Sequence						292
%token RDO_uniform						293
%token RDO_exponential					294
%token RDO_normal						295
%token RDO_by_hist						296
%token RDO_enumerative					297

%token RDO_Pattern						298
%token RDO_operation					299
%token RDO_irregular_event				300
%token RDO_rule							301
%token RDO_keyboard						302
%token RDO_Relevant_resources			303
%token RDO_Keep							304
%token RDO_Create						305
%token RDO_Erase						306
%token RDO_NonExist						307
%token RDO_IDENTIF_NoChange				308
%token RDO_Time							309
%token RDO_Choice						310
%token RDO_from							311
%token RDO_first						312
%token RDO_Convert_begin				313
%token RDO_Convert_end					314
%token RDO_Convert_rule					315
%token RDO_Convert_event				316
%token RDO_with_max						317
%token RDO_with_min						318
%token RDO_set							319
%token RDO_IDENTIF_NoChange_NoChange	320
%token RDO_Operations					321
	
%token RDO_Results						322
%token RDO_watch_par					323
%token RDO_watch_state					324
%token RDO_watch_quant					325
%token RDO_watch_value					326
%token RDO_get_value					327

%token RDO_Model_name					328
%token RDO_Resource_file				329
%token RDO_OprIev_file					330
%token RDO_Frame_file					331
%token RDO_Statistic_file				332
%token RDO_Results_file					333
%token RDO_Trace_file					334
%token RDO_Show_mode					335
%token RDO_Frame_number					336
%token RDO_Show_rate					337
%token RDO_Run_StartTime				338
%token RDO_Trace_StartTime				339
%token RDO_Trace_EndTime				340
%token RDO_Terminate_if					341
%token RDO_Break_point					342
%token RDO_Seed							343
%token RDO_NoShow						344
%token RDO_Monitor						345
%token RDO_Animation					346
%token RDO_NoChange						347

%token RDO_Decision_point				348
%token RDO_search						349
%token RDO_trace_stat					350
%token RDO_trace_tops					351
%token RDO_trace_all					352
%token RDO_Condition					353
%token RDO_Term_condition				354
%token RDO_Evaluate_by					355
%token RDO_Compare_tops					356
%token RDO_NO							357
%token RDO_YES							358
%token RDO_Activities					359
%token RDO_value_before					360
%token RDO_value_after					361
%token RDO_some							362
%token RDO_Process						363
%token RDO_SEIZE						364
%token RDO_GENERATE						365
%token RDO_TERMINATE					366
%token RDO_ADVANCE						367
%token RDO_RELEASE						368
%token RDO_if							369
%token RDO_result						370
%token RDO_CF							371
%token RDO_Priority						372
%token RDO_prior						373
%token RDO_Parent						374

%token RDO_Frame						400
%token RDO_Show_if						401
%token RDO_Back_picture					402
%token RDO_Show							403
%token RDO_frm_cell						404
%token RDO_text							405
%token RDO_bitmap						406
%token RDO_s_bmp						407
%token RDO_rect							408
%token RDO_r_rect						409
%token RDO_line							410
%token RDO_ellipse						411
%token RDO_triang						412
%token RDO_active						413
%token RDO_ruler						414
%token RDO_space						415
%token RDO_color_transparent			416
%token RDO_color_last					417
%token RDO_color_white					418
%token RDO_color_black					419
%token RDO_color_red					420
%token RDO_color_green					421
%token RDO_color_blue					422
%token RDO_color_cyan					423
%token RDO_color_magenta				424
%token RDO_color_yellow					425
%token RDO_color_gray					426

%token RDO_IDENTIF_RELRES				427
%token RDO_typedef						428
%token RDO_enum							429

%token RDO_STRING_CONST					430
%token RDO_STRING_CONST_BAD				431
%token RDO_IDENTIF_BAD					432
%token RDO_Select						433
%token RDO_Size							434
%token RDO_Empty						435
%token RDO_not							436
%token RDO_UMINUS						437
%token RDO_string						438
%token RDO_bool							439
%token RDO_BOOL_CONST					440
%token RDO_Fuzzy						441
%token RDO_Fuzzy_Term					442
%token RDO_eq							443
%token RDO_External_Model				444
%token RDO_QUEUE						445
%token RDO_DEPART						446
%token RDO_ASSIGN						447


%{
// ====================================================================== PCH
#include "rdo_lib/rdo_converter/pch.h"
// ====================================================================== INCLUDES
// ====================================================================== SYNOPSIS
#include "rdo_lib/rdo_converter/rdoparser.h"
#include "rdo_lib/rdo_converter/rdoparser_lexer.h"
#include "rdo_lib/rdo_converter/rdopat.h"
#include "rdo_lib/rdo_converter/rdortp.h"
#include "rdo_lib/rdo_converter/rdofun.h"
#include "rdo_lib/rdo_converter/rdo_type_range.h"
#include "rdo_lib/rdo_converter/rdo_type_param_suchas.h"
#include "rdo_lib/rdo_converter/update/update.h"
#include "rdo_lib/rdo_runtime/rdotrace.h"
// ===============================================================================

#define CONVERTER LEXER->converter()
#define RUNTIME   CONVERTER->runtime()

#define P_RDOVALUE(A) reinterpret_cast<PTR(RDOValue)>(A)
#define RDOVALUE(A)   (*P_RDOVALUE(A))

OPEN_RDO_CONVERTER_NAMESPACE
%}

%left RDO_or
%left RDO_and
%left '+' '-'
%left '*' '/'
%left RDO_not
%left RDO_UMINUS

%%

pat_main
	: /* empty */
	| pat_main pat_pattern
	{
		LPRDOPATPattern pPattern = CONVERTER->stack().pop<RDOPATPattern>($2);
		ASSERT(pPattern);
		switch (pPattern->getType())
		{
			case RDOPATPattern::PT_IE:
			{
				rdoConverter::LPDocUpdate pEventMove = rdo::Factory<rdoConverter::UpdateMove>::create(
					@2.m_first_seek,
					@2.m_last_seek,
					IDocUpdate::Position::POSITION_END,
					rdoConverter::IDocument::EVN
				);
				ASSERT(pEventMove);
				CONVERTER->insertDocUpdate(pEventMove);

				rdoConverter::LPDocUpdate pReturnInsert = rdo::Factory<rdoConverter::UpdateInsert>::create(
					IDocUpdate::Position::POSITION_END,
					_T("\r\n\r\n"),
					rdoConverter::IDocument::EVN
				);
				ASSERT(pReturnInsert);
				CONVERTER->insertDocUpdate(pReturnInsert);
			}
		}
		CONVERTER->stack().push(pPattern);
	}
	| error
	{
		CONVERTER->error().error(@1, _T("����������� ������"));
	}
	;

pat_header
	: RDO_Pattern RDO_IDENTIF_COLON RDO_operation pat_trace 
	{
		PTR(RDOValue) name = P_RDOVALUE($2);
		LPRDOPATPattern pPattern = rdo::Factory<RDOPatternOperation>::create(name->src_info(), $4 != 0);
		ASSERT(pPattern);
		$$ = CONVERTER->stack().push(pPattern);
	}
	| RDO_Pattern RDO_IDENTIF_COLON RDO_irregular_event pat_trace
	{
		PTR(RDOValue) name = P_RDOVALUE($2);
		LPRDOPATPattern pPattern = rdo::Factory<RDOPatternIrregEvent>::create(name->src_info(), $4 != 0);
		ASSERT(pPattern);

		rdoConverter::LPDocUpdate pIEReplace = rdo::Factory<rdoConverter::UpdateReplace>::create(
			@3.m_first_seek,
			@3.m_last_seek,
			_T("event")
		);
		ASSERT(pIEReplace);
		CONVERTER->insertDocUpdate(pIEReplace);

		$$ = CONVERTER->stack().push(pPattern);
	}
	| RDO_Pattern RDO_IDENTIF_COLON RDO_rule pat_trace
	{
		PTR(RDOValue) name = P_RDOVALUE($2);
		LPRDOPATPattern pPattern = rdo::Factory<RDOPatternRule>::create(name->src_info(), $4 != 0);
		ASSERT(pPattern);
		$$ = CONVERTER->stack().push(pPattern);
	}
	| RDO_Pattern RDO_IDENTIF_COLON RDO_keyboard pat_trace
	{
		PTR(RDOValue) name = P_RDOVALUE($2);
		LPRDOPATPattern pPattern = rdo::Factory<RDOPatternKeyboard>::create(name->src_info(), $4 != 0);
		ASSERT(pPattern);
		$$ = CONVERTER->stack().push(pPattern);
	}
	| RDO_Pattern error
	{
		CONVERTER->error().error(@2, _T("��������� ��� �������"));
	}
	| RDO_Pattern RDO_IDENTIF_COLON error
	{
		CONVERTER->error().error(@2, @3, _T("��������� ��� �������"));
	}
	;

pat_trace
	: /* empty */	{ $$ = 0; }
	| RDO_trace		{ $$ = 1; }
	| RDO_no_trace	{ $$ = 0; }
	;

pat_params_begin
	: pat_header RDO_Parameters
	{
		LPRDOPATPattern pPattern = CONVERTER->stack().pop<RDOPATPattern>($1);
		ASSERT(pPattern);
		$$ = CONVERTER->stack().push(pPattern);
	}
	;

pat_params
	: pat_params_begin RDO_IDENTIF_COLON param_type param_value_default
	{
		LPRDOPATPattern pPattern   = CONVERTER->stack().pop<RDOPATPattern>($1);
		ASSERT(pPattern);
		PTR(RDOValue)   param_name = P_RDOVALUE($2);
		LPRDOTypeParam  param_type = CONVERTER->stack().pop<RDOTypeParam>($3);
		LPRDOParam      pParam     = rdo::Factory<RDOParam>::create(param_name->src_info(), param_type, RDOVALUE($4));
		pPattern->add(pParam);
		$$ = CONVERTER->stack().push(pPattern);
	}
	| pat_params RDO_IDENTIF_COLON param_type param_value_default
	{
		LPRDOPATPattern pPattern   = CONVERTER->stack().pop<RDOPATPattern>($1);
		ASSERT(pPattern);
		PTR(RDOValue)   param_name = P_RDOVALUE($2);
		LPRDOTypeParam  param_type = CONVERTER->stack().pop<RDOTypeParam>($3);
		LPRDOParam      pParam     = rdo::Factory<RDOParam>::create(param_name->src_info(), param_type, RDOVALUE($4));
		pPattern->add(pParam);
		$$ = CONVERTER->stack().push(pPattern);
	}
	| pat_params_begin error
	{
		if (@1.m_last_line != @2.m_last_line)
		{
			CONVERTER->error().error(@2, _T("��������� ��� ��������� �������"));
		}
		else
		{
			CONVERTER->error().error(@2, rdo::format(_T("��������� ��� ��������� �������, �������: %s"), LEXER->YYText()));
		}
	}
	| pat_params_begin RDO_IDENTIF error
	{
		if (@2.m_last_line != @3.m_last_line)
		{
			CONVERTER->error().error(@2, @3, _T("��������� ���������"));
		}
		else
		{
			CONVERTER->error().error(@2, @3, rdo::format(_T("��������� ���������, �������: %s"), LEXER->YYText()));
		}
	}
	| pat_params_begin RDO_IDENTIF_COLON error
	{
		if (@2.m_last_line != @3.m_last_line)
		{
			CONVERTER->error().error(@2, @3, _T("��������� ��� ��������� �������"));
		}
		else
		{
			CONVERTER->error().error(@2, @3, rdo::format(_T("��������� ��� ��������� �������, �������: %s"), LEXER->YYText()));
		}
	}
	| pat_params error
	{
		if (@1.m_last_line != @2.m_last_line)
		{
			CONVERTER->error().error(@2, _T("��������� ��� ��������� �������"));
		}
		else
		{
			CONVERTER->error().error(@2, rdo::format(_T("��������� ��� ��������� �������, �������: %s"), LEXER->YYText()));
		}
	}
	| pat_params RDO_IDENTIF error
	{
		if (@2.m_last_line != @3.m_last_line)
		{
			CONVERTER->error().error(@2, @3, _T("��������� ���������"));
		}
		else
		{
			CONVERTER->error().error(@2, @3, rdo::format(_T("��������� ���������, �������: %s"), LEXER->YYText()));
		}
	}
	| pat_params RDO_IDENTIF_COLON error
	{
		if (@2.m_last_line != @3.m_last_line)
		{
			CONVERTER->error().error(@2, @3, _T("��������� ��� ��������� �������"));
		}
		else
		{
			CONVERTER->error().error(@2, @3, rdo::format(_T("��������� ��� ��������� �������, �������: %s"), LEXER->YYText()));
		}
	}
	;

pat_params_end
	: pat_params RDO_Relevant_resources
	{
		$$ = $1;
	}
	| pat_header RDO_Relevant_resources
	{
		$$ = $1;
	}
	| pat_header error
	{
		CONVERTER->error().error(@2, _T("��������� �������� ����� $Relevant_resources"));
	}
	;

pat_rel_res
	: pat_params_end RDO_IDENTIF_COLON RDO_IDENTIF pat_conv pat_conv
	{
		// ��������� ��� ie,event,rule,opr,key
		LPRDOPATPattern pPattern = CONVERTER->stack().pop<RDOPATPattern>($1);
		ASSERT(pPattern);
		switch (pPattern->getType())
		{
			case RDOPATPattern::PT_Operation:
			case RDOPATPattern::PT_Keyboard :
			{
				PTR(RDOValue) rel_name  = P_RDOVALUE($2);
				PTR(RDOValue) type_name = P_RDOVALUE($3);
				pPattern.object_static_cast<RDOPatternOperation>()->addRelRes(rel_name->src_info(), type_name->src_info(), (rdoRuntime::RDOResource::ConvertStatus)$4, (rdoRuntime::RDOResource::ConvertStatus)$5, @4, @5);
				break;
			}
			case RDOPATPattern::PT_IE:
			{
				CONVERTER->error().error(@5, _T("� ������������� ������� ��� ������� �����, � ������ � ������� ������� ����������"));
				break;
			}
			case RDOPATPattern::PT_Rule:
			{
				CONVERTER->error().error(@5, _T("� �������������� ������� ��� ������� �����, � ������ � ������� ������� ����������"));
				break;
			}
		}
		$$ = CONVERTER->stack().push(pPattern);
	}
	| pat_rel_res RDO_IDENTIF_COLON RDO_IDENTIF pat_conv pat_conv
	{
		// ��������� ��� ie,event,rule,opr,key
		LPRDOPATPattern pPattern = CONVERTER->stack().pop<RDOPATPattern>($1);
		ASSERT(pPattern);
		switch (pPattern->getType())
		{
			case RDOPATPattern::PT_Operation:
			case RDOPATPattern::PT_Keyboard :
			{
				PTR(RDOValue) rel_name  = P_RDOVALUE($2);
				PTR(RDOValue) type_name = P_RDOVALUE($3);
				pPattern.object_static_cast<RDOPatternOperation>()->addRelRes(rel_name->src_info(), type_name->src_info(), (rdoRuntime::RDOResource::ConvertStatus)$4, (rdoRuntime::RDOResource::ConvertStatus)$5, @4, @5);
				break;
			}
			case RDOPATPattern::PT_IE:
			{
				CONVERTER->error().error(@5, _T("� ������������� ������� ��� ������� �����, � ������ � ������� ������� ����������"));
				break;
			}
			case RDOPATPattern::PT_Rule:
			{
				CONVERTER->error().error(@5, _T("� �������������� ������� ��� ������� �����, � ������ � ������� ������� ����������"));
				break;
			}
		}
		$$ = CONVERTER->stack().push(pPattern);
	}
	| pat_params_end RDO_IDENTIF_COLON RDO_IDENTIF pat_conv
	{
		// ��������� ��� ie,event,rule,opr,key
		LPRDOPATPattern pPattern = CONVERTER->stack().pop<RDOPATPattern>($1);
		ASSERT(pPattern);
		switch (pPattern->getType())
		{
			case RDOPATPattern::PT_Operation:
			case RDOPATPattern::PT_Keyboard :
			{
				CONVERTER->error().error(@4, rdo::format(_T("������ ������� ���������� ������ (%s), ��������� ������ ���������� �����, ������ ��� � �������� ���� ������� �����"), RDOPATPattern::StatusToStr((rdoRuntime::RDOResource::ConvertStatus)$4).c_str()));
				break;
			}
			case RDOPATPattern::PT_IE  :
			case RDOPATPattern::PT_Rule:
			{
				PTR(RDOValue) rel_name  = P_RDOVALUE($2);
				PTR(RDOValue) type_name = P_RDOVALUE($3);
				pPattern->addRelRes(rel_name->src_info(), type_name->src_info(), (rdoRuntime::RDOResource::ConvertStatus)$4, @4);
				break;
			}
		}
		$$ = CONVERTER->stack().push(pPattern);
	}
	| pat_rel_res RDO_IDENTIF_COLON RDO_IDENTIF pat_conv
	{
		// ��������� ��� ie,event,rule,opr,key
		LPRDOPATPattern pPattern = CONVERTER->stack().pop<RDOPATPattern>($1);
		ASSERT(pPattern);
		switch (pPattern->getType())
		{
			case RDOPATPattern::PT_Operation:
			case RDOPATPattern::PT_Keyboard :
			{
				CONVERTER->error().error(@4, rdo::format(_T("������ ������� ���������� ������ (%s), ��������� ������ ���������� �����, ������ ��� � �������� ���� ������� �����"), RDOPATPattern::StatusToStr((rdoRuntime::RDOResource::ConvertStatus)$4).c_str()));
				break;
			}
			case RDOPATPattern::PT_IE  :
			case RDOPATPattern::PT_Rule:
			{
				PTR(RDOValue) rel_name  = P_RDOVALUE($2);
				PTR(RDOValue) type_name = P_RDOVALUE($3);
				pPattern->addRelRes(rel_name->src_info(), type_name->src_info(), (rdoRuntime::RDOResource::ConvertStatus)$4, @4);
				break;
			}
		}
		$$ = CONVERTER->stack().push(pPattern);
	}
	| pat_params_end RDO_IDENTIF_COLON RDO_IDENTIF_NoChange pat_conv
	{
		// ��������� ��� ie,event,rule,opr,key
		LPRDOPATPattern pPattern = CONVERTER->stack().pop<RDOPATPattern>($1);
		ASSERT(pPattern);
		switch (pPattern->getType())
		{
			case RDOPATPattern::PT_Operation:
			case RDOPATPattern::PT_Keyboard :
			{
				PTR(RDOValue) rel_name  = P_RDOVALUE($2);
				PTR(RDOValue) type_name = P_RDOVALUE($3);
				YYLTYPE convertor_pos = @3;
				convertor_pos.m_first_line = convertor_pos.m_last_line;
				convertor_pos.m_first_pos  = convertor_pos.m_last_pos  - RDOPATPattern::StatusToStr(rdoRuntime::RDOResource::CS_NoChange).length();
				convertor_pos.m_first_seek = convertor_pos.m_last_seek - RDOPATPattern::StatusToStr(rdoRuntime::RDOResource::CS_NoChange).length();
				pPattern.object_static_cast<RDOPatternOperation>()->addRelRes(rel_name->src_info(), type_name->src_info(), rdoRuntime::RDOResource::CS_NoChange, (rdoRuntime::RDOResource::ConvertStatus)$4, convertor_pos, @4);
				break;
			}
			case RDOPATPattern::PT_IE:
			{
				CONVERTER->error().error(@4, _T("� ������������� ������� ��� ������� �����, � ������ � ������� ������� ����������"));
				break;
			}
			case RDOPATPattern::PT_Rule:
			{
				CONVERTER->error().error(@4, _T("� �������������� ������� ��� ������� �����, � ������ � ������� ������� ����������"));
				break;
			}
		}
		$$ = CONVERTER->stack().push(pPattern);
	}
	| pat_rel_res RDO_IDENTIF_COLON RDO_IDENTIF_NoChange pat_conv
	{
		// ��������� ��� ie,event,rule,opr,key
		LPRDOPATPattern pPattern = CONVERTER->stack().pop<RDOPATPattern>($1);
		ASSERT(pPattern);
		switch (pPattern->getType())
		{
			case RDOPATPattern::PT_Operation:
			case RDOPATPattern::PT_Keyboard :
			{
				PTR(RDOValue) rel_name  = P_RDOVALUE($2);
				PTR(RDOValue) type_name = P_RDOVALUE($3);
				YYLTYPE convertor_pos = @3;
				convertor_pos.m_first_line = convertor_pos.m_last_line;
				convertor_pos.m_first_pos  = convertor_pos.m_last_pos  - RDOPATPattern::StatusToStr(rdoRuntime::RDOResource::CS_NoChange).length();
				convertor_pos.m_first_seek = convertor_pos.m_last_seek - RDOPATPattern::StatusToStr(rdoRuntime::RDOResource::CS_NoChange).length();
				pPattern.object_static_cast<RDOPatternOperation>()->addRelRes(rel_name->src_info(), type_name->src_info(), rdoRuntime::RDOResource::CS_NoChange, (rdoRuntime::RDOResource::ConvertStatus)$4, convertor_pos, @4);
				break;
			}
			case RDOPATPattern::PT_IE:
			{
				CONVERTER->error().error(@4, _T("� ������������� ������� ��� ������� �����, � ������ � ������� ������� ����������"));
				break;
			}
			case RDOPATPattern::PT_Rule:
			{
				CONVERTER->error().error(@4, _T("� �������������� ������� ��� ������� �����, � ������ � ������� ������� ����������"));
				break;
			}
		}
		$$ = CONVERTER->stack().push(pPattern);
	}
	| pat_params_end RDO_IDENTIF_COLON RDO_IDENTIF_NoChange_NoChange
	{
		// ��������� ��� ie,event,rule,opr,key
		LPRDOPATPattern pPattern = CONVERTER->stack().pop<RDOPATPattern>($1);
		ASSERT(pPattern);
		switch (pPattern->getType())
		{
			case RDOPATPattern::PT_Operation:
			case RDOPATPattern::PT_Keyboard :
			{
				PTR(RDOValue) rel_name  = P_RDOVALUE($2);
				PTR(RDOValue) type_name = P_RDOVALUE($3);
				YYLTYPE convertor_begin_pos = @3;
				tstring str = LEXER->YYText();
				rdo::toLower(str);
				tstring::size_type first_nochange = str.find(_T("nochange"));
				int i = 0;
				while (true)
				{
					if (str[i] == '\n')
					{
						convertor_begin_pos.m_first_line++;
						convertor_begin_pos.m_first_seek++;
						convertor_begin_pos.m_first_pos = 0;
					}
					else if (str[i] != '\r')
					{
						convertor_begin_pos.m_first_pos++;
						convertor_begin_pos.m_first_seek++;
					}
					i++;
					if (i == first_nochange)
						break;
				}
				convertor_begin_pos.m_last_line = convertor_begin_pos.m_first_line;
				convertor_begin_pos.m_last_pos  = convertor_begin_pos.m_first_pos  + RDOPATPattern::StatusToStr(rdoRuntime::RDOResource::CS_NoChange).length();
				convertor_begin_pos.m_last_seek = convertor_begin_pos.m_first_seek + RDOPATPattern::StatusToStr(rdoRuntime::RDOResource::CS_NoChange).length();
				YYLTYPE convertor_end_pos = @3;
				convertor_end_pos.m_first_line = convertor_end_pos.m_last_line;
				convertor_end_pos.m_first_pos  = convertor_end_pos.m_last_pos  - RDOPATPattern::StatusToStr(rdoRuntime::RDOResource::CS_NoChange).length();
				convertor_end_pos.m_first_seek = convertor_end_pos.m_last_seek - RDOPATPattern::StatusToStr(rdoRuntime::RDOResource::CS_NoChange).length();
				pPattern.object_static_cast<RDOPatternOperation>()->addRelRes(rel_name->src_info(), type_name->src_info(), rdoRuntime::RDOResource::CS_NoChange, rdoRuntime::RDOResource::CS_NoChange, convertor_begin_pos, convertor_end_pos);
				break;
			}
			case RDOPATPattern::PT_IE:
			{
				CONVERTER->error().error(@3, _T("� ������������� ������� ��� ������� �����, � ������ � ������� ������� ����������"));
				break;
			}
			case RDOPATPattern::PT_Rule:
			{
				CONVERTER->error().error(@3, _T("� �������������� ������� ��� ������� �����, � ������ � ������� ������� ����������"));
				break;
			}
		}
		$$ = CONVERTER->stack().push(pPattern);
	}
	| pat_rel_res RDO_IDENTIF_COLON RDO_IDENTIF_NoChange_NoChange
	{
		// ��������� ��� ie,event,rule,opr,key
		LPRDOPATPattern pPattern = CONVERTER->stack().pop<RDOPATPattern>($1);
		ASSERT(pPattern);
		switch (pPattern->getType())
		{
			case RDOPATPattern::PT_Operation:
			case RDOPATPattern::PT_Keyboard :
			{
				PTR(RDOValue) rel_name  = P_RDOVALUE($2);
				PTR(RDOValue) type_name = P_RDOVALUE($3);
				YYLTYPE convertor_begin_pos = @3;
				tstring str = LEXER->YYText();
				rdo::toLower(str);
				tstring::size_type first_nochange = str.find(_T("nochange"));
				int i = 0;
				while (true)
				{
					if (str[i] == '\n')
					{
						convertor_begin_pos.m_first_line++;
						convertor_begin_pos.m_first_seek++;
						convertor_begin_pos.m_first_pos = 0;
					}
					else if (str[i] != '\r')
					{
						convertor_begin_pos.m_first_pos++;
						convertor_begin_pos.m_first_seek++;
					}
					i++;
					if (i == first_nochange)
						break;
				}
				convertor_begin_pos.m_last_line = convertor_begin_pos.m_first_line;
				convertor_begin_pos.m_last_pos  = convertor_begin_pos.m_first_pos  + RDOPATPattern::StatusToStr(rdoRuntime::RDOResource::CS_NoChange).length();
				convertor_begin_pos.m_last_seek = convertor_begin_pos.m_first_seek + RDOPATPattern::StatusToStr(rdoRuntime::RDOResource::CS_NoChange).length();
				YYLTYPE convertor_end_pos = @3;
				convertor_end_pos.m_first_line = convertor_end_pos.m_last_line;
				convertor_end_pos.m_first_pos  = convertor_end_pos.m_last_pos  - RDOPATPattern::StatusToStr(rdoRuntime::RDOResource::CS_NoChange).length();
				convertor_end_pos.m_first_seek = convertor_end_pos.m_last_seek - RDOPATPattern::StatusToStr(rdoRuntime::RDOResource::CS_NoChange).length();
				pPattern.object_static_cast<RDOPatternOperation>()->addRelRes(rel_name->src_info(), type_name->src_info(), rdoRuntime::RDOResource::CS_NoChange, rdoRuntime::RDOResource::CS_NoChange, convertor_begin_pos, convertor_end_pos);
				break;
			}
			case RDOPATPattern::PT_IE:
			{
				CONVERTER->error().error(@3, _T("� ������������� ������� ��� ������� �����, � ������ � ������� ������� ����������"));
				break;
			}
			case RDOPATPattern::PT_Rule:
			{
				CONVERTER->error().error(@3, _T("� �������������� ������� ��� ������� �����, � ������ � ������� ������� ����������"));
				break;
			}
		}
		$$ = CONVERTER->stack().push(pPattern);
	}
	| pat_params_end RDO_IDENTIF_COLON RDO_IDENTIF_NoChange
	{
		// ��������� ��� ie,rule,opr,key
		LPRDOPATPattern pPattern = CONVERTER->stack().pop<RDOPATPattern>($1);
		ASSERT(pPattern);
		switch (pPattern->getType())
		{
			case RDOPATPattern::PT_Operation:
			case RDOPATPattern::PT_Keyboard :
			{
				CONVERTER->error().error(@3, rdo::format(_T("������ ������� ���������� ������ (%s), ��������� ������ ���������� �����, ������ ��� � �������� ���� ������� �����"), RDOPATPattern::StatusToStr(rdoRuntime::RDOResource::CS_NoChange).c_str()));
				break;
			}
			case RDOPATPattern::PT_IE  :
			case RDOPATPattern::PT_Rule:
			{
				PTR(RDOValue) rel_name  = P_RDOVALUE($2);
				PTR(RDOValue) type_name = P_RDOVALUE($3);
				YYLTYPE convertor_pos = @3;
				convertor_pos.m_first_line = convertor_pos.m_last_line;
				convertor_pos.m_first_pos  = convertor_pos.m_last_pos  - RDOPATPattern::StatusToStr(rdoRuntime::RDOResource::CS_NoChange).length();
				convertor_pos.m_first_seek = convertor_pos.m_last_seek - RDOPATPattern::StatusToStr(rdoRuntime::RDOResource::CS_NoChange).length();
				pPattern->addRelRes(rel_name->src_info(), type_name->src_info(), rdoRuntime::RDOResource::CS_NoChange, convertor_pos);
				break;
			}
		}
		$$ = CONVERTER->stack().push(pPattern);
	}
	| pat_rel_res RDO_IDENTIF_COLON RDO_IDENTIF_NoChange
	{
		// ��������� ��� ie,event,rule,opr,key
		LPRDOPATPattern pPattern = CONVERTER->stack().pop<RDOPATPattern>($1);
		ASSERT(pPattern);
		switch (pPattern->getType())
		{
			case RDOPATPattern::PT_Operation:
			case RDOPATPattern::PT_Keyboard :
			{
				CONVERTER->error().error(@3, rdo::format(_T("������ ������� ���������� ������ (%s), ��������� ������ ���������� �����, ������ ��� � �������� ���� ������� �����"), RDOPATPattern::StatusToStr(rdoRuntime::RDOResource::CS_NoChange).c_str()));
				break;
			}
			case RDOPATPattern::PT_IE   :
			case RDOPATPattern::PT_Rule :
			{
				PTR(RDOValue) rel_name  = P_RDOVALUE($2);
				PTR(RDOValue) type_name = P_RDOVALUE($3);
				YYLTYPE convertor_pos = @3;
				convertor_pos.m_first_line = convertor_pos.m_last_line;
				convertor_pos.m_first_pos  = convertor_pos.m_last_pos  - RDOPATPattern::StatusToStr(rdoRuntime::RDOResource::CS_NoChange).length();
				convertor_pos.m_first_seek = convertor_pos.m_last_seek - RDOPATPattern::StatusToStr(rdoRuntime::RDOResource::CS_NoChange).length();
				pPattern->addRelRes(rel_name->src_info(), type_name->src_info(), rdoRuntime::RDOResource::CS_NoChange, convertor_pos);
				break;
			}
		}
		$$ = CONVERTER->stack().push(pPattern);
	}
	| pat_params_end RDO_IDENTIF_COLON RDO_IDENTIF RDO_IDENTIF_NoChange
	{
		// ��������� ��� ie,rule,opr,key
		LPRDOPATPattern pPattern = CONVERTER->stack().pop<RDOPATPattern>($1);
		ASSERT(pPattern);
		switch (pPattern->getType())
		{
			case RDOPATPattern::PT_Operation:
			case RDOPATPattern::PT_Keyboard :
			{
				PTR(RDOValue) rel_name  = P_RDOVALUE($2);
				PTR(RDOValue) type_name = P_RDOVALUE($3);
				tstring convert_begin = RDOVALUE($4)->getIdentificator();
				YYLTYPE convertor_begin_pos = @4;
				convertor_begin_pos.m_last_line = convertor_begin_pos.m_first_line;
				convertor_begin_pos.m_last_pos  = convertor_begin_pos.m_first_pos  + convert_begin.length();
				convertor_begin_pos.m_last_seek = convertor_begin_pos.m_first_seek + convert_begin.length();
				YYLTYPE convertor_end_pos = @4;
				convertor_end_pos.m_first_line = convertor_end_pos.m_last_line;
				convertor_end_pos.m_first_pos  = convertor_end_pos.m_last_pos  - RDOPATPattern::StatusToStr(rdoRuntime::RDOResource::CS_NoChange).length();
				convertor_end_pos.m_first_seek = convertor_end_pos.m_last_seek - RDOPATPattern::StatusToStr(rdoRuntime::RDOResource::CS_NoChange).length();
				pPattern.object_static_cast<RDOPatternOperation>()->addRelRes(rel_name->src_info(), type_name->src_info(), pPattern->StrToStatus(convert_begin, convertor_begin_pos), rdoRuntime::RDOResource::CS_NoChange, convertor_begin_pos, convertor_end_pos);
				break;
			}
			case RDOPATPattern::PT_IE:
			{
				CONVERTER->error().error(@4, _T("� ������������� ������� ��� ������� �����, � ������ � ������� ������� ����������"));
				break;
			}
			case RDOPATPattern::PT_Rule:
			{
				CONVERTER->error().error(@4, _T("� �������������� ������� ��� ������� �����, � ������ � ������� ������� ����������"));
				break;
			}
		}
		$$ = CONVERTER->stack().push(pPattern);
	}
	| pat_rel_res RDO_IDENTIF_COLON RDO_IDENTIF RDO_IDENTIF_NoChange
	{
		// ��������� ��� ie,event,rule,opr,key
		LPRDOPATPattern pPattern = CONVERTER->stack().pop<RDOPATPattern>($1);
		ASSERT(pPattern);
		switch (pPattern->getType())
		{
			case RDOPATPattern::PT_Operation:
			case RDOPATPattern::PT_Keyboard :
			{
				PTR(RDOValue) rel_name  = P_RDOVALUE($2);
				PTR(RDOValue) type_name = P_RDOVALUE($3);
				tstring convert_begin = RDOVALUE($4)->getIdentificator();
				YYLTYPE convertor_begin_pos = @4;
				convertor_begin_pos.m_last_line = convertor_begin_pos.m_first_line;
				convertor_begin_pos.m_last_pos  = convertor_begin_pos.m_first_pos  + convert_begin.length();
				convertor_begin_pos.m_last_seek = convertor_begin_pos.m_first_seek + convert_begin.length();
				YYLTYPE convertor_end_pos = @4;
				convertor_end_pos.m_first_line = convertor_end_pos.m_last_line;
				convertor_end_pos.m_first_pos  = convertor_end_pos.m_last_pos  - RDOPATPattern::StatusToStr(rdoRuntime::RDOResource::CS_NoChange).length();
				convertor_end_pos.m_first_seek = convertor_end_pos.m_last_seek - RDOPATPattern::StatusToStr(rdoRuntime::RDOResource::CS_NoChange).length();
				pPattern.object_static_cast<RDOPatternOperation>()->addRelRes(rel_name->src_info(), type_name->src_info(), pPattern->StrToStatus(convert_begin, convertor_begin_pos), rdoRuntime::RDOResource::CS_NoChange, convertor_begin_pos, convertor_end_pos);
				break;
			}
			case RDOPATPattern::PT_IE:
			{
				CONVERTER->error().error(@4, _T("� ������������� ������� ��� ������� �����, � ������ � ������� ������� ����������"));
				break;
			}
			case RDOPATPattern::PT_Rule:
			{
				CONVERTER->error().error(@4, _T("� �������������� ������� ��� ������� �����, � ������ � ������� ������� ����������"));
				break;
			}
		}
		$$ = CONVERTER->stack().push(pPattern);
	}
	| pat_params_end error
	{
		CONVERTER->error().error(@2, _T("������ � �������� ����������� ��������"));
	}
	| pat_rel_res error
	{
		CONVERTER->error().error(@2, _T("������ � �������� ����������� ��������"));
	}
	| pat_params_end RDO_IDENTIF_COLON error
	{
		CONVERTER->error().error(@2, @3, _T("��������� ��������� (��� ���� ��� �������)"));
	}
	| pat_rel_res RDO_IDENTIF_COLON error
	{
		CONVERTER->error().error(@2, @3, _T("��������� ��������� (��� ���� ��� �������)"));
	}
	| pat_params_end RDO_IDENTIF_COLON RDO_IDENTIF error
	{
		if (CONVERTER->getLastPATPattern()->isHaveConvertEnd())
		{
			CONVERTER->error().error(@3, @4, _T("��������� ������ ���������� ������"));
		}
		else
		{
			CONVERTER->error().error(@3, @4, _T("��������� ������ ����������"));
		}
	}
	| pat_rel_res RDO_IDENTIF_COLON RDO_IDENTIF error
	{
		if (CONVERTER->getLastPATPattern()->isHaveConvertEnd())
		{
			CONVERTER->error().error(@3, @4, _T("��������� ������ ���������� ������"));
		}
		else
		{
			CONVERTER->error().error(@3, @4, _T("��������� ������ ����������"));
		}
	}
	| pat_params_end RDO_IDENTIF_COLON RDO_IDENTIF pat_conv error
	{
		switch (CONVERTER->getLastPATPattern()->getType())
		{
			case RDOPATPattern::PT_Rule:
			{
				CONVERTER->error().error(@5, _T("��������� ������ ������ (first/with_min/with_max) ��� $Body"));
				break;
			}
			case RDOPATPattern::PT_IE:
			{
				CONVERTER->error().error(@5, _T("��������� ������ ������ (first/with_min/with_max) ��� $Time"));
				break;
			}
			case RDOPATPattern::PT_Operation:
			case RDOPATPattern::PT_Keyboard :
			{
				CONVERTER->error().error(@4, @5, rdo::format(_T("��������� ������ ���������� �����, �������: %s"), LEXER->YYText()));
				break;
			}
		}
	}
	| pat_rel_res RDO_IDENTIF_COLON RDO_IDENTIF pat_conv error
	{
		switch (CONVERTER->getLastPATPattern()->getType())
		{
			case RDOPATPattern::PT_Rule:
			{
				CONVERTER->error().error(@5, _T("��������� ������ ������ (first/with_min/with_max) ��� $Body"));
				break;
			}
			case RDOPATPattern::PT_IE:
			{
				CONVERTER->error().error(@5, _T("��������� ������ ������ (first/with_min/with_max) ��� $Time"));
				break;
			}
			case RDOPATPattern::PT_Operation:
			case RDOPATPattern::PT_Keyboard :
			{
				CONVERTER->error().error(@4, @5, rdo::format(_T("��������� ������ ���������� �����, �������: %s"), LEXER->YYText()));
				break;
			}
		}
	}
	| pat_params_end RDO_IDENTIF_COLON RDO_IDENTIF_NoChange error
	{
		switch (CONVERTER->getLastPATPattern()->getType())
		{
			case RDOPATPattern::PT_Rule:
			{
				CONVERTER->error().error(@4, _T("��������� ������ ������ (first/with_min/with_max) ��� $Body"));
				break;
			}
			case RDOPATPattern::PT_IE:
			{
				CONVERTER->error().error(@4, _T("��������� ������ ������ (first/with_min/with_max) ��� $Time"));
				break;
			}
			case RDOPATPattern::PT_Operation:
			case RDOPATPattern::PT_Keyboard :
			{
				CONVERTER->error().error(@3, @4, rdo::format(_T("��������� ������ ���������� �����, �������: %s"), LEXER->YYText()));
				break;
			}
		}
	}
	| pat_rel_res RDO_IDENTIF_COLON RDO_IDENTIF_NoChange error
	{
		switch (CONVERTER->getLastPATPattern()->getType())
		{
			case RDOPATPattern::PT_Rule:
			{
				CONVERTER->error().error(@4, _T("��������� ������ ������ (first/with_min/with_max) ��� $Body"));
				break;
			}
			case RDOPATPattern::PT_IE:
			{
				CONVERTER->error().error(@4, _T("��������� ������ ������ (first/with_min/with_max) ��� $Time"));
				break;
			}
			case RDOPATPattern::PT_Operation:
			case RDOPATPattern::PT_Keyboard :
			{
				CONVERTER->error().error(@3, @4, rdo::format(_T("��������� ������ ���������� �����, �������: %s"), LEXER->YYText()));
				break;
			}
		}
	}
	;

pat_conv
	: RDO_Keep			{ $$ = rdoRuntime::RDOResource::CS_Keep;     }
	| RDO_Create		{ $$ = rdoRuntime::RDOResource::CS_Create;   }
	| RDO_Erase			{ $$ = rdoRuntime::RDOResource::CS_Erase;    }
	| RDO_NonExist		{ $$ = rdoRuntime::RDOResource::CS_NonExist; }
	;

pat_common_choice
	: pat_rel_res
	| pat_rel_res RDO_first
	{
		LPRDOPATPattern pPattern = CONVERTER->stack().pop<RDOPATPattern>($1);
		if (pPattern->getType() == RDOPATPattern::PT_IE)
		{
			CONVERTER->error().error(@2, _T("� �������� �� ������������ ������ ������ ����������� ��������"));
		}
		else
		{
			pPattern->setCommonChoiceFirst();
		}
		$$ = CONVERTER->stack().push(pPattern);
	}
	| pat_rel_res RDO_with_min fun_arithm
	{
		LPRDOPATPattern pPattern = CONVERTER->stack().pop<RDOPATPattern>($1);
		if (pPattern->getType() == RDOPATPattern::PT_IE)
		{
			CONVERTER->error().error(@2, _T("� �������� �� ������������ ������ ������ ����������� ��������"));
		}
		else
		{
			LPRDOFUNArithm pArithm = CONVERTER->stack().pop<RDOFUNArithm>($3);
			ASSERT(pArithm);
			pArithm->setSrcPos (@2, @3);
			pArithm->setSrcText(_T("with_min ") + pArithm->src_text());
			pPattern->setCommonChoiceWithMin(pArithm);
		}
		$$ = CONVERTER->stack().push(pPattern);
	}
	| pat_rel_res RDO_with_max fun_arithm
	{
		LPRDOPATPattern pPattern = CONVERTER->stack().pop<RDOPATPattern>($1);
		if (pPattern->getType() == RDOPATPattern::PT_IE)
		{
			CONVERTER->error().error(@2, _T("� �������� �� ������������ ������ ������ ����������� ��������"));
		}
		else
		{
			LPRDOFUNArithm pArithm = CONVERTER->stack().pop<RDOFUNArithm>($3);
			ASSERT(pArithm);
			pArithm->setSrcPos (@2, @3);
			pArithm->setSrcText(_T("with_max ") + pArithm->src_text());
			pPattern->setCommonChoiceWithMax(pArithm);
		}
		$$ = CONVERTER->stack().push(pPattern);
	}
	| pat_rel_res RDO_with_min error
	{
		CONVERTER->error().error(@3, _T("������ � �������������� ���������"));
	}
	| pat_rel_res RDO_with_max error
	{
		CONVERTER->error().error(@3, _T("������ � �������������� ���������"));
	}
	;

pat_time
	: pat_common_choice RDO_Body
	{
		LPRDOPATPattern pPattern = CONVERTER->stack().pop<RDOPATPattern>($1);
		switch (pPattern->getType())
		{
			case RDOPATPattern::PT_IE       :
			case RDOPATPattern::PT_Operation:
			case RDOPATPattern::PT_Keyboard :
			{
				CONVERTER->error().error(@2, _T("����� $Body ��������� �������� ����� $Time"));
				break;
			}
		}
		$$ = CONVERTER->stack().push(pPattern);
	}
	| pat_common_choice RDO_Time '=' fun_arithm RDO_Body
	{
		LPRDOPATPattern pPattern = CONVERTER->stack().pop<RDOPATPattern>($1);
		switch (pPattern->getType())
		{
			case RDOPATPattern::PT_Rule:
			{
				CONVERTER->error().error(@2, _T("���� $Time �� ������������ � ������������� �������"));
				break;
			}
		}
		LPRDOFUNArithm pArithm = CONVERTER->stack().pop<RDOFUNArithm>($4);
		ASSERT(pArithm);
		pArithm->setSrcPos (@2, @4);
		//pArithm->setSrcText(_T("$Time = ") + pArithm->src_text());
		pPattern->setTime(pArithm);
		switch (pPattern->getType())
		{
			case RDOPATPattern::PT_IE:
			{
				LPDocUpdate pTimeDelete1 = rdo::Factory<UpdateDelete>::create(@2.m_first_seek, @2.m_last_seek);
				ASSERT(pTimeDelete1);
				CONVERTER->insertDocUpdate(pTimeDelete1);

				LPDocUpdate pTimeDelete2 = rdo::Factory<UpdateDelete>::create(@3.m_first_seek, @3.m_last_seek);
				ASSERT(pTimeDelete2);
				CONVERTER->insertDocUpdate(pTimeDelete2);

				LPDocUpdate pTimeDelete3 = rdo::Factory<UpdateDelete>::create(@4.m_first_seek, @4.m_last_seek);
				ASSERT(pTimeDelete3);
				CONVERTER->insertDocUpdate(pTimeDelete3);
			}
		}
		$$ = CONVERTER->stack().push(pPattern);
	}
	| pat_common_choice RDO_Time '=' fun_arithm error
	{
		CONVERTER->error().error(@4, @5, _T("��������� �������� ����� $Body"));
	}
	| pat_common_choice RDO_Time '=' error
	{
		CONVERTER->error().error(@4, _T("������ � �������������� ���������"));
	}
	| pat_common_choice RDO_Time error
	{
		CONVERTER->error().error(@2, @3, _T("����� ��������� ����� $Time ��������� ���� ���������"));
	}
	| pat_common_choice error
	{
		LPRDOPATPattern pPattern = CONVERTER->stack().pop<RDOPATPattern>($1);
		switch (pPattern->getType())
		{
			case RDOPATPattern::PT_Rule:
			{
				CONVERTER->error().error(@2, rdo::format(_T("��������� $Body, �������: %s"), LEXER->YYText()));
				break;
			}
			case RDOPATPattern::PT_IE       :
			case RDOPATPattern::PT_Operation:
			case RDOPATPattern::PT_Keyboard :
			{
				CONVERTER->error().error(@2, rdo::format(_T("��������� $Time, �������: %s"), LEXER->YYText()));
				break;
			}
		}
		$$ = CONVERTER->stack().push(pPattern);
	}
	;

pat_body
	: pat_time RDO_IDENTIF_RELRES
	{
		LPRDOPATPattern pPattern = CONVERTER->stack().pop<RDOPATPattern>($1);
		tstring         name     = RDOVALUE($2)->getIdentificator();
		pPattern->addRelResBody(RDOParserSrcInfo(@2, name));
		$$ = CONVERTER->stack().push(pPattern);
	}
	| pat_convert RDO_IDENTIF_RELRES
	{
		LPRDOPATPattern pPattern = CONVERTER->stack().pop<RDOPATPattern>($1);
		tstring         name    = RDOVALUE($2)->getIdentificator();
		pPattern->addRelResBody(RDOParserSrcInfo(@2, name));
		$$ = CONVERTER->stack().push(pPattern);
	}
	| pat_time error
	{
		tstring str(LEXER->YYText());
		CONVERTER->error().error(@2, rdo::format(_T("����������� ����������� ������: %s"), str.c_str()));
	}
	| pat_convert error
	{
		tstring str(LEXER->YYText());
		CONVERTER->error().error(@2, rdo::format(_T("����������� ����������� ������: %s"), str.c_str()));
	}
	;

pat_res_usage
	: pat_body pat_choice pat_order
	{
		LPRDOPATChoiceFrom pChoiceFrom = CONVERTER->stack().pop<RDOPATChoiceFrom>($2);
		ASSERT(pChoiceFrom);
		pChoiceFrom->setSrcPos(@2);

		LPRDOPATChoiceOrder pChoiceOrder = CONVERTER->stack().pop<RDOPATChoiceOrder>($3);
		pChoiceOrder->setSrcPos(@3);

		LPRDOPATPattern pPattern = CONVERTER->stack().pop<RDOPATPattern>($1);
		ASSERT(pPattern);
		pPattern->addRelResUsage(pChoiceFrom, pChoiceOrder);
		$$ = CONVERTER->stack().push(pPattern);
	}
	;

pat_choice
	: /* empty */
	{
		CONVERTER->getLastPATPattern()->m_pCurrRelRes->m_currentState = RDORelevantResource::choiceEmpty;
		LPRDOPATChoiceFrom pChoiceFrom = rdo::Factory<RDOPATChoiceFrom>::create(RDOParserSrcInfo(_T("Choice NoCheck")), RDOPATChoiceFrom::ch_empty);
		ASSERT(pChoiceFrom);
		$$ = CONVERTER->stack().push(pChoiceFrom);
	}
	| pat_choice_nocheck
	{
		LPRDOPATChoiceFrom pChoiceFrom = rdo::Factory<RDOPATChoiceFrom>::create(RDOParserSrcInfo(_T("Choice NoCheck")), RDOPATChoiceFrom::ch_nocheck);
		ASSERT(pChoiceFrom);
		$$ = CONVERTER->stack().push(pChoiceFrom);
	}
	| pat_choice_from fun_logic
	{
		LPRDOFUNLogic pLogic = CONVERTER->stack().pop<RDOFUNLogic>($2);
		ASSERT(pLogic);
		LPRDOPATChoiceFrom pChoiceFrom = rdo::Factory<RDOPATChoiceFrom>::create(RDOParserSrcInfo(_T("Choice from ") + pLogic->src_text()), RDOPATChoiceFrom::ch_from, pLogic);
		ASSERT(pChoiceFrom);
		$$ = CONVERTER->stack().push(pChoiceFrom);
	}
	| pat_choice_from error
	{
		CONVERTER->error().error(@2, _T("������ � ���������� ���������"));
	}
	;

pat_choice_nocheck
	: RDO_Choice RDO_NoCheck
	{
		CONVERTER->getLastPATPattern()->m_pCurrRelRes->m_currentState = RDORelevantResource::choiceNoCheck;
	}
	;

pat_choice_from
	: RDO_Choice RDO_from
	{
		CONVERTER->getLastPATPattern()->m_pCurrRelRes->m_currentState = RDORelevantResource::choiceFrom;
	}
	;

pat_order
	: /* empty */
	{
		CONVERTER->getLastPATPattern()->m_pCurrRelRes->m_currentState = RDORelevantResource::choiceOrderEmpty;
		LPRDOPATChoiceOrder pChoiceOrder = rdo::Factory<RDOPATChoiceOrder>::create(RDOParserSrcInfo(), rdoRuntime::RDOSelectResourceCalc::order_empty);
		ASSERT(pChoiceOrder);
		$$ = CONVERTER->stack().push(pChoiceOrder);
	}
	| pat_choice_first
	{
		LPRDOPATChoiceOrder pChoiceOrder = rdo::Factory<RDOPATChoiceOrder>::create(RDOParserSrcInfo(_T("first")), rdoRuntime::RDOSelectResourceCalc::order_first);
		ASSERT(pChoiceOrder);
		$$ = CONVERTER->stack().push(pChoiceOrder);
	}
	| pat_choice_with_min fun_arithm
	{
		LPRDOFUNArithm pArithm = CONVERTER->stack().pop<RDOFUNArithm>($2);
		ASSERT(pArithm);
		LPRDOPATChoiceOrder pChoiceOrder = rdo::Factory<RDOPATChoiceOrder>::create(RDOParserSrcInfo(_T("with_min ") + pArithm->src_text()), rdoRuntime::RDOSelectResourceCalc::order_with_min, pArithm);
		ASSERT(pChoiceOrder);
		$$ = CONVERTER->stack().push(pChoiceOrder);
	}
	| pat_choice_with_max fun_arithm
	{
		LPRDOFUNArithm pArithm = CONVERTER->stack().pop<RDOFUNArithm>($2);
		ASSERT(pArithm);
		LPRDOPATChoiceOrder pChoiceOrder = rdo::Factory<RDOPATChoiceOrder>::create(RDOParserSrcInfo(_T("with_max ") + pArithm->src_text()), rdoRuntime::RDOSelectResourceCalc::order_with_max, pArithm);
		ASSERT(pChoiceOrder);
		$$ = CONVERTER->stack().push(pChoiceOrder);
	}
	| pat_choice_with_min error
	{
		CONVERTER->error().error(@2, _T("������ � �������������� ���������"));
	}
	| pat_choice_with_max error
	{
		CONVERTER->error().error(@2, _T("������ � �������������� ���������"));
	}
	;

pat_choice_first
	: RDO_first
	{
		CONVERTER->getLastPATPattern()->m_pCurrRelRes->m_currentState = RDORelevantResource::choiceOrderFirst;
	}
	;

pat_choice_with_min
	: RDO_with_min
	{
		CONVERTER->getLastPATPattern()->m_pCurrRelRes->m_currentState = RDORelevantResource::choiceOrderWithMin;
	}
	;

pat_choice_with_max
	: RDO_with_max
	{
		CONVERTER->getLastPATPattern()->m_pCurrRelRes->m_currentState = RDORelevantResource::choiceOrderWithMax;
	}
	;

pat_convert
	: pat_res_usage
	{
		LPRDOPATPattern pPattern = CONVERTER->stack().pop<RDOPATPattern>($1);
		ASSERT(pPattern);
		LPRDORelevantResource rel_res  = pPattern->m_pCurrRelRes;
		tstring str;
		if (rel_res->m_pChoiceOrder->m_type != rdoRuntime::RDOSelectResourceCalc::order_empty)
		{
			str = _T("����� ����� ��������� ����� ") + rel_res->m_pChoiceOrder->asString();
		}
		else if (rel_res->m_pChoiceFrom->m_type != RDOPATChoiceFrom::ch_empty)
		{
			str = _T("����� ����� ������� ������");
		}
		else
		{
			str = _T("����� ����� �����");
		}
		if (rel_res->m_statusBegin != rdoRuntime::RDOResource::CS_NoChange && rel_res->m_statusBegin != rdoRuntime::RDOResource::CS_Erase && rel_res->m_statusBegin != rdoRuntime::RDOResource::CS_NonExist)
		{
			switch (pPattern->getType())
			{
				case RDOPATPattern::PT_IE:
				{
					CONVERTER->error().error(@1, rdo::format(_T("%s ��������� �������� ����� Convert_event ��� ������������ ������� '%s', �.�. ��� ������ '%s', �� �������: %s"), str.c_str(), rel_res->name().c_str(), RDOPATPattern::StatusToStr(rel_res->m_statusBegin).c_str(), LEXER->YYText()));
					break;
				}
				case RDOPATPattern::PT_Rule:
				{
					CONVERTER->error().error(@1, rdo::format(_T("%s ��������� �������� ����� Convert_rule ��� ������������ ������� '%s', �.�. ��� ������ '%s', �� �������: %s"), str.c_str(), rel_res->name().c_str(), RDOPATPattern::StatusToStr(rel_res->m_statusBegin).c_str(), LEXER->YYText()));
					break;
				}
				case RDOPATPattern::PT_Operation:
				case RDOPATPattern::PT_Keyboard :
				{
					CONVERTER->error().error(@1, rdo::format(_T("%s ��������� �������� ����� Convert_begin ��� ������������ ������� '%s', �.�. ��� ������ '%s', �� �������: %s"), str.c_str(), rel_res->name().c_str(), RDOPATPattern::StatusToStr(rel_res->m_statusBegin).c_str(), LEXER->YYText()));
					break;
				}
			}
		}
		if (rel_res->m_statusEnd != rdoRuntime::RDOResource::CS_NoChange && rel_res->m_statusEnd != rdoRuntime::RDOResource::CS_Erase && rel_res->m_statusEnd != rdoRuntime::RDOResource::CS_NonExist)
		{
			switch (pPattern->getType())
			{
				case RDOPATPattern::PT_IE  :
				case RDOPATPattern::PT_Rule:
				{
					CONVERTER->error().error(@1, _T("���������� ������"));
					break;
				}
				case RDOPATPattern::PT_Operation:
				case RDOPATPattern::PT_Keyboard :
				{
					CONVERTER->error().error(@1, rdo::format(_T("%s ��������� �������� ����� Convert_end ��� ������������ ������� '%s', �.�. ��� ������ '%s', �� �������: %s"), str.c_str(), rel_res->name().c_str(), RDOPATPattern::StatusToStr(rel_res->m_statusBegin).c_str(), LEXER->YYText()));
					break;
				}
			}
		}
		$$ = CONVERTER->stack().push(pPattern);
	}
	| pat_res_usage convert_begin pat_trace pat_convert_cmd
	{
		LPRDOPATPattern pPattern = CONVERTER->stack().pop<RDOPATPattern>($1);
		ASSERT(pPattern);
		if (pPattern->getType() != RDOPATPattern::PT_Operation && pPattern->getType() != RDOPATPattern::PT_Keyboard)
		{
			tstring type = _T("");
			switch (pPattern->getType())
			{
				case RDOPATPattern::PT_IE:
				{
					type = _T("������������ �������"); 
					break;
				}
				case RDOPATPattern::PT_Rule:
				{
					type = _T("������������� �������");
					break;
				}
			}
			CONVERTER->error().error(@2, rdo::format(_T("�������� ����� Convert_begin ����� ���� ������������ � ������������ ��� ������������ ��������, �� �� � %s '%s'"), type.c_str(), pPattern->name().c_str()));
		}
		LPConvertCmdList pCmdList = CONVERTER->stack().pop<ConvertCmdList>($4);
		pPattern.object_static_cast<RDOPatternOperation>()->addRelResConvertBeginEnd($3 != 0, pCmdList, false, NULL, @2, @2, @3, @3);
		$$ = CONVERTER->stack().push(pPattern);
	}
	| pat_res_usage convert_end pat_trace pat_convert_cmd
	{
		LPRDOPATPattern pPattern = CONVERTER->stack().pop<RDOPATPattern>($1);
		ASSERT(pPattern);
		if (pPattern->getType() != RDOPATPattern::PT_Operation && pPattern->getType() != RDOPATPattern::PT_Keyboard)
		{
			tstring type = _T("");
			switch (pPattern->getType())
			{
				case RDOPATPattern::PT_IE:
				{
					type = _T("������������ �������");
					break;
				}
				case RDOPATPattern::PT_Rule:
				{
					type = _T("������������� �������");
					break;
				}
			}
			CONVERTER->error().error(@2, rdo::format(_T("�������� ����� Convert_end ����� ���� ������������ � ������������ � ������������ ��������, �� �� � %s '%s'"), type.c_str(), pPattern->name().c_str()));
		}
		LPConvertCmdList pCmdList = CONVERTER->stack().pop<ConvertCmdList>($4);
		pPattern.object_static_cast<RDOPatternOperation>()->addRelResConvertBeginEnd(false, NULL, $3 != 0, pCmdList, @2, @2, @3, @3);
		$$ = CONVERTER->stack().push(pPattern);
	}
	| pat_res_usage convert_begin pat_trace pat_convert_cmd convert_end pat_trace pat_convert_cmd
	{
		LPRDOPATPattern pPattern = CONVERTER->stack().pop<RDOPATPattern>($1);
		ASSERT(pPattern);
		if (pPattern->getType() != RDOPATPattern::PT_Operation && pPattern->getType() != RDOPATPattern::PT_Keyboard)
		{
			tstring type = _T("");
			switch (pPattern->getType())
			{
				case RDOPATPattern::PT_IE:
				{
					type = _T("������������ �������");
					break;
				}
				case RDOPATPattern::PT_Rule:
				{
					type = _T("������������� �������");
					break;
				}
			}
			CONVERTER->error().error(@2, rdo::format(_T("�������� ����� Convert_begin � Convert_end ����� ���� ������������ � ������������ � ������������ ��������, �� �� � %s '%s'"), type.c_str(), pPattern->name().c_str()));
		}
		LPConvertCmdList pCmdListBegin = CONVERTER->stack().pop<ConvertCmdList>($4);
		LPConvertCmdList pCmdListEnd   = CONVERTER->stack().pop<ConvertCmdList>($7);
		pPattern.object_static_cast<RDOPatternOperation>()->addRelResConvertBeginEnd($3 != 0, pCmdListBegin, $6 != 0, pCmdListEnd, @2, @5, @3, @6);
		$$ = CONVERTER->stack().push(pPattern);
	}
	| pat_res_usage convert_rule pat_trace pat_convert_cmd
	{
		LPRDOPATPattern pPattern = CONVERTER->stack().pop<RDOPATPattern>($1);
		ASSERT(pPattern);
		if (pPattern->getType() != RDOPATPattern::PT_Rule)
		{
			tstring type = _T("");
			switch (pPattern->getType())
			{
				case RDOPATPattern::PT_IE:
				{
					type = _T("������������ �������");
					break;
				}
				case RDOPATPattern::PT_Operation:
				{
					type = _T("��������");
					break;
				}
				case RDOPATPattern::PT_Keyboard :
				{
					type = _T("������������ ��������");
					break;
				}
			}
			CONVERTER->error().error(@2, rdo::format(_T("�������� ����� Convert_rule ����� ���� ������������ � ������������� �������, �� �� � %s '%s'"), type.c_str(), pPattern->name().c_str()));
		}
		LPConvertCmdList pCmdList = CONVERTER->stack().pop<ConvertCmdList>($4);
		ASSERT(pPattern->m_pCurrRelRes);
		pPattern->addRelResConvert($3 != 0, pCmdList, @2, @3, pPattern->m_pCurrRelRes->m_statusBegin);
		$$ = CONVERTER->stack().push(pPattern);
	}
	| pat_res_usage convert_event pat_trace pat_convert_cmd
	{
		LPRDOPATPattern pPattern = CONVERTER->stack().pop<RDOPATPattern>($1);
		ASSERT(pPattern);
		if (pPattern->getType() != RDOPATPattern::PT_IE)
		{
			tstring type = _T("");
			switch (pPattern->getType())
			{
				case RDOPATPattern::PT_Rule     :
				{
					type = _T("������������� �������");
					break;
				}
				case RDOPATPattern::PT_Operation:
				{
					type = _T("��������");
					break;
				}
				case RDOPATPattern::PT_Keyboard :
				{
					type = _T("������������ ��������");
					break;
				}
			}
			CONVERTER->error().error(@2, rdo::format(_T("�������� ����� Convert_event ����� ���� ������������ � ������� ��� � ������������ �������, �� �� � %s '%s'"), type.c_str(), pPattern->name().c_str()));
		}

		LPConvertCmdList pCmdList = CONVERTER->stack().pop<ConvertCmdList>($4);
		ASSERT(pPattern->m_pCurrRelRes);
		pPattern->addRelResConvert($3 != 0, pCmdList, @2, @3, pPattern->m_pCurrRelRes->m_statusBegin);
		$$ = CONVERTER->stack().push(pPattern);
	}
	;

convert_rule
	: RDO_Convert_rule
	{
		CONVERTER->getLastPATPattern()->m_pCurrRelRes->m_currentState = RDORelevantResource::convertBegin;
	}
	;

convert_event
	: RDO_Convert_event
	{
		CONVERTER->getLastPATPattern()->m_pCurrRelRes->m_currentState = RDORelevantResource::convertBegin;
	}
	;

convert_begin
	: RDO_Convert_begin
	{
		CONVERTER->getLastPATPattern()->m_pCurrRelRes->m_currentState = RDORelevantResource::convertBegin;
	}
	;

convert_end
	:	RDO_Convert_end
	{
		CONVERTER->getLastPATPattern()->m_pCurrRelRes->m_currentState = RDORelevantResource::convertEnd;
	}
	;

pat_convert_cmd
	: /* empty */
	{
		LPConvertCmdList pCmdList = rdo::Factory<ConvertCmdList>::create();
		LPRDORelevantResource pRelRes = CONVERTER->getLastPATPattern()->m_pCurrRelRes;
		ASSERT(pRelRes);
		pRelRes->getParamSetList().reset();
		$$ = CONVERTER->stack().push(pCmdList);
	}
	| pat_convert_cmd RDO_IDENTIF param_equal_type fun_arithm
	{
		LPConvertCmdList         pCmdList     = CONVERTER->stack().pop<ConvertCmdList>($1);
		tstring                  paramName    = RDOVALUE($2)->getIdentificator();
		rdoRuntime::EqualType    equalType    = static_cast<rdoRuntime::EqualType>($3);
		LPRDOFUNArithm           pRightArithm = CONVERTER->stack().pop<RDOFUNArithm>($4);
		LPRDORelevantResource    pRelRes      = CONVERTER->getLastPATPattern()->m_pCurrRelRes;
		ASSERT(pRelRes);
		LPRDORTPParam param = pRelRes->getType()->findRTPParam(paramName);
		if (!param)
		{
			CONVERTER->error().error(@2, rdo::format(_T("����������� ��������: %s"), paramName.c_str()));
		}
		rdoRuntime::LPRDOCalc pCalcRight = pRightArithm->createCalc(param->getType().get());
		rdoRuntime::LPRDOCalc pCalc;
		switch (equalType)
		{
			case rdoRuntime::ET_EQUAL:
			{
				pCalc = rdo::Factory<rdoRuntime::RDOSetRelResParamCalc<rdoRuntime::ET_EQUAL> >::create(pRelRes->m_relResID, pRelRes->getType()->getRTPParamNumber(paramName), pCalcRight);
				ASSERT(pCalc);
				pRelRes->getParamSetList().insert(param);
				break;
			}
			default:
			{
				NEVER_REACH_HERE;
			}
		}
		if (pCalc)
		{
			//! �������� �� ��������
			//! TODO: ��������� �����������������
			if (dynamic_cast<PTR(RDOTypeIntRange)>(param->getType().get()))
			{
				LPRDOTypeIntRange pRange = param->getType()->type().object_static_cast<RDOTypeIntRange>();
				pCalc = rdo::Factory<rdoRuntime::RDOSetRelResParamDiapCalc>::create(pRelRes->m_relResID, pRelRes->getType()->getRTPParamNumber(paramName), pRange->range()->getMin().value(), pRange->range()->getMax().value(), pCalc);
				ASSERT(pCalc);
			}
			else if (dynamic_cast<PTR(RDOTypeRealRange)>(param->getType().get()))
			{
				LPRDOTypeRealRange pRange = param->getType()->type().object_static_cast<RDOTypeRealRange>();
				pCalc = rdo::Factory<rdoRuntime::RDOSetRelResParamDiapCalc>::create(pRelRes->m_relResID, pRelRes->getType()->getRTPParamNumber(paramName), pRange->range()->getMin().value(), pRange->range()->getMax().value(), pCalc);
				ASSERT(pCalc);
			}
			tstring oprStr;
			switch (equalType)
			{
				case rdoRuntime::ET_EQUAL:
				{
					oprStr = _T("=");
					break;
				}
				default:
				{
					oprStr = _T("");
					break;
				}
			}
			pCalc->setSrcText(rdo::format(_T("%s %s %s"), paramName.c_str(), oprStr.c_str(), pCalcRight->src_text().c_str()));
			pCalc->setSrcPos (@2.m_first_line, @2.m_first_pos, @4.m_last_line, @4.m_last_pos);
			pCmdList->insertCommand(pCalc);
		}

		YYLTYPE convertor_pos = @4;

		LPDocUpdate pInsert = rdo::Factory<UpdateInsert>::create(@4.m_last_seek, _T(";"));
		ASSERT(pInsert);
		CONVERTER->insertDocUpdate(pInsert);

		$$ = CONVERTER->stack().push(pCmdList);
	}
	| pat_convert_cmd RDO_IDENTIF param_equal_type error
	{
		CONVERTER->error().error(@4, _T("������ � �������������� ���������"));
	}
	| pat_convert_cmd RDO_IDENTIF_NoChange
	{
		LPConvertCmdList pCmdList = CONVERTER->stack().pop<ConvertCmdList>($1);

		LPDocUpdate pInsert = rdo::Factory<UpdateInsert>::create(@2.m_last_seek, _T(";"));
		ASSERT(pInsert);
		CONVERTER->insertDocUpdate(pInsert);

		$$ = CONVERTER->stack().push(pCmdList);
	}
	;

param_equal_type
	: RDO_set
	{
		LPDocUpdate pDelete = rdo::Factory<UpdateDelete>::create(@1.m_first_seek, @1.m_last_seek);
		ASSERT(pDelete);
		CONVERTER->insertDocUpdate(pDelete);

		LPDocUpdate pInsert = rdo::Factory<UpdateInsert>::create(@1.m_last_seek, _T("="));
		ASSERT(pInsert);
		CONVERTER->insertDocUpdate(pInsert);

		$$ = rdoRuntime::ET_EQUAL;
	}
	;

pat_pattern
	: pat_convert RDO_End
	{
		LPRDOPATPattern pPattern = CONVERTER->stack().pop<RDOPATPattern>($1);
		if (pPattern->getType() == RDOPATPattern::PT_IE)
		{
			LPDocUpdate pPlanningInsert = rdo::Factory<UpdateInsert>::create(@1.m_last_seek, _T("\r\n\t\t" + pPattern->name() + ".Planning( Time_now + " + pPattern->time->calc()->src_text() + " );"));
			ASSERT(pPlanningInsert);
			CONVERTER->insertDocUpdate(pPlanningInsert);

			LPDocUpdate pPlanningInsertSMR = rdo::Factory<UpdateInsert>::create(0, _T(pPattern->name() + ".Planning( Time_now + " + pPattern->time->calc()->src_text() + " )\r\n"), IDocument::SMR);
			ASSERT(pPlanningInsertSMR);
			CONVERTER->insertDocUpdate(pPlanningInsertSMR);
		}
		pPattern->end();
		$$ = CONVERTER->stack().push(pPattern);
	}
	;

// ----------------------------------------------------------------------------
// ---------- �������� ���� ���������
// ----------------------------------------------------------------------------
param_type
	: RDO_integer param_type_range
	{
		rdoConverter::LPDocUpdate pReplace = rdo::Factory<rdoConverter::UpdateReplace>::create(@1.m_first_seek, @1.m_last_seek, _T("int"));
		ASSERT(pReplace);
		//CONVERTER->insertDocUpdate(pReplace);

		LPRDOTypeRangeRange pRange = CONVERTER->stack().pop<RDOTypeRangeRange>($2);
		LPRDOTypeParam pType;
		if (pRange)
		{
			if (pRange->getMin().typeID() != rdoRuntime::RDOType::t_int ||
			    pRange->getMax().typeID() != rdoRuntime::RDOType::t_int)
			{
				CONVERTER->error().error(@2, _T("�������� ������ ���� ������ ���� �������������"));
			}
			LPRDOTypeIntRange pIntRange = rdo::Factory<RDOTypeIntRange>::create(pRange);
			ASSERT(pIntRange);
			pType = rdo::Factory<RDOTypeParam>::create(pIntRange, RDOParserSrcInfo(@1, @2));
		}
		else
		{
			pType = rdo::Factory<RDOTypeParam>::create(rdo::Factory<RDOType__int>::create(), RDOParserSrcInfo(@1, @2));
		}
		ASSERT(pType);
		$$ = CONVERTER->stack().push(pType);
	}
	| RDO_real param_type_range
	{
		LPRDOTypeRangeRange pRange = CONVERTER->stack().pop<RDOTypeRangeRange>($2);
		LPRDOTypeParam pType;
		if (pRange)
		{
			LPRDOTypeRealRange pRealRange = rdo::Factory<RDOTypeRealRange>::create(pRange);
			ASSERT(pRealRange);
			pType = rdo::Factory<RDOTypeParam>::create(pRealRange, RDOParserSrcInfo(@1, @2));
		}
		else
		{
			pType = rdo::Factory<RDOTypeParam>::create(rdo::Factory<RDOType__real>::create(), RDOParserSrcInfo(@1, @2));
		}
		ASSERT(pType);
		$$ = CONVERTER->stack().push(pType);
	}
	| RDO_string
	{
		LPRDOTypeParam pType = rdo::Factory<RDOTypeParam>::create(rdo::Factory<RDOType__string>::create(), RDOParserSrcInfo(@1));
		ASSERT(pType);
		$$ = CONVERTER->stack().push(pType);
	}
	| RDO_bool
	{
		LPRDOTypeParam pType = rdo::Factory<RDOTypeParam>::create(rdo::Factory<RDOType__bool>::create(), RDOParserSrcInfo(@1));
		ASSERT(pType);
		$$ = CONVERTER->stack().push(pType);
	}
	| param_type_enum
	{
		LEXER->enumReset();
		LPRDOEnumType pEnum = CONVERTER->stack().pop<RDOEnumType>($1);
		ASSERT(pEnum);
		LPRDOTypeParam pType = rdo::Factory<RDOTypeParam>::create(pEnum, RDOParserSrcInfo(@1));
		ASSERT(pType);
		$$ = CONVERTER->stack().push(pType);
	}
	| param_type_such_as
	{
		LPRDOTypeParamSuchAs pTypeSuchAs = CONVERTER->stack().pop<RDOTypeParamSuchAs>($1);
		ASSERT(pTypeSuchAs);
		LPRDOTypeParam pType = pTypeSuchAs.object_parent_cast<RDOTypeParam>();
		ASSERT(pType);
		$$ = CONVERTER->stack().push(pType);
	}
	;

param_type_range
	: /* empty */
	{
		$$ = CONVERTER->stack().push<RDOTypeRangeRange>(LPRDOTypeRangeRange());
	}
	| '[' RDO_INT_CONST RDO_dblpoint RDO_INT_CONST ']'
	{
		LPRDOTypeRangeRange pRange = rdo::Factory<RDOTypeRangeRange>::create(RDOVALUE($2), RDOVALUE($4), RDOParserSrcInfo(@1, @5));
		ASSERT(pRange);
		pRange->checkRange();
		$$ = CONVERTER->stack().push(pRange);
	}
	| '[' RDO_REAL_CONST RDO_dblpoint RDO_REAL_CONST ']'
	{
		LPRDOTypeRangeRange pRange = rdo::Factory<RDOTypeRangeRange>::create(RDOVALUE($2), RDOVALUE($4), RDOParserSrcInfo(@1, @5));
		ASSERT(pRange);
		pRange->checkRange();
		$$ = CONVERTER->stack().push(pRange);
	}
	| '[' RDO_REAL_CONST RDO_dblpoint RDO_INT_CONST ']'
	{
		LPRDOTypeRangeRange pRange = rdo::Factory<RDOTypeRangeRange>::create(RDOVALUE($2), RDOVALUE($4), RDOParserSrcInfo(@1, @5));
		ASSERT(pRange);
		pRange->checkRange();
		$$ = CONVERTER->stack().push(pRange);
	}
	| '[' RDO_INT_CONST RDO_dblpoint RDO_REAL_CONST ']'
	{
		LPRDOTypeRangeRange pRange = rdo::Factory<RDOTypeRangeRange>::create(RDOVALUE($2), RDOVALUE($4), RDOParserSrcInfo(@1, @5));
		ASSERT(pRange);
		pRange->checkRange();
		$$ = CONVERTER->stack().push(pRange);
	}
	| '[' RDO_REAL_CONST RDO_dblpoint RDO_REAL_CONST error
	{
		CONVERTER->error().error(@4, _T("�������� ����� �������"));
	}
	| '[' RDO_REAL_CONST RDO_dblpoint RDO_INT_CONST error
	{
		CONVERTER->error().error(@4, _T("�������� ����� �������"));
	}
	| '[' RDO_INT_CONST RDO_dblpoint RDO_REAL_CONST error
	{
		CONVERTER->error().error(@4, _T("�������� ����� �������"));
	}
	| '[' RDO_INT_CONST RDO_dblpoint RDO_INT_CONST error
	{
		CONVERTER->error().error(@4, _T("�������� ����� �������"));
	}
	| '[' RDO_REAL_CONST RDO_dblpoint error
	{
		CONVERTER->error().error(@4, _T("�������� ����� �������"));
	}
	| '[' RDO_INT_CONST RDO_dblpoint error
	{
		CONVERTER->error().error(@4, _T("�������� ����� �������"));
	}
	| '[' error
	{
		CONVERTER->error().error(@2, _T("�������� ����� �������"));
	}
	;

param_type_enum
	: '(' param_type_enum_list ')'
	{
		LPRDOEnumType pEnum = CONVERTER->stack().pop<RDOEnumType>($2);
		ASSERT(pEnum);
		$$ = CONVERTER->stack().push(pEnum);
	}
	| '(' param_type_enum_list error
	{
		CONVERTER->error().error(@2, _T("������������ ������ ������������� �������"));
	}
	;

param_type_enum_list
	: RDO_IDENTIF
	{
		LPRDOEnumType pEnum = rdo::Factory<RDOEnumType>::create();
		ASSERT(pEnum);
		pEnum->add(RDOVALUE($1));
		LEXER->enumBegin();
		$$ = CONVERTER->stack().push(pEnum);
	}
	| param_type_enum_list ',' RDO_IDENTIF
	{
		if (!LEXER->enumEmpty())
		{
			LPRDOEnumType pEnum = CONVERTER->stack().pop<RDOEnumType>($1);
			ASSERT(pEnum);
			pEnum->add(RDOVALUE($3));
			$$ = CONVERTER->stack().push(pEnum);
		}
		else
		{
			CONVERTER->error().error(@3, _T("������ � �������� �������� ������������� ����"));
		}
	}
	| param_type_enum_list RDO_IDENTIF
	{
		if (!LEXER->enumEmpty())
		{
			LPRDOEnumType pEnum = CONVERTER->stack().pop<RDOEnumType>($1);
			ASSERT(pEnum);
			pEnum->add(RDOVALUE($2));
			$$ = CONVERTER->stack().push(pEnum);
			CONVERTER->error().warning(@1, rdo::format(_T("��������� ������� �����: %s"), RDOVALUE($2)->getIdentificator().c_str()));
		}
		else
		{
			CONVERTER->error().error(@2, _T("������ � �������� �������� ������������� ����"));
		}
	}
	| param_type_enum_list ',' RDO_INT_CONST
	{
		CONVERTER->error().error(@3, _T("�������� ������������� ���� �� ����� ���� ������"));
	}
	| param_type_enum_list ',' RDO_REAL_CONST
	{
		CONVERTER->error().error(@3, _T("�������� ������������� ���� �� ����� ���� ������"));
	}
	| param_type_enum_list RDO_INT_CONST
	{
		CONVERTER->error().error(@2, _T("�������� ������������� ���� �� ����� ���� ������"));
	}
	| param_type_enum_list RDO_REAL_CONST
	{
		CONVERTER->error().error(@2, _T("�������� ������������� ���� �� ����� ���� ������"));
	}
	| RDO_INT_CONST
	{
		CONVERTER->error().error(@1, _T("�������� ������������� ���� �� ����� ���������� � �����"));
	}
	| RDO_REAL_CONST
	{
		CONVERTER->error().error(@1, _T("�������� ������������� ���� �� ����� ���������� � �����"));
	}
	;

param_type_such_as
	: RDO_such_as RDO_IDENTIF '.' RDO_IDENTIF
	{
		tstring type  = RDOVALUE($2)->getIdentificator();
		tstring param = RDOVALUE($4)->getIdentificator();
		LPRDORTPResType pResType = CONVERTER->findRTPResType(type);
		if (!pResType)
		{
			CONVERTER->error().error(@2, rdo::format(_T("������ �� ����������� ��� �������: %s"), type.c_str()));
		}
		LPRDORTPParam pRTPParam = pResType->findRTPParam(param);
		if (!pRTPParam)
		{
			CONVERTER->error().error(@4, rdo::format(_T("������ �� ����������� �������� �������: %s.%s"), type.c_str(), param.c_str()));
		}
		LPRDOParam pParam = pRTPParam.object_parent_cast<RDOParam>();
		ASSERT(pParam);
		LPRDOTypeParamSuchAs pTypeSuchAs = rdo::Factory<RDOTypeParamSuchAs>::create(pParam);
		ASSERT(pTypeSuchAs);
		$$ = CONVERTER->stack().push(pTypeSuchAs);
	}
	| RDO_such_as RDO_IDENTIF
	{
		tstring constName = RDOVALUE($2)->getIdentificator();
		LPRDOFUNConstant pConstant = CONVERTER->findFUNConstant(constName);
		if (!pConstant)
		{
			CONVERTER->error().error(@2, rdo::format(_T("������ �� �������������� ���������: %s"), constName.c_str()));
		}
		LPRDOParam pParam = pConstant.object_parent_cast<RDOParam>();
		ASSERT(pParam);
		LPRDOTypeParamSuchAs pTypeSuchAs = rdo::Factory<RDOTypeParamSuchAs>::create(pParam);
		ASSERT(pTypeSuchAs);
		$$ = CONVERTER->stack().push(pTypeSuchAs);
	}
	| RDO_such_as RDO_IDENTIF '.' error
	{
		tstring type = RDOVALUE($2)->getIdentificator();
		LPRDORTPResType pResType = CONVERTER->findRTPResType(type);
		if (!pResType)
		{
			CONVERTER->error().error(@2, rdo::format(_T("������ �� ����������� ��� �������: %s"), type.c_str()));
		}
		else
		{
			CONVERTER->error().error(@4, _T("������ ��� �������� ���������"));
		}
	}
	| RDO_such_as error
	{
		CONVERTER->error().error(@2, _T("����� ��������� ����� such_as ���������� ������� ��� � ��������� ������� ��� ������"));
	}
	;

param_value_default
	: /* empty */
	{
		$$ = (int)CONVERTER->addValue(new rdoConverter::RDOValue());
	}
	| '=' RDO_INT_CONST
	{
		$$ = $2;
	}
	| '=' RDO_REAL_CONST
	{
		$$ = $2;
	}
	| '=' RDO_STRING_CONST
	{
		$$ = $2;
	}
	| '=' RDO_IDENTIF
	{
		$$ = $2;
	}
	| '=' RDO_BOOL_CONST
	{
		$$ = $2;
	}
	| '=' error
	{
		RDOParserSrcInfo src_info(@1, @2, true);
		if (src_info.src_pos().point())
		{
			CONVERTER->error().error(src_info, _T("�� ������� �������� ��-���������"));
		}
		else
		{
			CONVERTER->error().error(src_info, _T("�������� �������� ��-���������"));
		}
	}
	;

// ----------------------------------------------------------------------------
// ---------- ����� ��������� ������ ��� ���� �������� ���
// ----------------------------------------------------------------------------
// ---------- ���������� ���������
// ----------------------------------------------------------------------------
fun_logic_eq
	: '='
	{
		LPDocUpdate pInsert = rdo::Factory<UpdateInsert>::create(@1.m_last_seek, _T("="));
		ASSERT(pInsert);
		CONVERTER->insertDocUpdate(pInsert);

		$$ = RDO_eq;
	}
	| RDO_eq
	{
		$$ = RDO_eq;
	}
	;

fun_logic
	: fun_arithm fun_logic_eq fun_arithm
	{
		LPRDOFUNArithm pArithm1 = CONVERTER->stack().pop<RDOFUNArithm>($1);
		LPRDOFUNArithm pArithm2 = CONVERTER->stack().pop<RDOFUNArithm>($3);
		ASSERT(pArithm1);
		ASSERT(pArithm2);
		LPRDOFUNLogic pResult = pArithm1->operator ==(pArithm2);
		ASSERT(pResult);
		$$ = CONVERTER->stack().push(pResult);
	}
	| fun_arithm RDO_neq fun_arithm
	{
		LPRDOFUNArithm pArithm1 = CONVERTER->stack().pop<RDOFUNArithm>($1);
		LPRDOFUNArithm pArithm2 = CONVERTER->stack().pop<RDOFUNArithm>($3);
		ASSERT(pArithm1);
		ASSERT(pArithm2);
		LPRDOFUNLogic pResult = pArithm1->operator !=(pArithm2);
		ASSERT(pResult);
		$$ = CONVERTER->stack().push(pResult);
	}
	| fun_arithm '<' fun_arithm
	{
		LPRDOFUNArithm pArithm1 = CONVERTER->stack().pop<RDOFUNArithm>($1);
		LPRDOFUNArithm pArithm2 = CONVERTER->stack().pop<RDOFUNArithm>($3);
		ASSERT(pArithm1);
		ASSERT(pArithm2);
		LPRDOFUNLogic pResult = pArithm1->operator <(pArithm2);
		ASSERT(pResult);
		$$ = CONVERTER->stack().push(pResult);
	}
	| fun_arithm '>' fun_arithm
	{
		LPRDOFUNArithm pArithm1 = CONVERTER->stack().pop<RDOFUNArithm>($1);
		LPRDOFUNArithm pArithm2 = CONVERTER->stack().pop<RDOFUNArithm>($3);
		ASSERT(pArithm1);
		ASSERT(pArithm2);
		LPRDOFUNLogic pResult = pArithm1->operator >(pArithm2);
		ASSERT(pResult);
		$$ = CONVERTER->stack().push(pResult);
	}
	| fun_arithm RDO_leq fun_arithm
	{
		LPRDOFUNArithm pArithm1 = CONVERTER->stack().pop<RDOFUNArithm>($1);
		LPRDOFUNArithm pArithm2 = CONVERTER->stack().pop<RDOFUNArithm>($3);
		ASSERT(pArithm1);
		ASSERT(pArithm2);
		LPRDOFUNLogic pResult = pArithm1->operator <=(pArithm2);
		ASSERT(pResult);
		$$ = CONVERTER->stack().push(pResult);
	}
	| fun_arithm RDO_geq fun_arithm
	{
		LPRDOFUNArithm pArithm1 = CONVERTER->stack().pop<RDOFUNArithm>($1);
		LPRDOFUNArithm pArithm2 = CONVERTER->stack().pop<RDOFUNArithm>($3);
		ASSERT(pArithm1);
		ASSERT(pArithm2);
		LPRDOFUNLogic pResult = pArithm1->operator >=(pArithm2);
		ASSERT(pResult);
		$$ = CONVERTER->stack().push(pResult);
	}
	| fun_logic RDO_and fun_logic
	{
		LPRDOFUNLogic pLogic1 = CONVERTER->stack().pop<RDOFUNLogic>($1);
		LPRDOFUNLogic pLogic2 = CONVERTER->stack().pop<RDOFUNLogic>($3);
		ASSERT(pLogic1);
		ASSERT(pLogic2);
		LPRDOFUNLogic pResult = pLogic1->operator &&(pLogic2);
		ASSERT(pResult);
		$$ = CONVERTER->stack().push(pResult);
	}
	| fun_logic RDO_or fun_logic
	{
		LPRDOFUNLogic pLogic1 = CONVERTER->stack().pop<RDOFUNLogic>($1);
		LPRDOFUNLogic pLogic2 = CONVERTER->stack().pop<RDOFUNLogic>($3);
		ASSERT(pLogic1);
		ASSERT(pLogic2);
		LPRDOFUNLogic pResult = pLogic1->operator ||(pLogic2);
		ASSERT(pResult);
		$$ = CONVERTER->stack().push(pResult);
	}
	| fun_arithm
	{
		LPRDOFUNArithm pArithm = CONVERTER->stack().pop<RDOFUNArithm>($1);
		ASSERT(pArithm);
		LPRDOFUNLogic pResult = rdo::Factory<RDOFUNLogic>::create(pArithm);
		ASSERT(pResult);
		$$ = CONVERTER->stack().push(pResult);
	}
	| fun_group
	| fun_select_logic
	| '[' fun_logic ']'
	{
		LPRDOFUNLogic pLogic = CONVERTER->stack().pop<RDOFUNLogic>($2);
		ASSERT(pLogic);
		pLogic->setSrcPos (@1, @3);
		pLogic->setSrcText(_T("[") + pLogic->src_text() + _T("]"));
		$$ = CONVERTER->stack().push(pLogic);
	}
	| '(' fun_logic ')'
	{
		LPRDOFUNLogic pLogic = CONVERTER->stack().pop<RDOFUNLogic>($2);
		ASSERT(pLogic);
		pLogic->setSrcPos (@1, @3);
		pLogic->setSrcText(_T("(") + pLogic->src_text() + _T(")"));
		$$ = CONVERTER->stack().push(pLogic);
	}
	| RDO_not fun_logic
	{
		LPRDOFUNLogic pLogic = CONVERTER->stack().pop<RDOFUNLogic>($2);
		ASSERT(pLogic);
		LPRDOFUNLogic pLogicNot = pLogic->operator_not();
		ASSERT(pLogicNot);
		pLogicNot->setSrcPos (@1, @2);
		pLogicNot->setSrcText(_T("not ") + pLogic->src_text());
		$$ = CONVERTER->stack().push(pLogicNot);
	}
	| '[' fun_logic error
	{
		CONVERTER->error().error(@2, _T("��������� ������������� ������"));
	}
	| '(' fun_logic error
	{
		CONVERTER->error().error(@2, _T("��������� ������������� ������"));
	}
	;

// ----------------------------------------------------------------------------
// ---------- �������������� ���������
// ----------------------------------------------------------------------------
fun_arithm
	: RDO_INT_CONST                      { $$ = CONVERTER->stack().push(rdo::Factory<RDOFUNArithm>::create(RDOVALUE($1))); }
	| RDO_REAL_CONST                     { $$ = CONVERTER->stack().push(rdo::Factory<RDOFUNArithm>::create(RDOVALUE($1))); }
	| RDO_BOOL_CONST                     { $$ = CONVERTER->stack().push(rdo::Factory<RDOFUNArithm>::create(RDOVALUE($1))); }
	| RDO_STRING_CONST                   { $$ = CONVERTER->stack().push(rdo::Factory<RDOFUNArithm>::create(RDOVALUE($1))); }
	| RDO_IDENTIF                        { $$ = CONVERTER->stack().push(rdo::Factory<RDOFUNArithm>::create(RDOVALUE($1))); }
	| RDO_IDENTIF '.' RDO_IDENTIF        { $$ = CONVERTER->stack().push(rdo::Factory<RDOFUNArithm>::create(RDOVALUE($1), RDOVALUE($3))); }
	| RDO_IDENTIF_RELRES '.' RDO_IDENTIF { $$ = CONVERTER->stack().push(rdo::Factory<RDOFUNArithm>::create(RDOVALUE($1), RDOVALUE($3))); }
	| fun_arithm '+' fun_arithm
	{
		LPRDOFUNArithm pArithm1 = CONVERTER->stack().pop<RDOFUNArithm>($1);
		LPRDOFUNArithm pArithm2 = CONVERTER->stack().pop<RDOFUNArithm>($3);
		ASSERT(pArithm1);
		ASSERT(pArithm2);
		LPRDOFUNArithm pResult = pArithm1->operator +(pArithm2);
		ASSERT(pResult);
		$$ = CONVERTER->stack().push(pResult);
	}
	| fun_arithm '-' fun_arithm
	{
		LPRDOFUNArithm pArithm1 = CONVERTER->stack().pop<RDOFUNArithm>($1);
		LPRDOFUNArithm pArithm2 = CONVERTER->stack().pop<RDOFUNArithm>($3);
		ASSERT(pArithm1);
		ASSERT(pArithm2);
		LPRDOFUNArithm pResult = pArithm1->operator -(pArithm2);
		ASSERT(pResult);
		$$ = CONVERTER->stack().push(pResult);
	}
	| fun_arithm '*' fun_arithm
	{
		LPRDOFUNArithm pArithm1 = CONVERTER->stack().pop<RDOFUNArithm>($1);
		LPRDOFUNArithm pArithm2 = CONVERTER->stack().pop<RDOFUNArithm>($3);
		ASSERT(pArithm1);
		ASSERT(pArithm2);
		LPRDOFUNArithm pResult = pArithm1->operator *(pArithm2);
		ASSERT(pResult);
		$$ = CONVERTER->stack().push(pResult);
	}
	| fun_arithm '/' fun_arithm
	{
		LPRDOFUNArithm pArithm1 = CONVERTER->stack().pop<RDOFUNArithm>($1);
		LPRDOFUNArithm pArithm2 = CONVERTER->stack().pop<RDOFUNArithm>($3);
		ASSERT(pArithm1);
		ASSERT(pArithm2);
		LPRDOFUNArithm pResult = pArithm1->operator /(pArithm2);
		ASSERT(pResult);
		$$ = CONVERTER->stack().push(pResult);
	}
	| fun_arithm_func_call
	| fun_select_arithm
	| '(' fun_arithm ')'
	{
		LPRDOFUNArithm pArithm = CONVERTER->stack().pop<RDOFUNArithm>($2);
		ASSERT(pArithm);
		pArithm->setSrcPos (@1, @3);
		pArithm->setSrcText(_T("(") + pArithm->src_text() + _T(")"));
		$$ = CONVERTER->stack().push(pArithm);
	}
	| '-' fun_arithm %prec RDO_UMINUS
	{
		LPRDOFUNArithm pArithm = CONVERTER->stack().pop<RDOFUNArithm>($2);
		ASSERT(pArithm);
		RDOParserSrcInfo info;
		info.setSrcPos (@1, @2);
		info.setSrcText(_T("-") + pArithm->src_text());
		$$ = CONVERTER->stack().push(rdo::Factory<RDOFUNArithm>::create(RDOValue(pArithm->type(), info), rdo::Factory<rdoRuntime::RDOCalcUMinus>::create(info.src_pos(), pArithm->createCalc())));
	}
	;

// ----------------------------------------------------------------------------
// ---------- ������� � ������������������
// ----------------------------------------------------------------------------
fun_arithm_func_call
	: RDO_IDENTIF '(' ')'
	{
		LPRDOFUNParams pFunParams = rdo::Factory<RDOFUNParams>::create();
		ASSERT(pFunParams);
		tstring funName = RDOVALUE($1)->getIdentificator();
		pFunParams->getFunseqName().setSrcInfo(RDOParserSrcInfo(@1, funName));
		pFunParams->setSrcPos (@1, @3);
		pFunParams->setSrcText(funName + _T("()"));
		LPRDOFUNArithm pArithm = pFunParams->createCall(funName);
		ASSERT(pArithm);
		$$ = CONVERTER->stack().push(pArithm);
	}
	| RDO_IDENTIF '(' fun_arithm_func_call_pars ')'
	{
		LPRDOFUNParams pFunParams = CONVERTER->stack().pop<RDOFUNParams>($3);
		ASSERT(pFunParams);
		tstring funName = RDOVALUE($1)->getIdentificator();
		pFunParams->getFunseqName().setSrcInfo(RDOParserSrcInfo(@1, funName));
		pFunParams->setSrcPos (@1, @4);
		pFunParams->setSrcText(funName + _T("(") + pFunParams->src_text() + _T(")"));
		LPRDOFUNArithm pArithm = pFunParams->createCall(funName);
		ASSERT(pArithm);
		$$ = CONVERTER->stack().push(pArithm);
	}
	| RDO_IDENTIF '(' error
	{
		CONVERTER->error().error(@3, _T("������ � ���������� �������"));
	}
	;

fun_arithm_func_call_pars
	: fun_arithm
	{
		LPRDOFUNParams pFunParams = rdo::Factory<RDOFUNParams>::create();
		LPRDOFUNArithm pArithm    = CONVERTER->stack().pop<RDOFUNArithm>($1);
		ASSERT(pFunParams);
		ASSERT(pArithm   );
		pFunParams->setSrcText  (pArithm->src_text());
		pFunParams->addParameter(pArithm);
		$$ = CONVERTER->stack().push(pFunParams);
	}
	| fun_arithm_func_call_pars ',' fun_arithm
	{
		LPRDOFUNParams pFunParams = CONVERTER->stack().pop<RDOFUNParams>($1);
		LPRDOFUNArithm pArithm    = CONVERTER->stack().pop<RDOFUNArithm>($3);
		ASSERT(pFunParams);
		ASSERT(pArithm   );
		pFunParams->setSrcText  (pFunParams->src_text() + _T(", ") + pArithm->src_text());
		pFunParams->addParameter(pArithm);
		$$ = CONVERTER->stack().push(pFunParams);
	}
	| fun_arithm_func_call_pars error
	{
		CONVERTER->error().error(@2, _T("������ � �������������� ���������"));
	}
	| fun_arithm_func_call_pars ',' error
	{
		CONVERTER->error().error(@3, _T("������ � �������������� ���������"));
	}
	;

// ----------------------------------------------------------------------------
// ---------- ��������� ���������
// ----------------------------------------------------------------------------
fun_group_keyword
	: RDO_Exist       { $$ = RDOFUNGroupLogic::fgt_exist;     }
	| RDO_Not_Exist   { $$ = RDOFUNGroupLogic::fgt_notexist;  }
	| RDO_For_All     { $$ = RDOFUNGroupLogic::fgt_forall;    }
	| RDO_Not_For_All { $$ = RDOFUNGroupLogic::fgt_notforall; }
	;

fun_group_header
	: fun_group_keyword '(' RDO_IDENTIF_COLON
	{
		PTR(RDOValue) type_name = P_RDOVALUE($3);
		$$ = CONVERTER->stack().push(rdo::Factory<RDOFUNGroupLogic>::create((RDOFUNGroupLogic::FunGroupType)$1, type_name->src_info()));
	}
	| fun_group_keyword '(' error
	{
		CONVERTER->error().error(@3, _T("��������� ��� ����"));
	}
	| fun_group_keyword error
	{
		CONVERTER->error().error(@1, _T("����� ����� ������� ��������� ������������� ������"));
	}
	;

fun_group
	: fun_group_header fun_logic ')'
	{
		LPRDOFUNGroupLogic pGroupFun = CONVERTER->stack().pop<RDOFUNGroupLogic>($1);
		LPRDOFUNLogic      pLogic    = CONVERTER->stack().pop<RDOFUNLogic>     ($2);
		ASSERT(pGroupFun);
		ASSERT(pLogic   );
		pGroupFun->setSrcPos(@1, @3);
		$$ = CONVERTER->stack().push(pGroupFun->createFunLogic(pLogic));
	}
	| fun_group_header RDO_NoCheck ')'
	{
		LPRDOFUNGroupLogic pGroupFun = CONVERTER->stack().pop<RDOFUNGroupLogic>($1);
		ASSERT(pGroupFun);
		pGroupFun->setSrcPos(@1, @3);
		LPRDOFUNLogic pTrueLogic = rdo::Factory<RDOFUNLogic>::create(rdo::Factory<rdoRuntime::RDOCalcConst>::create(1), false);
		ASSERT(pTrueLogic);
		pTrueLogic->setSrcPos (@2);
		pTrueLogic->setSrcText(_T("NoCheck"));
		$$ = CONVERTER->stack().push(pGroupFun->createFunLogic(pTrueLogic));
	}
	| fun_group_header fun_logic error
	{
		CONVERTER->error().error(@2, _T("��������� ������������� ������"));
	}
	| fun_group_header RDO_NoCheck error
	{
		CONVERTER->error().error(@2, _T("��������� ������������� ������"));
	}
	| fun_group_header error
	{
		CONVERTER->error().error(@1, @2, _T("������ � ���������� ���������"));
	}
	;

// ----------------------------------------------------------------------------
// ---------- Select
// ----------------------------------------------------------------------------
fun_select_header
	: RDO_Select '(' RDO_IDENTIF_COLON
	{
		PTR(RDOValue)  type_name = P_RDOVALUE($3);
		LPRDOFUNSelect pSelect   = rdo::Factory<RDOFUNSelect>::create(type_name->src_info());
		ASSERT(pSelect);
		pSelect->setSrcText(_T("Select(") + type_name->value().getIdentificator() + _T(": "));
		$$ = CONVERTER->stack().push(pSelect);
	}
	| RDO_Select '(' error
	{
		CONVERTER->error().error(@3, _T("��������� ��� ����"));
	}
	| RDO_Select error
	{
		CONVERTER->error().error(@1, _T("��������� ������������� ������"));
	}
	;

fun_select_body
	: fun_select_header fun_logic ')'
	{
		LPRDOFUNSelect pSelect = CONVERTER->stack().pop<RDOFUNSelect>($1);
		LPRDOFUNLogic  pLogic  = CONVERTER->stack().pop<RDOFUNLogic> ($2);
		ASSERT(pSelect);
		ASSERT(pLogic );
		pSelect->setSrcText(pSelect->src_text() + pLogic->src_text() + _T(")"));
		pSelect->initSelect(pLogic);
		$$ = CONVERTER->stack().push(pSelect);
	}
	| fun_select_header RDO_NoCheck ')'
	{
		LPRDOFUNSelect pSelect = CONVERTER->stack().pop<RDOFUNSelect>($1);
		ASSERT(pSelect);
		RDOParserSrcInfo logicInfo(@2, _T("NoCheck"));
		pSelect->setSrcText(pSelect->src_text() + logicInfo.src_text() + _T(")"));
		rdoRuntime::LPRDOCalcConst pCalc  = rdo::Factory<rdoRuntime::RDOCalcConst>::create(1);
		ASSERT(pCalc);
		LPRDOFUNLogic pLogic = rdo::Factory<RDOFUNLogic>::create(pCalc, true);
		ASSERT(pLogic);
		pLogic->setSrcInfo(logicInfo);
		pSelect->initSelect(pLogic);
		$$ = CONVERTER->stack().push(pSelect);
	}
	| fun_select_header fun_logic error
	{
		CONVERTER->error().error(@2, _T("��������� ������������� ������"));
	}
	| fun_select_header RDO_NoCheck error
	{
		CONVERTER->error().error(@2, _T("��������� ������������� ������"));
	}
	| fun_select_header error
	{
		CONVERTER->error().error(@1, @2, _T("������ � ���������� ���������"));
	}
	;

fun_select_keyword
	: RDO_Exist			{ $$ = RDOFUNGroupLogic::fgt_exist;     }
	| RDO_Not_Exist		{ $$ = RDOFUNGroupLogic::fgt_notexist;  }
	| RDO_For_All		{ $$ = RDOFUNGroupLogic::fgt_forall;    }
	| RDO_Not_For_All	{ $$ = RDOFUNGroupLogic::fgt_notforall; }
	;

fun_select_logic
	: fun_select_body '.' fun_select_keyword '(' fun_logic ')'
	{
		LPRDOFUNSelect pSelect = CONVERTER->stack().pop<RDOFUNSelect>($1);
		LPRDOFUNLogic  pLogic  = CONVERTER->stack().pop<RDOFUNLogic> ($5);
		ASSERT(pSelect);
		ASSERT(pLogic );
		pSelect->setSrcPos(@1, @6);
		LPRDOFUNLogic pLogicSelect = pSelect->createFunSelectGroup((RDOFUNGroupLogic::FunGroupType)$3, pLogic);
		ASSERT(pLogicSelect);
		$$ = CONVERTER->stack().push(pLogicSelect);
	}
	| fun_select_body '.' fun_select_keyword '(' error
	{
		CONVERTER->error().error(@4, @5, _T("������ � ���������� ���������"));
	}
	| fun_select_body '.' fun_select_keyword error
	{
		CONVERTER->error().error(@3, _T("��������� ������������� ������"));
	}
	| fun_select_body '.' RDO_Empty '(' ')'
	{
		LPRDOFUNSelect pSelect = CONVERTER->stack().pop<RDOFUNSelect>($1);
		ASSERT(pSelect);
		pSelect->setSrcPos(@1, @5);
		RDOParserSrcInfo emptyInfo(@3, @5, _T("Empty()"));
		LPRDOFUNLogic pLogic = pSelect->createFunSelectEmpty(emptyInfo);
		ASSERT(pLogic);
		$$ = CONVERTER->stack().push(pLogic);
	}
	| fun_select_body '.' RDO_Empty '(' error
	{
		CONVERTER->error().error(@4, _T("��������� ������������� ������"));
	}
	| fun_select_body '.' RDO_Empty error
	{
		CONVERTER->error().error(@3, _T("��������� ������������� ������"));
	}
	| fun_select_body '.' error
	{
		CONVERTER->error().error(@2, @3, _T("��������� ����� ������ ��������"));
	}
	| fun_select_body error
	{
		CONVERTER->error().error(@1, _T("��������� '.' (�����) ��� ������ ������ ������ ��������"));
	}
	;

fun_select_arithm
	: fun_select_body '.' RDO_Size '(' ')'
	{
		LPRDOFUNSelect pSelect = CONVERTER->stack().pop<RDOFUNSelect>($1);
		ASSERT(pSelect);
		pSelect->setSrcPos(@1, @5);
		RDOParserSrcInfo sizeInfo(@3, @5, _T("Size()"));
		LPRDOFUNArithm pArithm = pSelect->createFunSelectSize(sizeInfo);
		ASSERT(pArithm);
		$$ = CONVERTER->stack().push(pArithm);
	}
	| fun_select_body '.' RDO_Size error
	{
		CONVERTER->error().error(@3, _T("��������� ������������� ������"));
	}
	| fun_select_body '.' RDO_Size '(' error
	{
		CONVERTER->error().error(@4, _T("��������� ������������� ������"));
	}
	;

%%

CLOSE_RDO_CONVERTER_NAMESPACE
