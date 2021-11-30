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
    void limpiar();
    QList<int> producciones(int e);
    QString esperaba(int e);
    QString curFile;


    void semantico();
    QString erroresSemantico(int x);
    void tablaTipos(QString var, QString tipo);
    void tiposNota(QString nota);
    QString operacionTipos(QList<QString> concatenacion);
    QString matrizTipos(QString op1, QString op2, QString oper);
    void ingresaTipos(QList<QString> a, QList<QString> b);
    void limpiarPilas();
    void cuadruplos();
    void tablaCuadruplos(QString oper, QString op1, QString op2, QString res);
    void tablaCuad_MeterSalto(int pos, int res);
    QString jerarquiaCuadruplos(QList<QString> a);
    void tablaSaltos(int x);
    void tablaOperandos(QString x);
    void tablaOperadores(QString x);
};
#endif // WIDGET_H
