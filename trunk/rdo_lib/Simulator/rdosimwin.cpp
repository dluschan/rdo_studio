#pragma warning(disable : 4786)  

#include "..\\memcheck.h"
#ifdef _DEBUG
#define new DEBUG_NEW
#undef THIS_FILE
static char THIS_FILE[] = __FILE__;
#endif

#include <stdio.h>
#include <conio.h>
#include <fstream>
#include <iostream>
#include <functional>
#include <vector>
#include <list>
#include <map>
#include <math.h>
#include <sstream>

#include "rdosimwin.h"
#include "rdokernel.h"
#include "rdorepository.h"

#include "rdoparser.h"
#include "rdoruntime.h"
#include "rdosmr.h"
#include "rdofrm.h"

RdoSimulator::RdoSimulator(): 
	runtime(NULL), 
	parser(NULL), 
	th(NULL)
{}

RdoSimulator::~RdoSimulator()
{
	terminateModel();
	closeModel();
}

UINT RunningThreadControllingFunction( LPVOID pParam )
{
	RdoSimulator *simulator = (RdoSimulator *)pParam;

	RDOTrace *tracer;
	rdoRuntime::RDOResult *resulter;

/////////////////   Creating tracer and resulter //////////////////////////////////
		if(simulator->parser->smr->traceFileName == NULL) 
			tracer = new RDOTrace();
		else
			tracer = new RDOTrace(*simulator->parser->smr->traceFileName + ".trc");
//			tracer = new RDOTrace("trace.trc");

		resulter;
		if(simulator->parser->smr->resultsFileName == NULL) 
			resulter = new rdoRuntime::RDOResult();
		else
			resulter = new rdoRuntime::RDOResult((*simulator->parser->smr->resultsFileName + ".pmv").c_str());


/////////  RDO config initialization ////////////////////////
		simulator->runtime->config.showAnimation = (RdoShowMode)simulator->parser->smr->showMode;
		int size = simulator->runtime->allFrames.size();
		for(int i = 0; i < size; i++)
			simulator->runtime->config.allFrameNames.push_back(*simulator->runtime->allFrames.at(i)->getName());

		simulator->runtime->config.currFrameToShow = simulator->parser->smr->frameNumber - 1;
		simulator->runtime->config.keysPressed.clear();
		simulator->runtime->config.mouseClicked = false;
		simulator->runtime->config.activeAreasMouseClicked.clear();
		simulator->runtime->config.frame = NULL;
		simulator->runtime->config.currTime = 0;
		simulator->runtime->config.newTime = 0;
		if(simulator->parser->smr->showRate)
			simulator->runtime->config.showRate = *simulator->parser->smr->showRate;
		else
			simulator->runtime->config.showRate = 60;	// default
		simulator->runtime->config.realTimeDelay = 0;




////////////////////////////////////////////////////////////////
/////////////////   Modelling	//////////////////////////////////
////////////////////////////////////////////////////////////////


	simulator->runtime->tracerCallBack = NULL;
	simulator->runtime->param = pParam;
	simulator->runtime->frameCallBack = NULL;

	try
	{
		try {
			simulator->runtime->rdoInit(tracer, resulter);
		}
		catch(RDOException &ex) {
			string mess = ex.getType() + " : " + ex.mess + " during initialisation\n";
			kernel.notifyString(RDOKernel::debugString, mess);
			kernel.notify(RDOKernel::executeError);
			throw;
		}

		kernel.notifyString(RDOKernel::debugString, "Start executing");
		try {
			simulator->runtime->rdoRun();
		}
		catch(RDOException &ex) {
			string mess = ex.getType() + " : " + ex.mess + " during execution\n";
			kernel.notifyString(RDOKernel::debugString, mess);
			kernel.notify(RDOKernel::executeError);
			throw;
		}
		try {
			simulator->runtime->rdoDestroy();
		}
		catch(RDOException &ex) {
			string mess = ex.getType() + " : " + ex.mess + " during ending\n";
			kernel.notifyString(RDOKernel::debugString, mess);
			kernel.notify(RDOKernel::executeError);
			throw;
		}
		kernel.notify(RDOKernel::endExecuteModel);
		kernel.notifyString(RDOKernel::debugString, "End executing");
	}
	catch(RDOException &)
	{
	}

	simulator->th = NULL;

	return 0;
}

bool RdoSimulator::parseModel()
{
	terminateModel();
	closeModel();

	parser = new rdoParse::RDOParser();
	runtime = parser->runTime;

	ostringstream consol;

	try {
/////////////////   SMR file //////////////////////////////////
		strstream SMRstream;
		kernel.getRepository()->loadSMR(SMRstream);
		if(SMRstream.good())
			parser->parseSMR1(&SMRstream, &consol);

/////////////////   RTP file //////////////////////////////////
		strstream RTPstream1;
		kernel.getRepository()->loadRTP(RTPstream1);
		if(RTPstream1.good())
			parser->parseRTP(&RTPstream1, &consol);

/////////////////   RSS file //////////////////////////////////
		strstream RSSstream;
		kernel.getRepository()->loadRSS(RSSstream);
		if(RSSstream.good())
			parser->parseRSS(&RSSstream, &consol);

/////////////////   FUN file //////////////////////////////////
		strstream FUNstream;
		kernel.getRepository()->loadFUN(FUNstream);
		if(FUNstream.good())
			parser->parseFUN(&FUNstream, &consol);

/////////////////   PAT file //////////////////////////////////
		strstream PATstream;
		kernel.getRepository()->loadPAT(PATstream);
		if(PATstream.good())
			parser->parsePAT(&PATstream, &consol);

/////////////////   OPR file //////////////////////////////////
		strstream OPRstream;
		kernel.getRepository()->loadOPR(OPRstream);
		if(OPRstream.good())
			parser->parseOPR(&OPRstream, &consol);

/////////////////   DPT file //////////////////////////////////
		strstream DPTstream;
		kernel.getRepository()->loadDPT(DPTstream);
		if(DPTstream.good())
			parser->parseDPT(&DPTstream, &consol);

/////////////////   PMD file //////////////////////////////////
		strstream PMDstream;
		kernel.getRepository()->loadPMD(PMDstream);
		if(PMDstream.good())
			parser->parsePMD(&PMDstream, &consol);

/////////////////   FRM file //////////////////////////////////
		strstream FRMstream;
		kernel.getRepository()->loadFRM(FRMstream);
		if(FRMstream.good())
			parser->parseFRM(&FRMstream, &consol);

/////////////////   SMR file //////////////////////////////////
		strstream SMRstream2;
		kernel.getRepository()->loadSMR(SMRstream2);
		if(SMRstream2.good())
			parser->parseSMR2(&SMRstream2, &consol);
	}
	catch(RDOException &ex) {
		string mess = ex.getType() + " : " + ex.mess + " in file";
		kernel.notifyString(RDOKernel::buildString, mess);
		kernel.notify(RDOKernel::parseError);
		closeModel();
		return false;
	}

	return true;
}

void RdoSimulator::runModel()
{
	bool res = parseModel();
	if(res)
	{
		kernel.notify(RDOKernel::modelStarted);
		kernel.notifyString( RDOKernel::debugString, "Start execute model\r\n" );
		th = AfxBeginThread(RunningThreadControllingFunction, (LPVOID)this);
	}
}

void RdoSimulator::stopModel()
{
	terminateModel();
	kernel.notify(RDOKernel::modelStopped);
}

void RdoSimulator::terminateModel()
{
	if(th != NULL)
	{
		TerminateThread(th->m_hThread, -1);
		delete th;
		th = NULL;
	}
}

void RdoSimulator::closeModel()
{
	if(runtime)
		delete runtime;
	runtime = NULL;

	if(parser)
		delete parser;
	parser = NULL;
}

void RdoSimulator::parseSMRFileInfo( strstream& smr, rdoModelObjects::RDOSMRFileInfo& info )
{
	terminateModel();
	closeModel();

	parser = new rdoParse::RDOParser();
	runtime = parser->runTime;

	ostringstream consol;

	try {
		parser->parseSMR1(&smr, &consol);
	}
	catch(RDOException &ex) {
		string mess = ex.getType() + " : " + ex.mess + " in the first part of SMR file";
		kernel.notifyString(RDOKernel::buildString, mess);
		kernel.notify(RDOKernel::parseSMRError);
		closeModel();
		return;
	}

	kernel.notifyString(RDOKernel::buildString, "SMR File read successfully");

	if(parser->smr->modelName)
		info.model_name = *parser->smr->modelName;

	if(parser->smr->resourceFileName)
		info.resource_file = *parser->smr->resourceFileName;

	if(parser->smr->oprIevFileName)
		info.oprIev_file = *parser->smr->oprIevFileName;

	if(parser->smr->frameFileName)
		info.frame_file = *parser->smr->frameFileName;

	if(parser->smr->statisticFileName)
		info.statistic_file = *parser->smr->statisticFileName;

	if(parser->smr->resultsFileName)
		info.results_file = *parser->smr->resultsFileName;

	if(parser->smr->traceFileName)
		info.trace_file = *parser->smr->traceFileName;

	closeModel();
}
