#include <iostream>
#include "mpi.h"
#include "Graph.h"
#include "Color.h"
#include "GraphColoring.h"
#include <chrono>

const std::string ANSI_RESET = "\x1B[0m";
const std::string ANSI_RED = "\x1B[31m";
const std::string ANSI_BLUE = "\x1B[34m";
const std::string ANSI_GREEN = "\x1B[32m";
const std::string ANSI_YELLOW = "\x1B[33m";

std::string getNodeColorCode(const std::string &color) {
    if (color == "red") return ANSI_RED;
    if (color == "blue") return ANSI_BLUE;
    if (color == "green") return ANSI_GREEN;
    if (color == "yellow") return ANSI_YELLOW;
    return ANSI_RESET;
}

void printGraphResults(const Graph &graph, const Color &colors, const std::map<int, std::string> &result) {
    std::vector <std::vector<int>> adjacencyMatrix = graph.getAdjacencyMatrix();
    std::cout << std::endl << "Adjacency Matrix:" << std::endl;
    for (const auto &row: adjacencyMatrix) {
        for (int val: row) {
            std::cout << val << " ";
        }
        std::cout << std::endl;
    }

    std::cout << std::endl << "Colored Graph:" << std::endl;
    for (const auto &pair: result) {
        std::cout << "Node " << getNodeColorCode(pair.second) << pair.first << ANSI_RESET << " is colored "
                  << pair.second << std::endl;
    }
}

int main(int argc, char *argv[]) {
    srand(time(nullptr));

    MPI_Init(&argc, &argv);
    MPI_Comm_set_errhandler(MPI_COMM_WORLD, MPI_ERRORS_RETURN);

    int rank, size;
    MPI_Comm_rank(MPI_COMM_WORLD, &rank);
    MPI_Comm_size(MPI_COMM_WORLD, &size);

    for (int graphNumber = 1; graphNumber <= 3; ++graphNumber) {
        int n = rand() % 10 + 5;
        int m = rand() % (n * (n - 1) / 2 - n + 1) + n - 1;

        Graph graph = Graph::generateRandomGraph(n, m);
        Color colors(4);
        colors.addColor(0, "red");
        colors.addColor(1, "blue");
        colors.addColor(2, "green");
        colors.addColor(3, "yellow");

        if (rank == 0) {
            std::cout << "---------------------------------------------" << std::endl;
            std::cout << "Graph " << graphNumber << " (n=" << n << ", m=" << m << ")" << std::endl;

            try {
                auto start = std::chrono::high_resolution_clock::now();
                auto result = GraphColoring::graphColoringMain(size, graph, colors);
                auto stop = std::chrono::high_resolution_clock::now();

                std::chrono::duration<double, std::milli> time = stop - start;
                std::cout << "Elapsed time: " << time.count() / 1000 << " seconds" << std::endl;
                printGraphResults(graph, colors, result);
            } catch (const std::exception &e) {
                std::cerr << "Error (Graph " << graphNumber << "): " << e.what() << std::endl;
            }
        } else {
            int colorsNumber = colors.getColorNumber();
            GraphColoring::graphColoringChild(rank, size, graph, colorsNumber);
        }
    }

    MPI_Finalize();
    return 0;
}