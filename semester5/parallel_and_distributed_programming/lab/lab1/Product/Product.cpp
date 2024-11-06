#include "Product.h"

Product::Product(const std::string &name, double price, int quantity) : name(name), price(price), quantity(quantity) {}

const std::string& Product::getName() const {return name;}

double Product::getPrice() const {return price;}

int Product::getQuantity() const
{
    std::lock_guard<std::mutex> lock(productMutex);
    return quantity;
}

bool Product::decreaseQuantity(int amount)
{
    std::lock_guard<std::mutex> lock(productMutex);
    if (quantity >= amount)
    {
        quantity -= amount;
        return true;
    }
    return false;
}
