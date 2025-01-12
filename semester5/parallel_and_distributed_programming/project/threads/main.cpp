#include "Graph.h"
#include "Color.h"
#include "GraphColoring.h"
#include <iostream>
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

int main() {
    int threadsNumber = 16;

    Graph graph1 = Graph::generateRandomGraph(20, 60); // 20 nodes and 20 edges

    Color colors1(4);
    colors1.addColor(0, "red");
    colors1.addColor(1, "blue");
    colors1.addColor(2, "green");
    colors1.addColor(3, "yellow");

    std::vector<int> partialCodes(graph1.getNodesNumber(), -1);

    std::mutex lock;
    std::vector<int> codes;

    int specificColorNumber = 4;
    GraphColoring graphColoringChecker;

    try {
        if (graph1.getNodesNumber() == 0) {
            throw std::runtime_error("\nGraph is empty\n");
        }

        bool canColor = graphColoringChecker.canBeColoredWith(graph1, specificColorNumber);
        std::cout << "Graph can be colored with " << specificColorNumber << " colors: " << (canColor ? "Yes" : "No")
                  << std::endl;

        if (!canColor) {
            return 0;
        }

        auto startTime = std::chrono::high_resolution_clock::now();
        std::atomic<int> atomicThreadsNumber(threadsNumber);
        GraphColoring graphColoring;
        graphColoring.getColoredGraphRecursive(atomicThreadsNumber, -1, graph1, colors1.getColorNumber(), partialCodes,
                                               lock, codes);
        auto endTime = std::chrono::high_resolution_clock::now();

        std::chrono::duration<double> elapsed = endTime - startTime;

        std::cout << "---------------------------------------------" << std::endl;
        std::cout << "Elapsed time for Example 1: " << elapsed.count() << " seconds" << std::endl;

        std::vector<std::vector<int>> adjacencyMatrix1 = graph1.getAdjacencyMatrix();
        std::cout << std::endl << "Adjacency Matrix for Example 1:" << std::endl;
        for (const auto &row: adjacencyMatrix1) {
            for (int val: row) {
                std::cout << val << " ";
            }
            std::cout << std::endl;
        }

        std::cout << std::endl << "Colored Graph:" << std::endl;
        for (size_t i = 0; i < codes.size(); ++i) {
            std::cout << "Node " << getNodeColorCode(colors1.getColor(codes[i])) << i << ANSI_RESET << " is colored "
                      << colors1.getColor(codes[i])
                      << std::endl;
        }

    } catch (const std::exception &e) {
        std::cerr << "Error (Example 1): " << e.what() << std::endl;
    }

    Graph graph2(0);
    Color colors2(0);

    try {
        if (graph2.getNodesNumber() == 0) {
            throw std::runtime_error("\nGraph is empty\n");
        }

        bool canColor = graphColoringChecker.canBeColoredWith(graph2, specificColorNumber);
        std::cout << "Graph can be colored with 2 colors: " << (canColor ? "Yes" : "No") << std::endl;

        if (!canColor) {
            return 0;
        }

        auto startTime = std::chrono::high_resolution_clock::now();
        auto coloredGraph3 = GraphColoring::getColoredGraph(threadsNumber, graph2, colors2);
        auto endTime = std::chrono::high_resolution_clock::now();

        std::chrono::duration<double> elapsed = endTime - startTime;

        std::cout << "---------------------------------------------" << std::endl;
        std::cout << "Elapsed time for 2: " << elapsed.count() << " seconds" << std::endl;

    } catch (const std::exception &e) {
        std::cerr << "Error (Example 2): " << e.what() << std::endl;
    }

    Graph graph3 = Graph::generateRandomGraph(70, 70); // 70 nodes and 70 edges

    Color colors3(4);
    colors3.addColor(0, "red");
    colors3.addColor(1, "blue");
    colors3.addColor(2, "green");
    colors3.addColor(3, "yellow");

    try {
        if (graph3.getNodesNumber() == 0) {
            throw std::runtime_error("\nGraph is empty\n");
        }

        bool canColor = graphColoringChecker.canBeColoredWith(graph3, specificColorNumber);
        std::cout << "Graph can be colored with " << specificColorNumber << " colors: " << (canColor ? "Yes" : "No")
                  << std::endl;

        if (!canColor) {
            return 0;
        }

        auto startTime = std::chrono::high_resolution_clock::now();
        auto coloredGraph3 = GraphColoring::getColoredGraph(threadsNumber, graph3, colors3);
        auto endTime = std::chrono::high_resolution_clock::now();

        std::chrono::duration<double> elapsed = endTime - startTime;

        std::cout << "---------------------------------------------" << std::endl;
        std::cout << "Elapsed time for Example 3: " << elapsed.count() << " seconds" << std::endl;

        std::vector<std::vector<int>> adjacencyMatrix3 = graph3.getAdjacencyMatrix();
        std::cout << std::endl << "Adjacency Matrix for Example 3:" << std::endl;
        for (const auto &row: adjacencyMatrix3) {
            for (int val: row) {
                std::cout << val << " ";
            }
            std::cout << std::endl;
        }

        std::cout << std::endl << "Colored Graph:" << std::endl;
        for (size_t i = 0; i < codes.size(); ++i) {
            std::cout << "Node " << getNodeColorCode(colors3.getColor(codes[i])) << i << ANSI_RESET << " is colored "
                      << colors3.getColor(codes[i])
                      << std::endl;
        }

    }
    catch (const std::exception &e) {
        std::cerr << "Error (Example 3): " << e.what() << std::endl;
    }

    return 0;
}