#include "stdafx.h"
#include "chatuserlist.h"
#include "chatapp.h"

#ifdef _DEBUG
#define new DEBUG_NEW
#undef THIS_FILE
static char THIS_FILE[] = __FILE__;
#endif

// ----------------------------------------------------------------------------
// ---------- CChatUser
// ----------------------------------------------------------------------------
CChatUser::CChatUser():
	CObject(),
	userName( "" ),
	hostName( "" ),
	ip( "" ),
	statusMode( CSMT_Online )
{
}

CChatUser::CChatUser( const std::string& _username, const std::string& _hostname, const std::string& _ip, const CChatStatusModeType _statusMode ):
	CObject(),
	userName( _username ),
	hostName( _hostname ),
	ip( _ip ),
	statusMode( _statusMode )
{
}

CChatUser::~CChatUser()
{
}

void CChatUser::setUserName( const std::string& value )
{
	if ( userName != value ) {
		userName = value;
		if ( chatApp.pFrame ) {
			chatApp.pFrame->userList.list.updateUserName( this );
		}
	}
}

void CChatUser::setHostName( const std::string& value )
{
	hostName = value;
}

void CChatUser::setIP( const std::string& value )
{
	ip = value;
}

void CChatUser::setStatusMode( const CChatStatusModeType value )
{
	if ( statusMode != value ) {
		statusMode = value;
		if ( chatApp.pFrame ) {
			chatApp.pFrame->userList.list.updateUserStatus( this );
		}
	}
}

// ----------------------------------------------------------------------------
// ---------- CChatUserList
// ----------------------------------------------------------------------------
CChatUserList::CChatUserList()
{
}

CChatUserList::~CChatUserList()
{
	std::vector< CChatUser* >::iterator it = list.begin();
	while ( it != list.end() ) {
		delete *it++;
	}
	list.clear();
}

void CChatUserList::addUser( const std::string& username, const std::string& hostname, const std::string& ip, const CChatStatusModeType statusMode )
{
	if ( findUserByIP( ip ) == -1 ) {
		CChatUser* user = new CChatUser( username, hostname, ip, statusMode );
		list.push_back( user );
		chatApp.pFrame->userList.list.addUser( user );
	}
}

void CChatUserList::deleteUser( const int index )
{
	if ( index != -1 && index < list.size() ) {
		CChatUser* user = list[index];
		if ( chatApp.pFrame ) {
			chatApp.pFrame->userList.list.deleteUser( user );
		}
		list.erase( list.begin() + index );
		delete user;
	}
}

void CChatUserList::deleteUser( const CChatUser* const user )
{
	int index = 0;
	std::vector< CChatUser* >::iterator it = list.begin();
	while ( it != list.end() ) {
		if ( *it == user ) {
			deleteUser( index );
			break;
		}
		it++;
		index++;
	}
}

int CChatUserList::findUserByHostName( const std::string& hostname ) const
{
	int cnt = list.size();
	for ( int i = 0; i < cnt; i++ ) {
		if ( list[i]->getHostName() == hostname ) return i;
	}
	return -1;
}

int CChatUserList::findUserByIP( const std::string& ip ) const
{
	int cnt = list.size();
	for ( int i = 0; i < cnt; i++ ) {
		if ( list[i]->getIP() == ip ) return i;
	}
	return -1;
}

CChatUser* CChatUserList::getUserByHostName( const std::string& hostname ) const
{
	int index = findUserByHostName( hostname );
	if ( index != -1 ) {
		return list[index];
	}
	return NULL;
}

CChatUser* CChatUserList::getUserByIP( const std::string& ip ) const
{
	int index = findUserByIP( ip );
	if ( index != -1 ) {
		return list[index];
	}
	return NULL;
}

void CChatUserList::clear( const CChatUser* const dont_delete_user )
{
	for ( int i = 0; i < list.size(); i++ ) {
		CChatUser* usr = list[i];
		if ( usr != dont_delete_user ) {
			deleteUser( i );
			i--;
		}
	}
}
