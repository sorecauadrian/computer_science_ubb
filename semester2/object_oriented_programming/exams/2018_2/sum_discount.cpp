#include "sum_discount.h"

double SumDiscount::calculateDiscount(Sale &items)
{
    double totalDiscount = 0;
    for (Discount* discount : this -> discounts)
        totalDiscount += discount ->calculateDiscount(items);
    return totalDiscount;
}
