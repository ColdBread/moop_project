#include <session.h>

Session::Session(QObject *parent, QString phone): QObject(parent), _phone(phone)
{
    _token =  "rofl";
    _accounts = new QList<Account>();
    _autoTransactions = new QList<AutoTrans>();
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

void Session::addAutoTrans(AutoTrans trans){
    _autoTransactions->append(trans);
}

QList<AutoTrans>* Session::getAutos(){
    return _autoTransactions;
}

void Session::clearAutoById(int id_from) {
    QList<int> idshniki;
    for(int i = 0; i < _autoTransactions->count(); i++){
        AutoTrans trans =  _autoTransactions->at(i);
        if(trans.getFrom() == id_from)
            idshniki.append(i);
    }

    for(int l : idshniki){
        _autoTransactions->removeAt(l);
    }
}
