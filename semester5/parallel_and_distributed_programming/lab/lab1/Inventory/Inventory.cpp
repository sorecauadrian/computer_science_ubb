#include "Inventory.h"


Inventory::Inventory() : totalMoney(0.0) {}

void Inventory::addProduct(const std::string &name, double price, int quantity)
{
    std::lock_guard<std::mutex> lock(inventoryMutex);
    products.emplace_back(std::make_unique<Product>(name, price, quantity));
}

bool Inventory::sellProduct(const std::string &name, int quantity, Bill &bill)
{
    if (sales.size() % 10 == 0)
        inventoryCheck();
    std::lock_guard<std::mutex> lock(inventoryMutex);
    auto it = std::find_if(products.begin(), products.end(), [&](const std::unique_ptr<Product> &p)
    {
        return p->getName() == name;
    });

    if (it != products.end())
    {
        if ((*it)->decreaseQuantity(quantity))
        {
            double price = (*it)->getPrice();
            bill.addItem(name, quantity, price);
            totalMoney += price * quantity;
            sales.push_back(bill);
            return true;
        }
        else
            std::cout << "Inventory: Failed to sell " << quantity << " of " << name << ": insufficient stock\n";
    }
    else
        std::cout << "Inventory: Failed to sell " << quantity << " of " << name << ": product not found\n";
    return false;
}

void Inventory::inventoryCheck() const
{
    std::lock_guard<std::mutex> lock(inventoryMutex);
    std::cout << "Total Money: " << totalMoney << "\n";
    std::cout << "Inventory Status:\n";
    for (const auto &product : products)
        std::cout << product->getName() << ": " << product->getQuantity() << " remaining\n";
}

std::string Inventory::getProductName(int index) const
{
    std::lock_guard<std::mutex> lock(inventoryMutex);
    return products[index]->getName();
}

int Inventory::getProductCount() const
{
    std::lock_guard<std::mutex> lock(inventoryMutex);
    return products.size();
}
