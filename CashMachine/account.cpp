#include <account.h>

Account:: Account(QObject *parent, int id, double amount, double limit):
    QObject(parent), _id(id), _amount(amount), _credit_limit(limit)
{

}

Account :: Account(const Account& acc):
    QObject(acc.parent()),_id(acc._id), _amount(acc._amount), _credit_limit(acc._credit_limit)
{

}

Account& Account::operator=(const Account& acc){
    this->_id = acc._id;
    this->_amount = acc._amount;
    this->_credit_limit = acc._credit_limit;

}


double Account:: getAmount()
{

    return _amount;
}

double Account:: getCredit()
{

    return _credit_limit;
}

int Account:: getId() {
    return _id;
}
