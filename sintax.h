#ifndef SINTAX_H
#define SINTAX_H

#include <QWidget>

namespace Ui {
class sintax;
}

class sintax : public QWidget
{
    Q_OBJECT

public:
    explicit sintax(QWidget *parent = nullptr);
    ~sintax();

private:
    Ui::sintax *ui;
};

#endif // SINTAX_H
