#ifndef CURRENCY_H
#define CURRENCY_H
#include <QObject>
class Currency : public QObject
{
    Q_OBJECT
public:
    explicit Currency(QObject *parent=0, float val=0);
    void setValue(const float&);
    float& getValue();
    //~Currency();
private:
    void normalize();
    float value;
};
#endif // CURRENCY_H
