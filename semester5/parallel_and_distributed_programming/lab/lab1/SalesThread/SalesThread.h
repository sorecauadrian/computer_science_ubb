#ifndef SALESTHREAD_H
#define SALESTHREAD_H

#include "../Inventory/Inventory.h"
#include "../Bill/Bill.h"
#include <random>
#include <chrono>

class SalesThread
{
    public:
        SalesThread(Inventory &inventory, int salesCount);
        void operator()();

    private:
        Inventory &inventory;
        int salesCount;
};

#endif // SALESTHREAD_H
