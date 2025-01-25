from Grammar import Grammar
from RecDescParser import ParserRecursiveDescendent
# class Node:
#     def __init__(self, value):
#         self.father = -1
#         self.sibling = -1
#         self.value = value
#         self.production = -1
#
#     def __str__(self):
#         return str(self.value) + "  " + str(self.father) + "  " + str(self.sibling)


class ParserOutput:
    def __init__(self, grammar_file, sequence_file, output_file):
        self.parser = ParserRecursiveDescendent(grammar_file, sequence_file, output_file)
        self.tree = self.parser.tree

    def transform_parsing_tree(self):
        return self.tree

    def print_to_screen(self):
        print("\nParsing Tree (Table Representation):")
        print("Index | Value         | Father | Sibling")
        print("------+---------------+--------+--------")
        for idx, node in enumerate(self.tree):
            print(f"{idx:5} | {node.value:13} | {node.father:6} | {node.sibling:6}")

    def save_to_file(self, file_name):
        with open(file_name, 'w') as f:
            f.write("Parsing Tree (Table Representation):\n")
            f.write("Index | Value         | Father | Sibling\n")
            f.write("------+---------------+--------+--------\n")
            for idx, node in enumerate(self.tree):
                f.write(f"{idx:5} | {node.value:13} | {node.father:6} | {node.sibling:6}\n")

    def run(self):
        self.parser.run(self.parser.sequence)
        self.transform_parsing_tree()
        self.print_to_screen()
        self.save_to_file("parsing_tree_table.txt")


# class Grammar:
#     def __init__(self, file_name):
#         self.non_terminals = []
#         self.terminals = []
#         self.productions = {}
#         self.start_symbol = None
#         self.read_grammar(file_name)
#
#     def read_grammar(self, file_name):
#         with open(file_name, 'r') as file:
#             lines = file.readlines()
#             self.non_terminals = lines[0].strip().split()
#             self.terminals = lines[1].strip().split()
#             self.start_symbol = lines[2].strip()
#             for line in lines[3:]:
#                 if line.strip():
#                     lhs, rhs = line.strip().split(' -> ')
#                     rhs_alternatives = [alt.split() for alt in rhs.split('|')]
#                     self.productions[lhs] = rhs_alternatives
#
#     def get_non_terminals(self):
#         return self.non_terminals
#
#     def get_terminals(self):
#         return self.terminals
#
#     def get_productions(self):
#         return self.productions
#
#     def get_start_symbol(self):
#         return self.start_symbol
#
#     def get_productions_for_non_terminal(self, non_terminal):
#         return self.productions.get(non_terminal, [])


# Assuming ParserRecursiveDescendent is implemented above as provided
if __name__ == "__main__":
    grammar_file = "g2.txt"
    sequence_file = "PIF.out"
    output_file = "out2.txt"

    parser_output = ParserOutput(grammar_file, sequence_file, output_file)
    parser_output.run()
