
#include "mainwindow.h"
#include <QApplication>
#include <iostream>
#include <stdio.h>
#include "qt_python.h"

int main(int argc, char *argv[])
{
	std::cout << "Starting vanilla qt py" << std::endl;

	PyObject* pInt;

	Py_Initialize();

	PyRun_SimpleString("print('Hello from python!!!')");

	Py_Finalize();

    QApplication a(argc, argv);
    MainWindow w;
    w.show();

    return a.exec();
}