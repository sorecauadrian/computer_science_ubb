#include "GraphColoring.h"
#include <stdexcept>
#include <cmath>
#include "mpi.h"

std::map<int, std::string> GraphColoring::graphColoringMain(int mpiSize, Graph &graph, Color &colors) {
    int colorsNumber = colors.getColorNumber();
    std::vector<int> codes = graphColoringRecursive(0, graph, colorsNumber, std::vector<int>(graph.getNodesNumber(), 0), 0, mpiSize, 0);

    if (codes[0] == -1) {
        throw std::runtime_error("No solution found!");
    }

    return colors.getColorsForCodes(codes);
}

std::vector<int>
GraphColoring::graphColoringRecursive(int nodeId, Graph &graph, int colorsNumber, std::vector<int> codes, int mpiRank, int mpiSize, int power) {
    int nodesNumber = graph.getNodesNumber();

    if (!isColorValid(nodeId, codes, graph)) {
        return fillArray(nodesNumber, -1);
    }

    if (nodeId + 1 == nodesNumber) {
        return codes;
    }

    int coefficient = static_cast<int>(pow(colorsNumber, power));
    int colorCode = 0;
    int destination = mpiRank + coefficient * (colorCode + 1);

    while (colorCode + 1 < colorsNumber && destination < mpiSize) {
        colorCode++;
        destination = mpiRank + coefficient * (colorCode + 1);
    }

    int nextNode = nodeId + 1;
    int nextPower = power + 1;

    for (int currentColorCode = 1; currentColorCode < colorCode; currentColorCode++) {
        destination = mpiRank + coefficient * currentColorCode;
        int data[3] = {mpiRank, nextNode, nextPower};

        int mpi_error;

        mpi_error = MPI_Send(data, 3, MPI_INT, destination, 0, MPI_COMM_WORLD);
        if (mpi_error != MPI_SUCCESS) {
            char error_string[MPI_MAX_ERROR_STRING];
            int length;
            MPI_Error_string(mpi_error, error_string, &length);
            printf("MPI_Send error: %s\n", error_string);
        }

        std::vector<int> nextColorCodes = codes;
        nextColorCodes[nextNode] = currentColorCode;

        mpi_error = MPI_Send(nextColorCodes.data(), nodesNumber, MPI_INT, destination, 0, MPI_COMM_WORLD);
        if (mpi_error != MPI_SUCCESS) {
            char error_string[MPI_MAX_ERROR_STRING];
            int length;
            MPI_Error_string(mpi_error, error_string, &length);
            printf("MPI_Send error: %s\n", error_string);
        }
    }

    std::vector<int> nextColorCodes = codes;
    nextColorCodes[nextNode] = 0;
    std::vector<int> result = graphColoringRecursive(nextNode, graph, colorsNumber, nextColorCodes, mpiRank, mpiSize, nextPower);

    if (result[0] != -1) {
        return result;
    }

    for (int currentColorCode = 1; currentColorCode < colorCode; currentColorCode++) {
        destination = mpiRank + coefficient * currentColorCode;
        result.resize(nodesNumber);
        MPI_Recv(result.data(), nodesNumber, MPI_INT, destination, MPI_ANY_TAG, MPI_COMM_WORLD, MPI_STATUS_IGNORE);

        if (result[0] != -1) {
            return result;
        }
    }

    for (int currentColorCode = colorCode; currentColorCode < colorsNumber; currentColorCode++) {
        nextColorCodes = codes;
        nextColorCodes[nextNode] = currentColorCode;
        result = graphColoringRecursive(nextNode, graph, colorsNumber, nextColorCodes, mpiRank, mpiSize, nextPower);

        if (result[0] != -1) {
            return result;
        }
    }

    return result;
}

void GraphColoring::graphColoringChild(int mpiRank, int mpiSize, Graph &graph, int colorsNumber) {
    int nodesNumber = graph.getNodesNumber();
    int data[3];
    MPI_Recv(data, 3, MPI_INT, MPI_ANY_SOURCE, MPI_ANY_TAG, MPI_COMM_WORLD, MPI_STATUS_IGNORE);

    int parent = data[0];
    int nodeId = data[1];
    int power = data[2];

    std::vector<int> codes(nodesNumber);
    MPI_Recv(codes.data(), nodesNumber, MPI_INT, MPI_ANY_SOURCE, MPI_ANY_TAG, MPI_COMM_WORLD, MPI_STATUS_IGNORE);

    std::vector<int> result = graphColoringRecursive(nodeId, graph, colorsNumber, codes, mpiRank, mpiSize, power);

    int mpi_error = MPI_Send(result.data(), nodesNumber, MPI_INT, parent, 0, MPI_COMM_WORLD);
    if (mpi_error != MPI_SUCCESS) {
        char error_string[MPI_MAX_ERROR_STRING];
        int length;
        MPI_Error_string(mpi_error, error_string, &length);
        printf("MPI_Send error: %s\n", error_string);
    }
}

std::vector<int> GraphColoring::fillArray(int length, int value) {
    return std::vector<int>(length, value);
}

bool GraphColoring::isColorValid(int node, std::vector<int> &codes, Graph &graph) {
    for (int current = 0; current < node; current++) {
        if ((graph.existsEdge(node, current) || graph.existsEdge(current, node)) && codes[node] == codes[current]) {
            return false;
        }
    }
    return true;
}