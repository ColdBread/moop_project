#include "appcore.h"
#include <QNetworkAccessManager>
#include <QNetworkReply>
#include <QNetworkRequest>


AppCore::AppCore(QObject *parent) : QObject(parent)
{

}

void AppCore::receiveGetStarted()
{
    emit sendGetStarted();
}

void AppCore::receiveLogin(QString phone, QString pass)
{
    QNetworkAccessManager *manager = new QNetworkAccessManager(this);

    //QString url = "/auth/send-sms?phone="+phone+"&password="+pass;
    QString url = "http::/bigmir.net";
    QNetworkRequest request;
    request.setUrl(url);
    QNetworkReply* reply = manager->get(request);
    connect(manager, SIGNAL(finished(QNetworkReply*)), this, SLOT(replyFinished(QNetworkReply*)));
}

void AppCore::replyFinished(QNetworkReply *resp){
    QVariant status_code = resp->attribute(QNetworkRequest::HttpStatusCodeAttribute);
    if(!status_code.isValid()){
        // Print or catch the status code
        qint32 status = status_code.toInt();
        qDebug() << status;
        if(status== 200) {
            qDebug() << resp->readAll();
            emit sendLogin();
        } else if (status == 429) {
            qDebug() << "Too many requests" + status;
            //read http body please
            emit sendTooManyReqLogin();
        } else if (status == 400) {
            qDebug() << "Bad Request"+status;
        } else {
            qDebug() << "HTTP request failed"+status;
        }
    }
    //comment last line in publish
    emit sendLogin();
}





