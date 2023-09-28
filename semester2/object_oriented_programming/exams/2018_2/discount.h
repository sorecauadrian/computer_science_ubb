#ifndef INC_2018_2_DISCOUNT_H
#define INC_2018_2_DISCOUNT_H

#include "sale.h"

class Discount
{
    public:
        virtual double calculateDiscount(Sale&) = 0;
};

#endif //INC_2018_2_DISCOUNT_H
