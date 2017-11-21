#ifndef APPCORE_H
#define APPCORE_H

#include <QObject>
#include <QNetworkAccessManager>
#include <QNetworkReply>
#include <QNetworkRequest>

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


public slots:
    // Слот для приёма данных из qml-интерфейса
    void receiveGetStarted();
    void receiveLogin(QString phone, QString pass);
    void replyFinished(QNetworkReply *resp);

private:
   // int count;
};





#endif // APPCORE_H
