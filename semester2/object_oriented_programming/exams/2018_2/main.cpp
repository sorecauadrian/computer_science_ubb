#include "sum_discount.h"
#include "item_discount.h"
#include <iostream>

int main()
{
    SaleItem item1(100, 10.0);
    SaleItem item2(101, 20.0);
    SaleItem item3(102, 50.0);


    std::vector<SaleItem> items = {item1, item2, item3};
    Sale sale(items);

    ItemDiscount discount1(100, 10.0);
    ItemDiscount discount2(102, 15.0);

    std::vector<Discount*> discounts = {&discount1, &discount2};
    SumDiscount sumDiscount(discounts);

    double totalDiscount = sumDiscount.calculateDiscount(sale);

    std::cout << "total discount: " << totalDiscount << '\n';

    return 0;
}