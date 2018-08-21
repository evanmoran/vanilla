
#include "mainwindow.h"
#include <QApplication>
#include <iostream>

#include "vanilla_lib/vanilla_lib.hpp"

int main(int argc, char *argv[])
{
	std::cout << "Starting vanilla qt" << std::endl;
	std::cout << "vanilla_lib::f() == " << vanilla_lib::f() << std::endl;

    QApplication a(argc, argv);
    MainWindow w;
    w.show();

    return a.exec();
}