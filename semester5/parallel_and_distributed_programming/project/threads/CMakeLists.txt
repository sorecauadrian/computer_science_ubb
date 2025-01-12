cmake_minimum_required(VERSION 3.30)
project(threads)

set(CMAKE_CXX_STANDARD 20)

add_executable(threads main.cpp
        Color.cpp
        Graph.cpp
        GraphColoring.cpp)
