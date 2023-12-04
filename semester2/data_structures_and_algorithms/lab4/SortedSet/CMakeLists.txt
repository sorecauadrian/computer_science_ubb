cmake_minimum_required(VERSION 3.25)
project(SortedSet)

set(CMAKE_CXX_STANDARD 14)

include_directories(.)

add_executable(SortedSet
        App.cpp
        ExtendedTest.cpp
        ExtendedTest.h
        ShortTest.cpp
        ShortTest.h
        SortedSet.cpp
        SortedSet.h
        SortedSetIterator.cpp
        SortedSetIterator.h)
