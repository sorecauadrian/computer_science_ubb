#include "Graph.h"
#include <stdexcept>
#include <iostream>

Graph::Graph(int n) : nodesNumber(n) {
    for (int i = 0; i < n; ++i) {
        nodes[i] = std::set<int>();
    }
}

void Graph::addEdge(int node1, int node2) {
    nodes[node1].insert(node2);
    nodes[node2].insert(node1);
}

int Graph::getNodesNumber() const {
    return nodesNumber;
}

const std::set<int> &Graph::getNeighbours(int node) const {
    auto it = nodes.find(node);

    if (it != nodes.end()) {
        return it->second;
    }

    throw std::runtime_error("Node not found");
}

std::vector<std::vector<int>> Graph::getAdjacencyMatrix() const {
    std::vector<std::vector<int>> adjacencyMatrix(nodesNumber, std::vector<int>(nodesNumber, 0));

    for (const auto &nodeEntry: nodes) {
        int node = nodeEntry.first;
        const std::set<int> &neighbors = nodeEntry.second;

        for (int neighbor: neighbors) {
            adjacencyMatrix[node][neighbor] = 1;
            adjacencyMatrix[neighbor][node] = 1;
        }
    }

    return adjacencyMatrix;
}

bool Graph::existsEdge(int node1, int node2) {
    return nodes[node1].find(node2) != nodes[node1].end();
}

Graph Graph::generateRandomGraph(int n, int m) {
    Graph graph(n);

    for (int i = 0; i < m; ++i) {
        int node1 = rand() % n;
        int node2 = rand() % n;

        if (graph.existsEdge(node1, node2)) {
            --i;
            continue;
        }

        graph.addEdge(node1, node2);
    }

    return graph;
}

bool Graph::existsEdge(int node1, int node2) const {
    return nodes.find(node1) != nodes.end() && nodes.find(node2) != nodes.end() &&
           nodes.at(node1).find(node2) != nodes.at(node1).end();
}