#ifndef RDOBASEEDITSTYLE_H
#define RDOBASEEDITSTYLE_H
#pragma once

#include "rdobasectrlstyle.h"
#include "sci/Scintilla.h"

namespace rdoEditCtrl {

// ----------------------------------------------------------------------------
// ---------- RDOBaseEditTheme
// ----------------------------------------------------------------------------
enum RDOBookmarkStyle {
	RDOBOOKMARKS_NONE = 0,
	RDOBOOKMARKS_CIRCLE,
	RDOBOOKMARKS_RECT,
	RDOBOOKMARKS_ROUNDRECT,
	RDOBOOKMARKS_ARROW
};

enum RDOFoldStyle {
	RDOFOLDS_NONE = 0,
	RDOFOLDS_PLUS,
	RDOFOLDS_PLUSCONNECTED,
	RDOFOLDS_ARROW,
	RDOFOLDS_ARROWCONNECTED,
	RDOFOLDS_BOXCONNECTED,
	RDOFOLDS_CIRCLECONNECTED
};

class RDOBaseEditTheme
{
public:
	RDOBaseEditTheme();
	virtual ~RDOBaseEditTheme();

	RDOBaseEditTheme& operator =( const RDOBaseEditTheme& theme );
	bool operator ==( const RDOBaseEditTheme& theme ) const;
	bool operator !=( const RDOBaseEditTheme& theme ) const;

	virtual void load( std::string regPath );
	virtual void save( std::string regPath ) const;

	COLORREF defaultColor;
	COLORREF backgroundColor;

	COLORREF caretColor;
	COLORREF selectionBgColor;
	COLORREF bookmarkFgColor;
	COLORREF bookmarkBgColor;
	COLORREF foldFgColor;
	COLORREF foldBgColor;

	RDOFontStyle defaultStyle;

	RDOBookmarkStyle bookmarkStyle;
	RDOFoldStyle     foldStyle;

	virtual bool styleDefault( const int styleType ) const;
	virtual bool styleUsing( const int styleType ) const;
	virtual bool styleBold( const int styleType = STYLE_DEFAULT ) const;
	virtual bool styleItalic( const int styleType = STYLE_DEFAULT ) const;
	virtual std::string styleFGColorToHEX( const int styleType = STYLE_DEFAULT ) const;
	virtual std::string styleBGColorToHEX( const int styleType = STYLE_DEFAULT ) const;

	static RDOBaseEditTheme getDefaultTheme();
	static std::string colorToHEX( const COLORREF color );
};

// ----------------------------------------------------------------------------
// ---------- RDOBaseEditTab
// ----------------------------------------------------------------------------
class RDOBaseEditTab
{
public:
	RDOBaseEditTab();
	virtual ~RDOBaseEditTab();

	RDOBaseEditTab& operator =( const RDOBaseEditTab& tab );
	bool operator ==( const RDOBaseEditTab& tab ) const;
	bool operator !=( const RDOBaseEditTab& tab ) const;

	virtual void load( std::string regPath );
	virtual void save( std::string regPath ) const;

	int tabSize;
	int indentSize;
	bool useTabs;
	bool tabIndents;
	bool backspaceUntabs;
	bool autoIndent;
};

// ----------------------------------------------------------------------------
// ---------- RDOBaseEditWindow
// ----------------------------------------------------------------------------
class RDOBaseEditWindow
{
public:
	RDOBaseEditWindow();
	virtual ~RDOBaseEditWindow();

	RDOBaseEditWindow& operator =( const RDOBaseEditWindow& window );
	bool operator ==( const RDOBaseEditWindow& window ) const;
	bool operator !=( const RDOBaseEditWindow& window ) const;

	virtual void load( std::string regPath );
	virtual void save( std::string regPath ) const;

	bool wordWrap;
	bool showHorzScrollBar;
};

// ----------------------------------------------------------------------------
// ---------- RDOBaseEditStyle
// ----------------------------------------------------------------------------
class RDOBaseEditStyle: public RDOBaseCtrlStyle
{
protected:
	virtual void initTheme();
	virtual void initTab();
	virtual void initWindow();

public:
	RDOBaseEditStyle();
	virtual ~RDOBaseEditStyle();

	RDOBaseEditStyle& operator =( const RDOBaseEditStyle& style );
	bool operator ==( const RDOBaseEditStyle& style ) const;
	bool operator !=( const RDOBaseEditStyle& style ) const;

	virtual void init( const std::string& _regPath = "" );
	virtual bool load();
	virtual bool save() const;

	RDOBaseEditTheme*  theme;
	RDOBaseEditTab*    tab;
	RDOBaseEditWindow* window;
};

}; // namespace rdoEditCtrl

#endif // RDOBASEEDITSTYLE_H
