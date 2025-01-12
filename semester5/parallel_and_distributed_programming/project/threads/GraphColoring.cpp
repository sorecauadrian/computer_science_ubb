#include "GraphColoring.h"
#include <vector>
#include <mutex>
#include <thread>
#include <atomic>

std::map<int, std::string> GraphColoring::getColoredGraph(int threadsNumber, const Graph &graph, const Color &colors) {
    std::map<int, std::string> coloredGraph;
    std::mutex mtx;

    auto colorize = [&](int start, int end) {
        for (int i = start; i < end; ++i) {
            std::set<std::string> usedColors;

            {
                std::lock_guard<std::mutex> guard(mtx);
                const std::set<int> &neighbors = graph.getNeighbours(i);
                for (int neighbor: neighbors) {
                    if (coloredGraph.find(neighbor) != coloredGraph.end()) {
                        usedColors.insert(coloredGraph[neighbor]);
                    }
                }
            }

            for (int colorCode = 0; colorCode < colors.getColorNumber(); ++colorCode) {
                std::string colorName = colors.getColor(colorCode);
                if (usedColors.find(colorName) == usedColors.end()) {
                    std::lock_guard<std::mutex> guard(mtx);
                    coloredGraph[i] = colorName;
                    break;
                }
            }
        }
    };

    std::vector<std::thread> threads;
    int nodesPerThread = graph.getNodesNumber() / threadsNumber;

    for (int i = 0; i < threadsNumber; ++i) {
        int start = i * nodesPerThread;
        int end = (i == threadsNumber - 1) ? graph.getNodesNumber() : (i + 1) * nodesPerThread;
        threads.emplace_back(colorize, start, end);
    }

    for (auto &thread: threads) {
        if (thread.joinable()) {
            thread.join();
        }
    }

    return coloredGraph;
}

void GraphColoring::getColoredGraphRecursive(std::atomic<int> &threadsNumber, int nodeId, Graph &graph, int codesNumber,
                                        std::vector<int> &partialCodes,
                                        std::mutex &lock, std::vector<int> &codes) {
    if (!codes.empty()) {
        return;
    }

    if (nodeId + 1 == graph.getNodesNumber()) {
        if (isColorValid(nodeId, partialCodes, graph)) {
            std::lock_guard<std::mutex> guard(lock);
            if (codes.empty()) {
                codes = partialCodes;
            }
        }
        return;
    }

    int nextNode = nodeId + 1;
    std::vector<int> validColors;

    for (int code = 0; code < codesNumber; code++) {
        partialCodes[nextNode] = code;
        if (isColorValid(nextNode, partialCodes, graph)) {
            validColors.push_back(code);
        }
    }

    for (int code: validColors) {
        partialCodes[nextNode] = code;
        if (threadsNumber.fetch_sub(1, std::memory_order_relaxed) > 0) {
            std::vector<int> nextPartialCodes = partialCodes;
            std::thread thread([&] {
                getColoredGraphRecursive(threadsNumber, nextNode, graph, codesNumber, nextPartialCodes, lock, codes);
            });
            thread.join();
        } else {
            threadsNumber.fetch_add(1, std::memory_order_relaxed);
            getColoredGraphRecursive(threadsNumber, nextNode, graph, codesNumber, partialCodes, lock, codes);
        }
    }
}

bool GraphColoring::canBeColoredWith(Graph &graph, int colorsNumber) {
    std::vector<int> codes(graph.getNodesNumber(), -1);
    return tryColoringGraph(0, graph, colorsNumber, codes);
}

bool GraphColoring::tryColoringGraph(int node, Graph &graph, int colorsNumber, std::vector<int> &codes) {
    if (node == graph.getNodesNumber()) {
        return true;
    }

    for (int color = 0; color < colorsNumber; ++color) {
        codes[node] = color;
        if (isColorValid(node, codes, graph) && tryColoringGraph(node + 1, graph, colorsNumber, codes)) {
            return true;
        }
        codes[node] = -1;
    }

    return false;
}

bool GraphColoring::isColorValid(int node, std::vector<int> &codes, const Graph &graph) {
    for (int current = 0; current < node; current++) {
        if ((graph.existsEdge(node, current) || graph.existsEdge(current, node)) && codes[node] == codes[current]) {
            return false;
        }
    }
    return true;
}