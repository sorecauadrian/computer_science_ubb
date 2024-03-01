#ifndef INC_2018_2_SALE_H
#define INC_2018_2_SALE_H

#include "sale_item.h"
#include <utility>
#include <vector>

class Sale
{
    private:
        std::vector<SaleItem> sales;
    public:
        explicit Sale(std::vector<SaleItem> sales): sales{std::move(sales)} {};
        std::vector<SaleItem> get_sales();
};

#endif //INC_2018_2_SALE_H
