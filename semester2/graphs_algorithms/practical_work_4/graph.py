from random import randrange
from copy import deepcopy
from exceptions import *


class DirectedGraph:
    def __init__(self, vertices: int = 0, edges: int = 0):
        if edges > vertices * vertices:
            print("the number of edges is too big, we'll construct a complete graph!")
            edges = vertices * vertices
        self.vertices = set()
        self.predecessors = dict()
        self.successors = dict()
        self.costs = dict()
        self.duration = [] * len(self.vertices) # the duration of activity i
        self.earliest_start = [float('-inf')] * len(self.vertices) # the earliest time when activity i begins
        self.earliest_end = [float('-inf')] * len(self.vertices) # the earliest time when activity i ends
        self.latest_start = [float('inf')] * len(self.vertices) # the latest time when activity i starts
        self.latest_end = [float('inf')] * len(self.vertices) # the latest time when activity i ends
        for vertex in range(vertices):
            self.add_vertex(vertex)
        for _ in range(edges):
            vertex1 = randrange(vertices)
            vertex2 = randrange(vertices)
            while self.is_edge(vertex1, vertex2):
                vertex1 = randrange(vertices)
                vertex2 = randrange(vertices)
            self.add_edge(vertex1, vertex2, randrange(1000000))

    # getters
    def number_of_vertices(self):
        return len(self.vertices)
    
    def number_of_predecessors(self, vertex: int):
        if not self.is_vertex(vertex):
            raise VertexError("vertex {} doesn't exist!".format(vertex))
        return len(self.predecessors[vertex])

    def number_of_successors(self, vertex: int):
        if not self.is_vertex(vertex):
            raise VertexError("vertex {} doesn't exist!".format(vertex))
        return len(self.successors[vertex])
    
    def number_of_edges(self):
        return len(self.costs)
    
    def edge_cost(self, vertex1: int, vertex2: int):
        if (vertex1, vertex2) not in self.costs:
            raise EdgeError("the edge {} - {} doesn't exist!".format(vertex1, vertex2))
        return self.costs[(vertex1, vertex2)]

    # iterators
    def vertices_iterator(self):
        for vertex in self.vertices:
            yield vertex

    def predecessors_iterator(self, vertex: int):
        if not self.is_vertex(vertex):
            raise VertexError("vertex {} doesn't exist!".format(vertex))
        for node in self.predecessors[vertex]:
            yield node

    def successors_iterator(self, vertex: int):
        if not self.is_vertex(vertex):
            raise VertexError("vertex {} doesn't exist!".format(vertex))
        for node in self.successors[vertex]:
            yield node

    def edges_iterator(self):
        for key, value in self.costs.items():
            yield key[0], key[1], value

    # checkers
    def is_vertex(self, vertex: int):
        return vertex in self.vertices

    def is_edge(self, vertex1: int, vertex2: int):
        return vertex1 in self.successors and vertex2 in self.successors[vertex1] 
    
    # setters
    def set_edge_cost(self, vertex1: int, vertex2: int, new_cost: int):
        if (vertex1, vertex2) not in self.costs:
            raise EdgeError("the edge {} - {} doesn't exist!".format(vertex1, vertex2))
        self.costs[(vertex1, vertex2)] = new_cost

    def set_duration(self, times):
        self.duration = times

    # functionalities
    def add_vertex(self, vertex: int):
        if self.is_vertex(vertex):
            raise VertexError("the vertex {} already exists in the graph!".format(vertex))
        self.vertices.add(vertex)
        self.predecessors[vertex] = set()
        self.successors[vertex] = set()

    def add_edge(self, vertex1: int, vertex2: int, cost: int = 0):
        if self.is_edge(vertex1, vertex2):
            raise EdgeError("the edge {} - {} already exists in the graph!".format(vertex1, vertex2))
        if not self.is_vertex(vertex1) or not self.is_vertex(vertex2):
            raise VertexError("one or both of the vertices don't exist!")
        self.predecessors[vertex2].add(vertex1)
        self.successors[vertex1].add(vertex2)
        self.costs[(vertex1, vertex2)] = cost

    def remove_vertex(self, vertex: int):
        if not self.is_vertex(vertex):
            raise VertexError("the vertex {} doesn't exist!".format(vertex))
        for node in self.predecessors[vertex]:
            del self.costs[(node, vertex)]
            self.successors[node].remove(vertex)
        for node in self.successors[vertex]:
            del self.costs[(vertex, node)]
            self.predecessors[node].remove(vertex)
        del self.predecessors[vertex]
        del self.successors[vertex]
        self.vertices.remove(vertex)

    def remove_edge(self, vertex1: int, vertex2: int):
        if not self.is_edge(vertex1, vertex2):
            raise EdgeError("the edge {} - {} doesn't exist".format(vertex1, vertex2))
        del self.costs[(vertex1, vertex2)]
        self.predecessors[vertex2].remove(vertex1)
        self.successors[vertex1].remove(vertex2)

    # practical work 4
    def topological_sort_dfs(self, vertex : int, sorted : list, fully_processed : set, in_process : set):
        in_process.add(vertex)
        for successor in self.successors[vertex]:
            if successor in in_process:
                return False
            elif successor not in fully_processed:
                ok = self.topological_sort_dfs(successor, sorted, fully_processed, in_process)
                if not ok:
                    return False
        in_process.remove(vertex)
        sorted.append(vertex)
        fully_processed.add(vertex)
        return True

    # checks if the corresponding graph is a DAG and performs a topological sorting of the
    # activities using Tarjan's algorithm (DFS).
    # runtime: O(V+E), where V is the number of vertices and E the number of edges in the graph
    def toposort(self):
        sorted = list()
        fully_processed = set()
        in_process = set()
        for x in self.vertices:
            if x not in fully_processed:
                ok = self.topological_sort_dfs(x, sorted, fully_processed, in_process)
                if not ok:
                    return False
        sorted.reverse()
        return sorted
    
    def get_times(self):
        sorted_vertices = self.toposort()
        self.earliest_start = [float('-inf')] * self.number_of_vertices()
        self.earliest_end = [float('-inf')] * self.number_of_vertices()
        self.latest_start = [float('inf')] * self.number_of_vertices()
        self.latest_end = [float('inf')] * self.number_of_vertices()
        
        for vertex in sorted_vertices:
            if self.number_of_predecessors(vertex) == 0:
                self.earliest_start[vertex] = 0
            else:
                for predecessor in self.predecessors_iterator(vertex):
                    self.earliest_start[vertex] = max(self.earliest_start[vertex], self.earliest_end[predecessor])
            self.earliest_end[vertex] = self.earliest_start[vertex] + self.duration[vertex]

        sorted_vertices.reverse()
        for vertex in sorted_vertices:
            if self.number_of_successors(vertex) == 0:
                self.latest_end[vertex] = self.earliest_end[sorted_vertices[0]]
            for successor in self.successors_iterator(vertex):
                self.latest_end[vertex] = min(self.latest_end[vertex], self.latest_start[successor])
            self.latest_start[vertex] = self.latest_end[vertex] - self.duration[vertex]

        if not sorted_vertices:
            return -1, -1, -1, -1, -1
        return self.earliest_start, self.earliest_end, self.latest_start, self.latest_end, self.latest_end[sorted_vertices[0]]

    def critical_activities(self):
        a = self.get_times()
        critical = []
        for i in range(self.number_of_vertices()):
            if self.earliest_start[i] == self.latest_start[i]:
                critical.append(i)
        return critical


    # copy
    def copy(self):
        return deepcopy(self)

# reads activities from a CSV-like text file. format: the first line contains the number of activities n and it is
# followed by n lines of the format: activity number, predecessors(separated by +; "-" if there are no predecessors)
# and the duration of the activity. The associated graph is constructed and returned.
def read_activities(input_file: str):
    file = open(input_file, "r")
    graph = DirectedGraph(0, 0)
    lines = [line.split(',') for line in file.read().split('\n')]
    number_of_vertices = int(lines[0][0])
    for i in range(number_of_vertices):
        graph.add_vertex(i)
    times = [0] * number_of_vertices
    for line in lines[1:]:
        activity = int(line[0])
        duration = int(line[2])
        prerequisites = list()
        if line[1] != '-':
            prerequisites = [vertex for vertex in line[1].split('+')]
        times[activity] = duration
        for vertex in prerequisites:
            graph.add_edge(int(vertex), activity, 0)
        graph.set_duration(times)
    return graph


def read_file(input_file: str):
    file = open(input_file, "r")
    vertices, edges = map(int, file.readline().split())
    graph = DirectedGraph(vertices)
    for _ in range(edges):
        vertex1, vertex2, edge_cost = map(int, file.readline().split())
        graph.add_edge(vertex1, vertex2, edge_cost)
    isolated_vertices = map(int, file.readline().split())
    non_vertices = map(int, file.readline().split())
    for vertex in non_vertices:
        graph.remove_vertex(vertex)
    for vertex in isolated_vertices:
        graph.add_vertex(vertex)
    file.close()
    return graph


def write_file(output_file: str, graph: DirectedGraph):
    file = open(output_file, "w")
    file.write("{} {}\n".format(graph.number_of_vertices(), graph.number_of_edges()))
    isolated_vertices = []
    non_vertices = []
    for node in graph.vertices_iterator():
        for predecessor in graph.predecessors_iterator(node):
            file.write("{} {} {}\n".format(predecessor, node, graph.edge_cost(predecessor, node)))
        if node >= graph.number_of_vertices():
            isolated_vertices.append(node)
    for i in range(graph.number_of_vertices()):
        if i not in graph.vertices:
            non_vertices.append(i)
    file.write(' '.join(str(vertex) for vertex in isolated_vertices))
    file.write('\n')
    file.write(' '.join(str(vertex) for vertex in non_vertices))
    file.close()


def random_graph(vertices: int, edges: int):
    g = DirectedGraph()
    for i in range(vertices):
        g.add_vertex(i)
    for _ in range(edges):
        vertex1 = randrange(vertices)
        vertex2 = randrange(vertices)
        while g.is_edge(vertex1, vertex2):
            vertex1 = randrange(vertices)
            vertex2 = randrange(vertices)
        g.add_edge(vertex1, vertex2, randrange(1000000))
