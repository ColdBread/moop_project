#include <session.h>

Session::Session(QObject *parent, QString phone): QObject(parent), _phone(phone)
{
    _token =  "rofl blyat";
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
