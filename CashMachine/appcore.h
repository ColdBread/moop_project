#ifndef APPCORE_H
#define APPCORE_H

#include <QObject>
#include <QNetworkAccessManager>
#include <QNetworkReply>
#include <QNetworkRequest>
#include "session.h"

class AppCore : public QObject
{
    Q_OBJECT
public:
    explicit AppCore(QObject *parent = 0);

signals:
    // Сигнал для передачи данных в qml-интерфейс
    void sendGetStarted();
    void sendLogin();
    void sendTooManyReqLogin();
    void sendVerification();
    void sendVerificationBad();
    void sendAccounts();
    void sendMainUpdateAccInfo(int id, double amount, double limit);
    void sendMainRefreshAccInfo();
    void sendEditRefreshAccInfo();
    void sendEditUpdateAccInfo(int id, double amount, double limit);

public slots:
    // Слот для приёма данных из qml-интерфейса
    void receiveGetStarted();
    void receiveLogin(QString phone, QString pass);
    void receiveVerification(QString code);
    void receiveAccounts();
    void receiveEndSession();
    void receiveEditAccounts();
    void receiveAddAcc();
    void tests();

private:
   // int count;
    QNetworkAccessManager *manager;
    Session *session;

private slots:
    void replyFinishedLogin(QNetworkReply* reply);
    void replyFinishedVerification(QNetworkReply* reply);
    void replyFinishedAccounts(QNetworkReply* reply);
};





#endif // APPCORE_H
