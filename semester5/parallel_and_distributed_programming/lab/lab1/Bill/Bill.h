#ifndef BILL_H
#define BILL_H

#include <vector>
#include <string>

class Bill
{
    public:
        Bill();
        void addItem(const std::string &productName, int quantity, double price);
        double getTotal() const;

    private:
        std::vector<std::pair<std::string, int>> items;
        double total;
};

#endif // BILL_H
