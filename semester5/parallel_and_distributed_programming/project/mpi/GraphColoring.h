#ifndef GRAPH_COLORING_H
#define GRAPH_COLORING_H

#include <vector>
#include <map>
#include "Graph.h"
#include "Color.h"

class GraphColoring {
public:
    static std::map<int, std::string> graphColoringMain(int mpiSize, Graph& graph, Color& colors);
    static void graphColoringChild(int mpiRank, int mpiSize, Graph& graph, int colorsNumber);

private:
    static std::vector<int> graphColoringRecursive(int nodeId, Graph& graph, int colorsNumber, std::vector<int> codes, int mpiRank, int mpiSize, int power);
    static std::vector<int> fillArray(int length, int value);
    static bool isColorValid(int node, std::vector<int>& codes, Graph& graph);
};

#endif // GRAPH_COLORING_H