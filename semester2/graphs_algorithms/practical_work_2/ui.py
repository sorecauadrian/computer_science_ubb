from graph import *


class UI:
    def __init__(self):
        self.graph = None
        self.copy = None

    # the first option
    def random_graph_with_given_number_of_vertices_and_edges(self):
        vertices = input("the number of vertices: ")
        edges = input("the number of edges: ")
        try:
            self.graph = DirectedGraph(int(vertices), int(edges))
            print("done!")
        except Exception as e:
            print(e)

    # the second option
    def read_graph_from_given_file(self):
        input_file = input("the path to the input file: ")
        try:
            self.graph = read_file(input_file)
            print("done!")
        except Exception as e:
            print(e)

    # the third option
    def write_graph_in_a_given_file(self):
        output_file = input("the path to the output file: ")
        try:
            write_file(output_file, self.graph)
            print("done!")
        except Exception as e:
            print(e)

    # the fourth option
    def number_of_vertices(self):
        print("there are {} vertices in the graph.".format(self.graph.number_of_vertices()))

    # the fifth option
    def vertices(self):
        if self.graph.number_of_vertices() > 0:
            for vertex in self.graph.vertices_iterator():
                print(vertex, end=" ")
            print()
        else:
            print("the graph is empty!")

    # the sixth option
    def is_edge(self):
        vertex1 = input("the first vertex: ")
        vertex2 = input("the second vertex: ")
        try:
            if self.graph.is_edge(int(vertex1), int(vertex2)):
                print("the edge {} - {} exists.".format(vertex1, vertex2))
            else:
                print("the edge {} - {} doesn't exist.".format(vertex1, vertex2))
        except Exception as e:
            print(e)

    # the seventh option
    def in_degree(self):
        vertex = input("the vertex: ")
        try:
            print(self.graph.number_of_predecessors(int(vertex)))
        except Exception as e:
            print(e)

    # the eight option
    def out_degree(self):
        vertex = input("the vertex: ")
        try:
            print(self.graph.number_of_successors(int(vertex)))
        except Exception as e:
            print(e)

    # the ninth option
    def predecessors(self):
        vertex = input("the vertex: ")
        try:
            if self.graph.number_of_predecessors(int(vertex)) > 0:
                for node in self.graph.predecessors_iterator(int(vertex)):
                    print(node, end=" ")
                print()
            else:
                print("the vertex {} doesn't have predecessors!".format(vertex))
        except Exception as e:
            print(e)

    # the tenth option
    def successors(self):
        vertex = input("the vertex: ")
        try:
            if self.graph.number_of_successors(int(vertex)) > 0:

                for node in self.graph.successors_iterator(int(vertex)):
                    print(node, end=" ")
                print()
            else:
                print("the vertex {} doesn't have successors!".format(vertex))
        except Exception as e:
            print(e)

    # the eleventh option
    def add_vertex(self):
        vertex = input("the vertex: ")
        try:
            self.graph.add_vertex(int(vertex))
            print("done!")
        except Exception as e:
            print(e)

    # the twelfth option
    def remove_vertex(self):
        vertex = input("the vertex: ")
        try:
            self.graph.remove_vertex(int(vertex))
            print("done!")
        except Exception as e:
            print(e)

    # the thirteenth option
    def add_edge(self):
        vertex1 = input("the first vertex: ")
        vertex2 = input("the second vertex: ")
        cost = input("the cost: ")
        try:
            self.graph.add_edge(int(vertex1), int(vertex2), int(cost))
            print("done!")
        except Exception as e:
            print(e)

    # the fourteenth option
    def remove_edge(self):
        vertex1 = input("the first vertex: ")
        vertex2 = input("the second vertex: ")
        try:
            self.graph.remove_edge(int(vertex1), int(vertex2))
            print("done!")
        except Exception as e:
            print(e)

    # the fifteenth option
    def copy_the_graph(self):
        self.copy = self.graph.copy()
        print("done!")

    # the sixteenth option
    def print_the_cost_of_an_edge(self):
        vertex1 = input("the first vertex: ")
        vertex2 = input("the second vertex: ")
        try:
            print(self.graph.edge_cost(int(vertex1), int(vertex2)))
        except Exception as e:
            print(e)

    # the seventeenth option
    def change_the_cost_of_an_edge(self):
        vertex1 = input("the first vertex: ")
        vertex2 = input("the second vertex: ")
        new_cost = input("the new cost: ")
        try:
            self.graph.set_edge_cost(int(vertex1), int(vertex2), int(new_cost))
            print("done!")
        except Exception as e:
            print(e)

    def bbfs(self):
        vertex1 = input("the starting vertex: ")
        vertex2 = input("the ending vertex: ")
        try:
            self.graph.bbfs(int(vertex1), int(vertex2))
        except Exception as e:
            print(e)

    @staticmethod
    def print_menu():
        print("1. create a graph with a specified number of vertices and edges.")
        print("2. read a graph from a specified text file.")
        print("3. write the graph in a specified text file.")
        print("4. print the number of vertices of the graph.")
        print("5. print the vertices of the graph.")
        print("6. check whether a given edge exists.")
        print("7. print the in degree of a given vertex.")
        print("8. print the out degree of a given vertex.")
        print("9. print the predecessors of a given vertex.")
        print("10. print the successors of a given vertex.")
        print("11. add a vertex.")
        print("12. remove a vertex.")
        print("13. add an edge.")
        print("14. remove an edge.")
        print("15. copy the graph.")
        print("16. get the cost of an edge.")
        print("17. change the cost of an edge.")
        print("18. bbfs.")
        print("0. exit")

    def start(self):
        options = {"1": self.random_graph_with_given_number_of_vertices_and_edges,
                   "2": self.read_graph_from_given_file,
                   "3": self.write_graph_in_a_given_file,
                   "4": self.number_of_vertices,
                   "5": self.vertices,
                   "6": self.is_edge,
                   "7": self.in_degree,
                   "8": self.out_degree,
                   "9": self.predecessors,
                   "10": self.successors,
                   "11": self.add_vertex,
                   "12": self.remove_vertex,
                   "13": self.add_edge,
                   "14": self.remove_edge,
                   "15": self.copy_the_graph,
                   "16": self.print_the_cost_of_an_edge,
                   "17": self.change_the_cost_of_an_edge,
                   "18": self.bbfs}
        while True:
            self.print_menu()
            command = input("> ")
            if command in options:
                options[command]()
            elif command == "0":
                exit()
            else:
                print("this command doesn't exist! try again!")
