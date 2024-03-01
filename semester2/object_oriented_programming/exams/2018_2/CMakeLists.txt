cmake_minimum_required(VERSION 3.25)
project(2018_2)

set(CMAKE_CXX_STANDARD 17)

add_executable(2018_2 main.cpp sale.h sale.cpp sale_item.h sale_item.cpp discount.h discount.cpp item_discount.h item_discount.cpp sum_discount.h sum_discount.cpp)
