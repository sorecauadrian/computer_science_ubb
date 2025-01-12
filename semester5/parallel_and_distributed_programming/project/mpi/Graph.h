#ifndef GRAPH_H
#define GRAPH_H

#include <map>
#include <set>
#include <vector>

class Graph {
public:
    Graph();
    Graph(int n);
    void addEdge(int node1, int node2);
    int getNodesNumber() const;
    const std::set<int>& getNeighbours(int node) const;
    std::vector<std::vector<int> > getAdjacencyMatrix() const;
    bool existsEdge(int node1, int node2);
    static Graph generateRandomGraph(int n, int m);

private:
    int nodesNumber;
    std::map<int, std::set<int> > nodes;
};

#endif // GRAPH_H