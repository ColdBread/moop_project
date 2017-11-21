#include <session.h>

Session::Session(QObject *parent, QString phone): QObject(parent), _phone(phone)
{

}

void Session::setToken(QString &token){
    _token = token;
}

QString& Session::getToken()
{
    return _token;
}

QString& Session::getPhone(){
    return _phone;
}
