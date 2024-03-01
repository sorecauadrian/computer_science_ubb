#ifndef INC_2018_2_SALE_ITEM_H
#define INC_2018_2_SALE_ITEM_H

#include <string>

class SaleItem
{
    private:
        int code;
        double price;
    public:
        SaleItem(const int code, double price): code(code), price(price) {}
        [[nodiscard]] int getCode() const;
        [[nodiscard]] double getPrice() const;
};

#endif //INC_2018_2_SALE_ITEM_H
