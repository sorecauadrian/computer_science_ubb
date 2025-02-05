import unittest
from graph import *


class Test(unittest.TestCase):
    def test_add_and_remove_vertex(self):
        graph = DirectedGraph()
        self.assertEqual(graph.number_of_vertices(), 0)
        graph.add_vertex(1)
        graph.add_vertex(100)
        self.assertEqual(graph.number_of_vertices(), 2)
        graph.remove_vertex(1)
        self.assertEqual(graph.number_of_vertices(), 1)
        with self.assertRaises(VertexError):
            graph.add_vertex(100)
        with self.assertRaises(VertexError):
            graph.remove_vertex(10)

    def test_add_and_remove_edge(self):
        graph = DirectedGraph(2)
        graph.add_edge(0, 1, 1)
        graph.add_edge(1, 0, -1)
        self.assertEqual(graph.number_of_edges(), 2)
        self.assertEqual(graph.number_of_successors(0), 1)
        self.assertEqual(graph.number_of_predecessors(0), 1)
        self.assertEqual(graph.number_of_successors(1), 1)
        self.assertEqual(graph.number_of_predecessors(1), 1)
        graph.remove_edge(1, 0)
        self.assertEqual(graph.number_of_edges(), 1)
        self.assertEqual(graph.number_of_successors(0), 1)
        self.assertEqual(graph.number_of_predecessors(0), 0)
        self.assertEqual(graph.number_of_successors(1), 0)
        self.assertEqual(graph.number_of_predecessors(1), 1)
        with self.assertRaises(EdgeError):
            graph.add_edge(0, 1)
        with self.assertRaises(VertexError):
            graph.add_edge(10, 20)
        with self.assertRaises(EdgeError):
            graph.remove_edge(1, 0)

    def test_iterators(self):
        graph = DirectedGraph(3)
        graph.add_edge(0, 1, 1)
        graph.add_edge(0, 2, 2)
        self.assertEqual(set(graph.edges_iterator()), {(0, 1, 1), (0, 2, 2)})
        graph.add_edge(1, 2, 1)
        graph.add_edge(2, 0, -2)
        graph.add_edge(2, 1, -1)
        graph.add_edge(1, 1, 0)
        self.assertEqual(set(graph.vertices_iterator()), {0, 1, 2})
        self.assertEqual(set(graph.predecessors_iterator(0)), {2})
        self.assertEqual(set(graph.successors_iterator(1)), {2, 1})
        graph.remove_vertex(0)
        self.assertEqual(set(graph.edges_iterator()), {(1, 2, 1), (2, 1, -1), (1, 1, 0)})
        self.assertEqual(set(graph.vertices_iterator()), {1, 2})
        self.assertEqual(set(graph.predecessors_iterator(1)), {2, 1})
        self.assertEqual(set(graph.successors_iterator(2)), {1})
        with self.assertRaises(VertexError):
            print(set(graph.successors_iterator(0)))
        with self.assertRaises(VertexError):
            print(set(graph.predecessors_iterator(0)))

    def test_is_vertex_and_is_edge(self):
        graph = DirectedGraph(2, 4)
        self.assertEqual(graph.is_vertex(0), True)
        self.assertEqual(graph.is_vertex(1), True)
        self.assertEqual(graph.is_edge(0, 1), True)
        self.assertEqual(graph.is_edge(1, 0), True)
        graph.remove_edge(1, 0)
        self.assertEqual(graph.is_vertex(0), True)
        self.assertEqual(graph.is_vertex(1), True)
        self.assertEqual(graph.is_vertex(2), False)
        self.assertEqual(graph.is_edge(0, 1), True)
        self.assertEqual(graph.is_edge(1, 0), False)
        self.assertEqual(graph.is_edge(2, 2), False)

    def test_cost(self):
        graph = DirectedGraph(2)
        graph.add_edge(1, 0, 1)
        graph.add_edge(1, 1, 0)
        graph.add_edge(0, 1, 2)
        self.assertEqual(graph.edge_cost(1, 0), 1)
        self.assertEqual(graph.edge_cost(1, 1), 0)
        self.assertEqual(graph.edge_cost(0, 1), 2)
        with self.assertRaises(EdgeError):
            print(graph.edge_cost(0, 0))
        with self.assertRaises(EdgeError):
            graph.set_edge_cost(0, 0, 1)
        graph.set_edge_cost(1, 1, 2)
        self.assertEqual(graph.edge_cost(1, 1), 2)
