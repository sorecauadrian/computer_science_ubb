#include "item_discount.h"

double ItemDiscount::calculateDiscount(Sale &items)
{
    double discount = 0;
    for (const SaleItem& item : items.get_sales())
        if (item.getCode() == this -> code)
            discount += item.getPrice() * this -> percentage / 100.0;
    return discount;
}
