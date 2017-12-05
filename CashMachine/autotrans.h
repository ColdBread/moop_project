#ifndef AUTOTRANS_H
#define AUTOTRANS_H

#include <QObject>
class AutoTrans: public QObject
{
    Q_OBJECT
public:
    explicit AutoTrans(QObject *parent=0,int id = 0, int from = 0, int to = 0);
    AutoTrans(const AutoTrans& trans);
    int getFrom();
    int getTo();
    int getId();
    AutoTrans& operator=(const AutoTrans& trans);
private:
    int _id;
    int _from;
    int _to;
};
#endif // AUTOTRANS_H
