#include "mainwindow.h"
#include "ui_mainwindow.h"

#include "vanilla.hpp"

MainWindow::MainWindow(QWidget *parent) :
    QMainWindow(parent),
    ui(new Ui::MainWindow)
{
    ui->setupUi(this);
    
    QLabel* label = findChild<QLabel*>("random_number");
    label->setText(QString::number(vanilla::random_non_zero_uint64()));
}

MainWindow::~MainWindow()
{
    delete ui;
}
