cmake_minimum_required(VERSION 3.29)
project(lab1)

set(CMAKE_CXX_STANDARD 20)

add_executable(lab1 main.cpp
        Product/Product.cpp
        Product/Product.h
        Bill/Bill.cpp
        Bill/Bill.h
        SalesThread/SalesThread.cpp
        SalesThread/SalesThread.h
        Inventory/Inventory.cpp
        Inventory/Inventory.h)
