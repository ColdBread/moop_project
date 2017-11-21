#ifndef SESSION_H
#define SESSION_H
#include <QObject>
#include <account.h>

class Session : public QObject
{
    Q_OBJECT
public:
    explicit Session (QObject *parent = 0, QString phone = "+380");


private:
    QString _token;
    QString _phone;
    QList<Account> _accounts;

};
#endif // SESSION_H
