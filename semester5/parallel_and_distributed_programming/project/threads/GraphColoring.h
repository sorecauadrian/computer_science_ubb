#ifndef GRAPH_COLORING_H
#define GRAPH_COLORING_H

#include "Graph.h"
#include "Color.h"
#include <map>
#include <vector>
#include <stdexcept>
#include <mutex>
#include <atomic>

class GraphColoring {
public:
    static std::map<int, std::string> getColoredGraph(int threadsNumber, const Graph &graph, const Color &colors);

    void getColoredGraphRecursive(std::atomic<int> &threadsNumber, int nodeId, Graph &graph, int colorsNumber,
                                  std::vector<int> &partialCodes, std::mutex &lock, std::vector<int> &codes);

    bool isColorValid(int node, std::vector<int> &codes, const Graph &graph);

    bool canBeColoredWith(Graph &graph, int colorsNumber);

private:
    bool tryColoringGraph(int node, Graph &graph, int colorsNumber, std::vector<int> &codes);
};

#endif // GRAPH_COLORING_H