#include "sintax.h"
#include "ui_sintax.h"

sintax::sintax(QWidget *parent) :
    QWidget(parent),
    ui(new Ui::sintax)
{
    ui->setupUi(this);
}

sintax::~sintax()
{
    delete ui;
}
