#ifndef INVENTORY_H
#define INVENTORY_H

#include <vector>
#include <mutex>
#include "../Product/Product.h"
#include "../Bill/Bill.h"
#include <memory>
#include <iostream>
#include <algorithm>

class Inventory {
public:
    Inventory();
    void addProduct(const std::string &name, double price, int quantity);
    bool sellProduct(const std::string &name, int quantity, Bill &bill);
    void inventoryCheck() const;

    std::string getProductName(int index) const;
    int getProductCount() const;

private:
    std::vector<std::unique_ptr<Product>> products;
    mutable std::mutex inventoryMutex;
    double totalMoney;
    std::vector<Bill> sales;
};

#endif // INVENTORY_H
