#include "appcore.h"
#include <QNetworkAccessManager>
#include <QNetworkReply>
#include <QNetworkRequest>
#include <QEventLoop>
#include "session.h"
#include "account.h"
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
    QJsonArray json;
    QJsonObject lol1  {{"id" , 3},{"amount" , 20.00},{"creditLimit" , 0.00}};
    QJsonObject lol2  {{"id", 4},{"amount" , -20.00},{"creditLimit" , 60.00}};
    json.push_back(QJsonValue(lol1));
    json.push_back(QJsonValue(lol2));

    qDebug() << json;

    qDebug() <<json[0].toObject();

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
            emit sendFailedToLogin();
            reply->deleteLater();

        } else {
            qDebug() << "HTTP request failed"+status;
            reply->deleteLater();
            emit sendFailedToLogin();
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
        delete session;
        reply->deleteLater();

        emit sendVerificationBad();
    } else {
        qDebug() << "HTTP request failed" << status;
        delete session;
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
        QJsonArray data = body.array();
        //QJsonObject data = body.object();
        //qDebug() << data.size();
        /*qDebug() << "info about last acc";
        qDebug() << "id: ";
        qDebug() << data[data.size()-1].toObject()["id"].toInt();
        qDebug() << "amount: ";
        qDebug() << data[data.size()-1].toObject()["amount"].toDouble();
        qDebug() << "credit limit: ";
        qDebug() << data[data.size()-1].toObject()["credit limit"].toDouble();
        qDebug() << "name ";
        qDebug() <<  data[data.size()-1].toObject()["id"].toString();*/
        //if(data["id"].isArray()){

            //QVariantList kekos = data["id"].toArray().toVariantList();
            //qDebug() << kekos;
        //}
        emit sendMainRefreshAccInfo();
        session->clearAccounts();
        for(QJsonValue val : data) {
            int id = val.toObject()["id"].toInt();
            double amount = val.toObject()["amount"].toDouble();
            double limit = val.toObject()["creditLimit"].toDouble();
            qDebug() << limit;
            Account acc(0,id,amount,limit);
            session->addAccount(acc);
            emit sendMainUpdateAccInfo(id, amount, limit);
            emit sendMainUpdateAccAuto(id);
        }
        emit sendAccounts();
        reply->deleteLater();

    } else if(status == 401) {
        reply->deleteLater();
    } else {
        reply->deleteLater();
        qDebug() << "HTTP request failed";
    }
}

void AppCore::receiveEditAccounts() {
    emit sendEditRefreshAccInfo();
    QList<Account> accs = *session->getAccounts();
    for(Account acc : accs){
        qDebug() << acc.getCredit();
        emit sendEditUpdateAccInfo(acc.getId(), acc.getAmount(), acc.getCredit());
    }
}

void AppCore::receiveAddAcc(){
    manager = new QNetworkAccessManager(this);
    QString token = session->getToken();
    QString url = "http://18.216.40.33:8888/accounts?token="+token;
    QNetworkRequest request(url);
    request.setHeader(QNetworkRequest::ContentTypeHeader, "application/json");
    QNetworkReply* reply = manager->sendCustomRequest(request,"PUT");
    bool ok = connect(manager, SIGNAL(finished(QNetworkReply*)), this, SLOT(replyFinishedAddAcc(QNetworkReply*)), Qt::DirectConnection);
    qDebug() << ok;
}

void AppCore::replyFinishedAddAcc(QNetworkReply *reply){
    QVariant status_code = reply->attribute(QNetworkRequest::HttpStatusCodeAttribute);
    qint32 status = status_code.toInt();

    if(status == 200) {
        QByteArray bytes = reply->readAll();
        QString str = QString::fromUtf8(bytes.data(), bytes.size());

        QJsonDocument body = QJsonDocument::fromJson(str.toUtf8());
        QJsonArray data = body.array();
        QJsonValue addedValue = data[data.size()-1];
        QJsonObject addedObj = addedValue.toObject();
        int id = addedObj["id"].toInt();
        double amount = addedObj["amount"].toDouble();
        double limit = addedObj["creditLimit"].toDouble();
        Account acc(0,id,amount,limit);
        session->addAccount(acc);
        emit sendMainUpdateAccInfo(id, amount, limit);
        emit sendAccounts();
        reply->deleteLater();

    } else if(status == 401) {
        reply->deleteLater();
    } else {
        reply->deleteLater();
        qDebug() << "HTTP request failed";
    }
}

void AppCore::receiveDeleteAcc(QString id){
    manager = new QNetworkAccessManager(this);
    QString token = session->getToken();
    QString url = "http://18.216.40.33:8888/accounts/"+id +"?token="+token;
    QNetworkRequest request(url);
    request.setHeader(QNetworkRequest::ContentTypeHeader, "application/json");
    QNetworkReply* reply = manager->sendCustomRequest(request,"DELETE");
    bool ok = connect(manager, SIGNAL(finished(QNetworkReply*)), this, SLOT(replyFinishedDeleteAcc(QNetworkReply*)), Qt::DirectConnection);
    qDebug() << ok;
}

void AppCore::replyFinishedDeleteAcc(QNetworkReply *reply) {
    QVariant status_code = reply->attribute(QNetworkRequest::HttpStatusCodeAttribute);
    qint32 status = status_code.toInt();

    if(status == 200) {
        QByteArray bytes = reply->readAll();
        QString str = QString::fromUtf8(bytes.data(), bytes.size());

        QJsonDocument body = QJsonDocument::fromJson(str.toUtf8());
        QJsonArray data = body.array();
        session->clearAccounts();
        QList<Account> accs = *session->getAccounts();

        emit sendMainRefreshAccInfo();
        for(QJsonValue val : data) {
            int id = val.toObject()["id"].toInt();
            double amount = val.toObject()["amount"].toDouble();
            double limit = val.toObject()["creditLimit"].toDouble();
            Account acc(0,id,amount,limit);
            session->addAccount(acc);
            emit sendMainUpdateAccInfo(id, amount, limit);
        }
        /*QJsonValue addedValue = data[data.size()-1];
        QJsonObject addedObj = addedValue.toObject();
        int id = addedObj["id"].toInt();
        double amount = addedObj["amount"].toDouble();
        double limit = addedObj["credit_limit"].toDouble();
        Account acc(0,id,amount,limit);
        session->addAccount(acc);
        emit sendMainUpdateAccInfo(id, amount, limit);*/


        emit sendAccounts();
        reply->deleteLater();

    } else if(status == 400) {
        emit sendThereIsSomeMoney();
        reply->deleteLater();
    } else {
        reply->deleteLater();
        qDebug() << "HTTP request failed";
    }
}


void AppCore::receiveUpdateCombo() {
    emit sendTransRefreshAccInfo();
    QList<Account> accs = *session->getAccounts();
    for(Account acc : accs){
        emit sendTransUpdateAccInfo(acc.getId(), acc.getAmount(), acc.getCredit());
    }
}

void AppCore::receiveTrans(QString id_first, QString id_second, QString amount){
    if(id_first == id_second) {
        emit sendEqualIDs();
        return;
    }
    QList<Account> accs = *session->getAccounts();
    for(Account acc : accs){
        if(acc.getId() == id_first.toInt()){
            if(amount.toDouble() > (acc.getAmount() + acc.getCredit())){
                emit sendNoEnoughMoney();
                return;
            }
        }
    }
    manager = new QNetworkAccessManager(this);
    QString token = session->getToken();
    QString url = "http://18.216.40.33:8888/transactions/"+id_first +"/" + id_second +"?amount="+amount +"&token="+token;
    QNetworkRequest request(url);
    request.setHeader(QNetworkRequest::ContentTypeHeader, "application/json");
    QNetworkReply* reply = manager->sendCustomRequest(request,"POST");
    bool ok = connect(manager, SIGNAL(finished(QNetworkReply*)), this, SLOT(replyFinishedTrans(QNetworkReply*)), Qt::DirectConnection);
    qDebug() << ok;
}

void AppCore::replyFinishedTrans(QNetworkReply *reply){
    QVariant status_code = reply->attribute(QNetworkRequest::HttpStatusCodeAttribute);
    qint32 status = status_code.toInt();

    if(status == 200) {

        emit sendFinishedTransfer();
        reply->deleteLater();

    }  else {
        emit sendUnexpectedException();
        reply->deleteLater();
        qDebug() << "HTTP request failed";
    }
}

void AppCore:: receiveRegularTrans(QString id_first, QString id_second, QString amount, QString interval){
    if(id_first == id_second) {
        emit sendEqualIDs();
        return;
    }
    QList<Account> accs = *session->getAccounts();
    for(Account acc : accs){
        if(acc.getId() == id_first.toInt()){
            if(amount.toDouble() > (acc.getAmount() + acc.getCredit())){
                emit sendNoEnoughMoney();
                return;
            }
        }
    }
    QList<AutoTrans> autos = *session->getAutos();
    for(AutoTrans trans : autos){
        qDebug() << trans.getFrom();
        qDebug() << id_first.toInt();
        qDebug() << "---------";
        qDebug() << trans.getTo();
        qDebug() << id_second.toInt();
        qDebug() << "----end operation----";
        if(trans.getFrom() == id_first.toInt() && trans.getTo() == id_second.toInt()){
            emit sendThereIsAlreadyAutoTrans();
            return;
        }
    }
    manager = new QNetworkAccessManager(this);
    QString token = session->getToken();
    QString url = "http://18.216.40.33:8888/transactions/automatic/"+id_first +"/" + id_second +"?amount="+amount +"&intervalDays="+interval +"&token="+token;
    qDebug() << url;
    QNetworkRequest request(url);
    request.setHeader(QNetworkRequest::ContentTypeHeader, "application/json");
    QNetworkReply* reply = manager->sendCustomRequest(request,"POST");
    bool ok = connect(manager, SIGNAL(finished(QNetworkReply*)), this, SLOT(replyFinishedRegularTrans(QNetworkReply*)), Qt::DirectConnection);
    qDebug() << ok;
}

void AppCore::replyFinishedRegularTrans(QNetworkReply *reply){
    QVariant status_code = reply->attribute(QNetworkRequest::HttpStatusCodeAttribute);
    qint32 status = status_code.toInt();
    qDebug() << "sttus= " + status;
    if(status == 200) {
        QByteArray bytes = reply->readAll();
        qDebug() << bytes;
        emit sendFinishedTransfer();
        reply->deleteLater();

    } else if(status == 401) {
        reply->deleteLater();
    } else {
        emit sendUnexpectedException();
        reply->deleteLater();
        qDebug() << "HTTP request failed";
    }
}

void AppCore:: receiveLoadAccAutoSettings(QString id_acc){
    manager = new QNetworkAccessManager(this);
    QString token = session->getToken();
    QString url = "http://18.216.40.33:8888/transactions/automatic?account="+id_acc +"&token="+token;
    qDebug() << url;
    QNetworkRequest request(url);
    request.setHeader(QNetworkRequest::ContentTypeHeader, "application/json");
    QNetworkReply* reply = manager->sendCustomRequest(request,"GET");
    bool ok = connect(manager, SIGNAL(finished(QNetworkReply*)), this, SLOT(replyFinishedLoadAccAutoSettings(QNetworkReply*)), Qt::DirectConnection);
    qDebug() << ok;
    session->clearAutoById(id_acc.toInt());
}

void AppCore::replyFinishedLoadAccAutoSettings(QNetworkReply *reply){
    QVariant status_code = reply->attribute(QNetworkRequest::HttpStatusCodeAttribute);
    QString idRofl = reply->url().toString();
    QString res = "";
    for(int i = 56; i < idRofl.size(); i++){
        if(!idRofl.at(i).isDigit())
            break;
        res.append(idRofl[i]);
    }
    qDebug() << res;
    qint32 status = status_code.toInt();

    if(status == 200) {
        QByteArray bytes = reply->readAll();
        QString str = QString::fromUtf8(bytes.data(), bytes.size());

        QJsonDocument body = QJsonDocument::fromJson(str.toUtf8());
        QJsonArray data = body.array();
        emit sendSettingsRefreshAccInfo();
        emit sendSetAccId(res);
        for(QJsonValue val : data) {
            int id = val.toObject()["id"].toInt();
            int destination = val.toObject()["destinationAccount"].toInt();
            qDebug() << "Destination:";
            qDebug() << destination;
            double amount = val.toObject()["amount"].toDouble();
            qDebug() << val.toObject()["intervalDays"].toDouble();
            double intervaL = val.toObject()["intervalDays"].toDouble();
            qDebug() << intervaL;
            QString interval = QString::number(intervaL);
            QString lastPay = val.toObject()["timeLastTransaction"].toString();
            qDebug() << "Last payment";
            qDebug() << lastPay;
            QString lastPayment = lastPay.left(16);
            AutoTrans trans(0,id,res.toInt(),destination);
            session->addAutoTrans(trans);
            emit sendSettingsUpdateAccInfo(id, destination, amount, interval, lastPayment);
        }

        reply->deleteLater();
        } else if(status == 401) {
            reply->deleteLater();
        } else {
            reply->deleteLater();
            qDebug() << "HTTP request failed";
        }
}

void AppCore:: receiveLoadAccHistory(QString id_acc){
    manager = new QNetworkAccessManager(this);
    QString token = session->getToken();
    QString url = "http://18.216.40.33:8888/transactions?account="+id_acc +"&token="+token;
    qDebug() << url;
    QNetworkRequest request(url);
    request.setHeader(QNetworkRequest::ContentTypeHeader, "application/json");
    QNetworkReply* reply = manager->sendCustomRequest(request,"GET");
    bool ok = connect(manager, SIGNAL(finished(QNetworkReply*)), this, SLOT(replyFinishedLoadAccHistory(QNetworkReply*)), Qt::DirectConnection);
    qDebug() << ok;
}

void AppCore::replyFinishedLoadAccHistory(QNetworkReply *reply){
    QVariant status_code = reply->attribute(QNetworkRequest::HttpStatusCodeAttribute);
    qint32 status = status_code.toInt();

    if(status == 200) {
        QByteArray bytes = reply->readAll();
        QString str = QString::fromUtf8(bytes.data(), bytes.size());

        QJsonDocument body = QJsonDocument::fromJson(str.toUtf8());
        QJsonArray data = body.array();
        emit sendSettingsRefreshAccHistory();
        for(QJsonValue val : data) {
            int id = val.toObject()["id"].toInt();
            int connectedAcc = val.toObject()["sourceAccount"].toInt();
            double amount = val.toObject()["amount"].toDouble();
            QString timeProc = val.toObject()["timeProcessed"].toString();
            QString timeProcc = timeProc.left(16);
            emit sendSettingsUpdateAccHistory(id, connectedAcc, amount, timeProcc);
        }

        reply->deleteLater();
        } else if(status == 401) {
            reply->deleteLater();
        } else {
            reply->deleteLater();
            qDebug() << "HTTP request failed";
        }
}

void AppCore::receiveDeleteAuto(QString id_trans){
    manager = new QNetworkAccessManager(this);
    QString token = session->getToken();
    QString url = "http://18.216.40.33:8888/transactions/automatic/"+id_trans +"?token="+token;
    qDebug() << url;
    QNetworkRequest request(url);
    request.setHeader(QNetworkRequest::ContentTypeHeader, "application/json");
    QNetworkReply* reply = manager->sendCustomRequest(request,"DELETE");
    bool ok = connect(manager, SIGNAL(finished(QNetworkReply*)), this, SLOT(replyFinishedDeleteAuto(QNetworkReply*)), Qt::DirectConnection);
    qDebug() << ok;
    session->clearAutoById(id_trans.toInt());
}

void AppCore::replyFinishedDeleteAuto(QNetworkReply *reply){
    QVariant status_code = reply->attribute(QNetworkRequest::HttpStatusCodeAttribute);
    qint32 status = status_code.toInt();
    QString idRofl = reply->url().toString();
    qDebug() << idRofl;
    QString res = "";
    for(int i = 48; i < idRofl.size(); i++){
        if(!idRofl.at(i).isDigit())
            break;
        res.append(idRofl[i]);
    }
    qDebug() << res;

    if(status == 200) {
        QByteArray bytes = reply->readAll();
        QString str = QString::fromUtf8(bytes.data(), bytes.size());

        QJsonDocument body = QJsonDocument::fromJson(str.toUtf8());
        QJsonArray data = body.array();
        emit sendSettingsRefreshAccInfo();
        for(QJsonValue val : data) {
            int id = val.toObject()["id"].toInt();
            int destination = val.toObject()["destinationAccount"].toInt();
            double amount = val.toObject()["amount"].toDouble();
            QString interval = val.toObject()["intervalDays"].toString();
            QString lastPay = val.toObject()["timeLastTransaction"].toString();
            QString lastPayment = lastPay.left(16);
            emit sendSettingsUpdateAccInfo(id, destination, amount, interval, lastPayment);
        }

        emit sendAccounts();
        reply->deleteLater();
        } else if(status == 401) {
            reply->deleteLater();
        } else {
            reply->deleteLater();
            qDebug() << "HTTP request failed";
        }
}

void AppCore::receiveChangeLimit(QString id_acc,QString limit){
    manager = new QNetworkAccessManager(this);
    QString token = session->getToken();
    QString url = "http://18.216.40.33:8888/accounts/"+id_acc+"/credit-limit/"+limit +"?token="+token;
    qDebug() << url;
    QNetworkRequest request(url);
    request.setHeader(QNetworkRequest::ContentTypeHeader, "application/json");
    QNetworkReply* reply = manager->sendCustomRequest(request,"POST");
    bool ok = connect(manager, SIGNAL(finished(QNetworkReply*)), this, SLOT(replyFinishedChangeLimit(QNetworkReply*)), Qt::DirectConnection);
    qDebug() << ok;
}

void AppCore::replyFinishedChangeLimit(QNetworkReply *reply) {
    QVariant status_code = reply->attribute(QNetworkRequest::HttpStatusCodeAttribute);
    qint32 status = status_code.toInt();

    if(status == 200) {
        emit sendChangeSuccess();
        reply->deleteLater();
    } else {
        emit sendChangeFailure();
        reply->deleteLater();
        qDebug() << "HTTP request failed";
    }
}



void AppCore::receiveEndSession() {
    emit sendMainRefreshAccInfo();
    delete session;
}




