#ifndef PRODUCT_H
#define PRODUCT_H

#include <string>
#include <mutex>

class Product
{
   public:
      Product(const std::string &name, double price, int quantity);

      const std::string& getName() const;
      double getPrice() const;
      int getQuantity() const;

      bool decreaseQuantity(int amount);

   private:
      std::string name;
      double price;
      int quantity;
      mutable std::mutex productMutex;
};

#endif // PRODUCT_H
