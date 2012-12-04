﻿/*!
  \copyright (c) RDO-Team, 2012
  \file      main.cpp
  \authors   Клеванец Игорь (cerevra@gmail.com)
  \authors   Урусов Андрей (rdo@rk9.bmstu.ru)
  \date      05.11.2012
  \brief     Инициализация базы данных информацией о типах ресурсов
  \indent    4T
*/

// ---------------------------------------------------------------------------- PCH
// ----------------------------------------------------------------------- INCLUDES
#include <iostream>
#include <conio.h>
#include <windows.h>//-----------------------------удалить к чертям
#include <QtSql\QtSql>
#include <QtCore\QCoreApplication>
// ----------------------------------------------------------------------- SYNOPSIS
#include "simulator\runtime\test\sql\lib\general_db.h"
#include "simulator\runtime\test\sql\lib\interface_db.h"
// --------------------------------------------------------------------------------


void eraseMap(InterfaceDB::enumContainer& enumCont)
{
	while(!enumCont.empty())
	{
		enumCont.erase(enumCont.begin());
	}
}

int main(int argc, char *argv[])
{
	system("D:\\Dev\\simulator\\runtime\\projects\\tests\\bin\\test_sql_create\\Win32\\debug\\test_sql_create.exe");//------удалить к чертям
	Sleep(5000);


	QCoreApplication app(argc, argv);

	InterfaceDB db;

	QTextCodec* codec = QTextCodec::codecForName("CP1251");
	QTextCodec::setCodecForCStrings(codec);

	InterfaceDB::enumContainer enumCont;

//------------------------
	db.insertRtpRow("Парикмахерские","true");

	db.insertIntRow();

	db.insertParamOfTypeRow("Парикмахерские","количество_в_очереди",1);
//------------------------

//------------------------
	db.insertRtpRow("Клиенты","false");

	if(!enumCont.empty()) eraseMap(enumCont);
	enumCont.insert(enumCont.begin(), std::pair<QString,int> ("Мальчик",0));
	enumCont.insert(enumCont.begin(), std::pair<QString,int> ("Девочка",1));
	db.insertParamOfTypeRow("Клиенты","тип",db.getEnumTypeID(enumCont,"NULL"));

	if(!enumCont.empty()) eraseMap(enumCont);
	enumCont.insert(enumCont.begin(), std::pair<QString,int> ("Пришел",0));
	enumCont.insert(enumCont.begin(), std::pair<QString,int> ("Начал_стрижку",1));
	db.insertParamOfTypeRow("Клиенты","состояние",db.getEnumTypeID(enumCont,"NULL"));
//------------------------

//------------------------
	db.insertRtpRow("Парикмахеры","true");

	if(!enumCont.empty()) eraseMap(enumCont);
	enumCont.insert(enumCont.begin(), std::pair<QString,int> ("Свободен",0));
	enumCont.insert(enumCont.begin(), std::pair<QString,int> ("Занят",1));
	db.insertParamOfTypeRow("Парикмахеры","состояние_парикмахера",db.getEnumTypeID(enumCont,"Свободен"));

	db.insertParamOfTypeRow("Парикмахеры","количество_обслуженных",1);

	db.insertParamOfTypeRow("Парикмахеры","длительность_min",1);

	db.insertParamOfTypeRow("Парикмахеры","длительность_max",1);

	if(!enumCont.empty()) eraseMap(enumCont);
	db.insertParamOfTypeRow("Парикмахеры","тип_клиента",2);
//------------------------


	std::cout << "to be continued...";
	getch();
	return 0;
}