#include <vector>
#include <thread>
#include "Inventory/Inventory.h"
#include "SalesThread/SalesThread.h"

int main()
{
    Inventory inventory;

    inventory.addProduct("Product1", 10.0, 50);
    inventory.addProduct("Product2", 15.0, 40);
    inventory.addProduct("Product3", 20.0, 30);
    inventory.addProduct("Product4", 30.0, 20);
    inventory.addProduct("Product5", 5.0, 10);

    const int numThreads = 5;
    const int salesPerThread = 10;
    std::vector<std::thread> threads;

    for (int i = 0; i < numThreads; ++i)
        threads.emplace_back(SalesThread(inventory, salesPerThread));

    for (auto &t : threads)
        t.join();

    inventory.inventoryCheck();
    return 0;
}
