#include "appcore.h"
#include <QNetworkAccessManager>
#include <QNetworkReply>
#include <QNetworkRequest>
#include <QEventLoop>
#include "session.h"
#include <QJsonDocument>
#include <QJsonObject>
#include <QJsonArray>


AppCore::AppCore(QObject *parent) : QObject(parent)
{

}

void AppCore::receiveGetStarted()
{
    emit sendGetStarted();
}

void AppCore::tests()
{
    QJsonObject json [
    {
        "id" : 3,
        "amount" : 20.00,
        "creditLimit" : 0.00
    },{
        "id": 4,
        "amount" : -20.00,
        "creditLimit" : 60.00
    }
            ]
    ;
}

void AppCore::receiveLogin(QString phone, QString pass)
{
    manager = new QNetworkAccessManager(this);

    QString url = "http://18.216.40.33:8888/auth/send-sms?phone="+phone+"&password="+pass;
    //QString url = "http://18.216.40.33:8888/auth/send-sms?phone=+380504404809&password=zzzz1234";

    qDebug() << url;
    QNetworkRequest request(url);
    QNetworkReply* reply = manager->get(request);
    session = new Session(0, phone);
    bool ok = connect(manager, SIGNAL(finished(QNetworkReply*)), this, SLOT(replyFinishedLogin(QNetworkReply*)),Qt::DirectConnection);

    qDebug() << ok;
}

void AppCore::replyFinishedLogin(QNetworkReply* reply){
    QVariant status_code = reply->attribute(QNetworkRequest::HttpStatusCodeAttribute);
    qint32 status = status_code.toInt();
    qDebug() << status;

        // Print or catch the status code
        if(status== 200) {

            qDebug() << reply->readAll();
            qDebug() << session->getPhone();
            reply->deleteLater();
            reply = nullptr;

            emit sendLogin();
        } else if (status == 429) {
            qDebug() << "Too many requests" + status;
            /*QByteArray bytes = reply->readAll();
            QString str = QString::fromUtf8(bytes.data(), bytes.size());
            qDebug() << str;
            QJsonDocument body = QJsonDocument::fromJson(str.toUtf8());
            qDebug() << body;
            QJsonObject data = body.object();
            qDebug() << data["timeoutMinutes"].isDouble();
            double token = data["timeoutMinutes"].toDouble();
            qDebug() << token;
            //read http body please*/
            reply->deleteLater();

            emit sendTooManyReqLogin();
        } else if (status == 400) {
            qDebug() << "Bad Request"+status;
            reply->deleteLater();

        } else {
            qDebug() << "HTTP request failed"+status;
            reply->deleteLater();

        }

   // qDebug() << "UHUUUU";
    //comment last line in publish
    //emit sendLogin();
}

void AppCore::receiveVerification(QString code) {
    manager = new QNetworkAccessManager(this);
    QString url = "http://18.216.40.33:8888/auth/verify-sms?phone="+session->getPhone()+"&code="+code;
    qDebug() << url;
    QNetworkRequest request(url);
    request.setHeader(QNetworkRequest::ContentTypeHeader, "application/json");
    QNetworkReply* reply = manager->get(request);
    bool ok = connect(manager, SIGNAL(finished(QNetworkReply*)), this, SLOT(replyFinishedVerification(QNetworkReply*)), Qt::DirectConnection);
    qDebug() << ok;

}

void AppCore:: replyFinishedVerification(QNetworkReply* reply){
    QVariant status_code = reply->attribute(QNetworkRequest::HttpStatusCodeAttribute);
    qint32 status = status_code.toInt();
    qDebug() << status;
    if(status == 200) {

        QByteArray bytes = reply->readAll();
        qDebug() << bytes;

        QString str = QString::fromUtf8(bytes.data(), bytes.size());

        QJsonDocument body = QJsonDocument::fromJson(str.toUtf8());

        QJsonObject data = body.object();
        QString token = data["token"].toString();

        session->setToken(token);
        reply->deleteLater();

        emit sendVerification();
    } else if(status == 401) {
        qDebug() << "U SHall NOT PASS !-|-!";
        //delete session;
        reply->deleteLater();

        emit sendVerificationBad();
    } else {
        qDebug() << "HTTP request failed" << status;
        //delete session;
        reply->deleteLater();

        emit sendVerificationBad();
    }
}

void AppCore::receiveAccounts() {
    manager = new QNetworkAccessManager(this);
    QString token = session->getToken();
    QString url = "http://18.216.40.33:8888/accounts?token="+token;
    qDebug() << url;
    QNetworkRequest request(url);
    request.setHeader(QNetworkRequest::ContentTypeHeader, "application/json");
    QNetworkReply* reply = manager->get(request);
    bool ok = connect(manager, SIGNAL(finished(QNetworkReply*)), this, SLOT(replyFinishedAccounts(QNetworkReply*)), Qt::DirectConnection);
    qDebug() << ok;
}

void AppCore::replyFinishedAccounts(QNetworkReply *reply)
{
    QVariant status_code = reply->attribute(QNetworkRequest::HttpStatusCodeAttribute);
    qint32 status = status_code.toInt();
    qDebug() << status;

    if(status == 200) {
        QByteArray bytes = reply->readAll();
        qDebug() << bytes;

        QString str = QString::fromUtf8(bytes.data(), bytes.size());

        QJsonDocument body = QJsonDocument::fromJson(str.toUtf8());

        QJsonObject data = body.object();
        qDebug() << data["id"].isArray();
        if(data["id"].isArray()){

            //QVariantList kekos = data["id"].toArray().toVariantList();
            //qDebug() << kekos;
        }
        reply->deleteLater();

    } else if(status == 401) {
        reply->deleteLater();
    } else {
        reply->deleteLater();
        qDebug() << "HTTP request failed";
    }
}




