#include <account.h>

Account:: Account(QObject *parent, QString name): QObject(parent), _name(name)
{

}

QString Account:: getName()
{
    return this->_name;
}

QString Account:: getAmount()
{
    QString res = "";
    return res+this->_amount.getValue(); //QString(this->_amount.getValue());
}

QString Account:: getCredit()
{
    QString res = "";
    return res+this->_credit_limit.getValue();
}
