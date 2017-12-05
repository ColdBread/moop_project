#ifndef SESSION_H
#define SESSION_H
#include <QObject>
#include <account.h>
#include <autotrans.h>

class Session : public QObject
{
    Q_OBJECT
public:
    explicit Session (QObject *parent = 0, QString phone = "+380000000000");
    void setToken(QString token);
    QString& getToken();
    QString& getPhone();
    void addAccount(Account acc);
    QList<Account>* getAccounts();
    void clearAccounts();
    void addAutoTrans(AutoTrans trans);
    QList<AutoTrans>* getAutos();
    void clearAutoById(int id_from);


private:
    QString _token;
    QString _phone;
    QList<Account>* _accounts;
    QList<AutoTrans>* _autoTransactions;

};
#endif // SESSION_H
