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
        for vertex in range(vertices):
            self.add_vertex(vertex)
        for _ in range(edges):
            vertex1 = randrange(vertices)
            vertex2 = randrange(vertices)
            while self.is_edge(vertex1, vertex2):
                vertex1 = randrange(vertices)
                vertex2 = randrange(vertices)
            self.add_edge(vertex1, vertex2, randrange(1000000))

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

    def is_vertex(self, vertex: int):
        return vertex in self.vertices

    def is_edge(self, vertex1: int, vertex2: int):
        return vertex1 in self.successors and vertex2 in self.successors[vertex1] 
    
    def edge_cost(self, vertex1: int, vertex2: int):
        if (vertex1, vertex2) not in self.costs:
            raise EdgeError("the edge {} - {} doesn't exist!".format(vertex1, vertex2))
        return self.costs[(vertex1, vertex2)]
    
    def set_edge_cost(self, vertex1: int, vertex2: int, new_cost: int):
        if (vertex1, vertex2) not in self.costs:
            raise EdgeError("the edge {} - {} doesn't exist!".format(vertex1, vertex2))
        self.costs[(vertex1, vertex2)] = new_cost

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

    def copy(self):
        return deepcopy(self)


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
