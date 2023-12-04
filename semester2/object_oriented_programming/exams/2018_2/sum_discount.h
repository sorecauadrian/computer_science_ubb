#ifndef INC_2018_2_SUM_DISCOUNT_H
#define INC_2018_2_SUM_DISCOUNT_H

#include "discount.h"

#include <utility>

class SumDiscount : public Discount
{
    private:
        std::vector<Discount*> discounts;
    public:
        SumDiscount(std::vector<Discount*> discounts): discounts{std::move(discounts)} {}
        double calculateDiscount(Sale&) override;
};

#endif //INC_2018_2_SUM_DISCOUNT_H
