#include "SalesThread.h"

SalesThread::SalesThread(Inventory &inventory, int salesCount) : inventory(inventory), salesCount(salesCount) {}

void SalesThread::operator()()
{
    // seeding the random number generator with the current time for true randomness
    unsigned seed = std::chrono::system_clock::now().time_since_epoch().count();
    std::default_random_engine generator(seed);
    // selling between 1 and 5 products
    std::uniform_int_distribution<int> quantityDist(1, 5);

    for (int i = 0; i < salesCount; ++i)
    {
        // selecting a random product to sell
        std::uniform_int_distribution<int> productDist(0, inventory.getProductCount() - 1);
        int productIndex = productDist(generator);
        int quantity = quantityDist(generator);
        Bill bill;

        std::string productName = inventory.getProductName(productIndex);

        if (!inventory.sellProduct(productName, quantity, bill))
            std::cout << "SalesThread: Failed to sell " << quantity << " of " << productName << "\n";
    }
}
