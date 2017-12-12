#include <autotrans.h>

AutoTrans:: AutoTrans(QObject *parent, int id, int from, int to):
    QObject(parent), _id(id), _from(from), _to(to)
{

}

AutoTrans :: AutoTrans(const AutoTrans &trans):
    QObject(trans.parent()),_id(trans._id), _from(trans._from), _to(trans._to)
{

}

AutoTrans& AutoTrans:: operator=(const AutoTrans& trans){
    this->_id = trans._id;
    this->_from = trans._from;
    this->_to = trans._to;
    return *this;
}

int AutoTrans:: getId() {
    return _id;
}

int AutoTrans:: getFrom() {
    return _from;
}

int AutoTrans:: getTo() {
    return _to;
}
