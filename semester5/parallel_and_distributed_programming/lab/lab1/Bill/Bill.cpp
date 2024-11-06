#include "Bill.h"

Bill::Bill() : total(0.0) {}

void Bill::addItem(const std::string &productName, int quantity, double price)
{
    items.emplace_back(productName, quantity);
    total += price * quantity;
}

double Bill::getTotal() const {return total;}
