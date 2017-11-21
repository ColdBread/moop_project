#include <currency.h>

Currency::Currency(QObject *parent, float val): QObject(parent), value(val)
{
    this->normalize();
}

void Currency::setValue(const float& val) {
    this->value = val;
    this->normalize();
}

float& Currency::getValue() {
    return this->value;
}

void Currency:: normalize() {
    int new_num = this->value*100;
    this->value = (float)new_num/100.0;
}

/*Currency:: ~Currency() {
    delete value;
}*/
