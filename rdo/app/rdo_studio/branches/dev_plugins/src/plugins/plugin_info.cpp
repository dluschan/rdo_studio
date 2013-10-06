/*!
  \copyright (c) RDO-Team, 2013
  \file      rdo_plugin_test/src/plugininfo.cpp
  \author    Чернов Алексей (ChernovAlexeyOlegovich@gmail.com)
  \date      22.09.2013
  \brief     
  \indent    4T
*/

// ---------------------------------------------------------------------------- PCH
#include "app/rdo_studio/pch/stdpch.h"
// ----------------------------------------------------------------------- INCLUDES
// ----------------------------------------------------------------------- SYNOPSIS
#include "app/rdo_studio/src/plugin_info.h"
// --------------------------------------------------------------------------------

PluginInfo::PluginInfo(const QString& name , QPluginLoader* loader  , bool  autoload,
	                   const QUuid&   GUID , const QString& author  , const QString& version , int state)
	: pluginName     (name)
	, pluginLoader   (loader)
	, pluginAuthor   (author)
	, pluginVersion  (version)
	, pluginAutoload (autoload)
	, pluginGUID     (GUID)
	, pluginState    (state)
	, pluginIsActive (false)
{}

const QString& PluginInfo::getName () const
{
	return pluginName;
}

QPluginLoader* PluginInfo::getLoader ()
{
	return pluginLoader;
}

bool PluginInfo::getAutoload () const
{
	return pluginAutoload;
}

const QUuid& PluginInfo::getGUID () const
{
	return pluginGUID;
}

int PluginInfo::getState () const
{
	return pluginState;
}

const QString& PluginInfo::getVersion () const
{
	return pluginVersion;
}

const QString& PluginInfo::getAuthor () const
{
	return pluginAuthor;
}

void PluginInfo::setState (int value)
{
	pluginState = value;
}

void PluginInfo::setAutoload (bool value)
{
	pluginAutoload = value;
}

bool PluginInfo::isActive () const
{
	return pluginIsActive;
}

void PluginInfo::setActive (bool value)
{
	pluginIsActive = value;
}

bool PluginInfo::pluginSignInfoIsEqual(const PluginInfo& scndPlgn)
{
	return ( pluginName    == scndPlgn.getName()    &&
	         pluginAuthor  == scndPlgn.getAuthor()  &&
	         pluginVersion == scndPlgn.getVersion() );
}

bool PluginInfo::isAvailable()
{
	return !( pluginState == rdo::Plugin::Deleted       ||
	          pluginState == rdo::Plugin::IdOnlyMatched );
}

