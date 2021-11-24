#ifndef WIDGET_H
#define WIDGET_H
#include <QMainWindow>
#include <sint.h>

#include <QWidget>

QT_BEGIN_NAMESPACE
namespace Ui { class Widget; }
QT_END_NAMESPACE

class Widget : public QWidget
{
    Q_OBJECT

public:
    Widget(QWidget *parent = nullptr);
    ~Widget();

    QString getCurFile() const;
    void setCurFile(const QString &value);

private slots:
    void on_btnAnalizar_clicked();

    void on_btnAbrir_clicked();

    void on_btnGuardar_clicked();

    void on_Limpiar_clicked();

    void on_pushButton_clicked();


private:
    Ui::Widget *ui;
    sint *ventana1;
    void saveFile();
    void agregarTabla(int token, QString lexema, QString gramema);
    void semantico();
    void limpiar();
    QList<int> producciones(int e);
    QString esperaba(int e);
    QString curFile;
};
#endif // WIDGET_H
