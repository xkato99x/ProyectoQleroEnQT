#ifndef SINT_H
#define SINT_H

#include <QWidget>

namespace Ui {
class sint;
}

class sint : public QWidget
{
    Q_OBJECT

public:
    explicit sint(QWidget *parent = nullptr);
    ~sint();

private:
    Ui::sint *ui;

    void recibe(QString cad);

};

#endif // SINT_H
