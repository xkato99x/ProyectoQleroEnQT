#include "sint.h"
#include "ui_sint.h"

sint::sint(QWidget *parent) :
    QWidget(parent),
    ui(new Ui::sint)
{
    ui->setupUi(this);

}

sint::~sint()
{
    delete ui;
}
