cmake_minimum_required(VERSION 3.24)
project(Matrix)

set(CMAKE_CXX_STANDARD 17)

add_executable(Matrix main.cpp ExtendedTest.cpp Matrix.cpp ShortTest.cpp)
