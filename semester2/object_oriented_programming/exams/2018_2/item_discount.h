#ifndef INC_2018_2_ITEM_DISCOUNT_H
#define INC_2018_2_ITEM_DISCOUNT_H

#include "discount.h"

class ItemDiscount : public Discount
{
    private:
        int code;
        int percentage;
    public:
        ItemDiscount(int code, int percentage): code{code}, percentage{percentage} {}
        double calculateDiscount(Sale&) override;
};

#endif //INC_2018_2_ITEM_DISCOUNT_H
