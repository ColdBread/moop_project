#ifndef ACCOUNT_H
#define ACCOUNT_H

#include <QObject>
#include <currency.h>

class Account: public QObject
{
    Q_OBJECT
public:
    explicit Account(QObject *parent=0, QString name="account");
    QString getName();
    QString getAmount();
    QString getCredit();
private:
    int _id;
    QString _name;
    Currency _amount;
    Currency _credit_limit;
};
#endif // ACCOUNT_H
