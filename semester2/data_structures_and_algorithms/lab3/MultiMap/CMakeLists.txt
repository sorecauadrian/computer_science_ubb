cmake_minimum_required(VERSION 3.25)
project(MultiMap)

set(CMAKE_CXX_STANDARD 14)

include_directories(.)

add_executable(MultiMap
        App.cpp
        ExtendedTest.cpp
        ExtendedTest.h
        MultiMap.cpp
        MultiMap.h
        MultiMapIterator.cpp
        MultiMapIterator.h
        ShortTest.cpp
        ShortTest.h)
