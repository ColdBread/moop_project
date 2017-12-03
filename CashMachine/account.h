#ifndef ACCOUNT_H
#define ACCOUNT_H

#include <QObject>
#include <currency.h>

class Account: public QObject
{
    Q_OBJECT
public:
    explicit Account(QObject *parent=0,int id = 0, double amount = 0, double limit = 0);
    Account(const Account& acc);
    double getAmount();
    double getCredit();
    int getId();
    Account& operator=(const Account& acc);
private:
    int _id;
    double _amount;
    double _credit_limit;
};
#endif // ACCOUNT_H
