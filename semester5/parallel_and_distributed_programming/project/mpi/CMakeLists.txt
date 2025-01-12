cmake_minimum_required(VERSION 3.30)
project(mpi)

set(CMAKE_CXX_STANDARD 20)

find_package(MPI REQUIRED)

add_executable(mpi main.cpp
        Color.cpp
        Graph.cpp
        GraphColoring.cpp)

target_link_libraries(mpi PRIVATE MPI::MPI_CXX)