#include <session.h>

Session::Session(QObject *parent, QString phone): QObject(parent), _phone(phone)
{
    _token =  "rofl";
    _accounts = new QList<Account>();
}

void Session::setToken(QString token){
    _token = token;
}

QString& Session::getToken()
{
    return _token;
}

QString& Session::getPhone(){
    return _phone;
}

void Session::addAccount(Account acc){
    _accounts->append(acc);
}

QList<Account>* Session::getAccounts(){
    return _accounts;
}

void Session::clearAccounts() {
    _accounts->clear();
}
