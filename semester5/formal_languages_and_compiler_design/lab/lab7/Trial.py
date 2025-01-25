from Grammar import Grammar

class Node:
    def __init__(self, value):
        self.father = -1
        self.sibling = -1
        self.value = value
        self.production = -1

    def __str__(self):
        return str(self.value) + "  " + str(self.father) + "  " + str(self.sibling)


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


class Grammar:
    def __init__(self, file_name):
        self.non_terminals = []
        self.terminals = []
        self.productions = {}
        self.start_symbol = None
        self.read_grammar(file_name)

    def read_grammar(self, file_name):
        with open(file_name, 'r') as file:
            lines = file.readlines()
            self.non_terminals = lines[0].strip().split()
            self.terminals = lines[1].strip().split()
            self.start_symbol = lines[2].strip()
            for line in lines[3:]:
                if line.strip():
                    lhs, rhs = line.strip().split(' -> ')
                    rhs_alternatives = [alt.split() for alt in rhs.split('|')]
                    self.productions[lhs] = rhs_alternatives

    def get_non_terminals(self):
        return self.non_terminals

    def get_terminals(self):
        return self.terminals

    def get_productions(self):
        return self.productions

    def get_start_symbol(self):
        return self.start_symbol

    def get_productions_for_non_terminal(self, non_terminal):
        return self.productions.get(non_terminal, [])


class ParserRecursiveDescendent:
    def __init__(self, grammar_file, sequence_file, out_file):
        self.grammar = Grammar(grammar_file)
        self.sequence = self.read_sequence(sequence_file)
        self.out_file = out_file
        self.init_out_file()
        print(self.sequence)
        # working stack
        self.working = []  # examples: [], [(S, 1), 'a', ]
        # input stack
        self.input = [self.grammar.get_start_symbol()]  # ['S'], ['a', 'S', 'b', 'S', 'b', 'S']
        # q - normal state, b - back state, f - final state, e -error state
        self.state = "q"
        # position of current symbol in input sequence
        self.index = 0
        # representation- parsing tree
        self.tree = []

    def read_sequence(self, seq_file):
        sequence = []
        with open(seq_file, 'r') as f:
            for line in f:
                token, _ = line.strip().split('|')
                sequence.append(token.strip())
        return sequence

    def init_out_file(self):
        with open(self.out_file, 'w') as f:
            f.write("")

    def write_in_out(self, message):
        with open(self.out_file, 'a') as f:
            f.write(message + "\n")

    def expand(self):
        non_terminal = self.input.pop(0)
        self.working.append((non_terminal, 0))
        new_production = self.grammar.get_productions_for_non_terminal(non_terminal)[0]
        self.input = new_production + self.input

    def advance(self):
        self.working.append(self.input.pop(0))
        self.index += 1

    def momentary_insuccess(self):
        self.state = "b"

    def back(self):
        last_item = self.working.pop()
        self.input.insert(0, last_item)
        self.index -= 1

    def success(self):
        self.state = "f"

    def another_try(self):
        last_nt, production_idx = self.working.pop()
        alternatives = self.grammar.get_productions_for_non_terminal(last_nt)
        if production_idx + 1 < len(alternatives):
            self.state = "q"
            self.working.append((last_nt, production_idx + 1))
            current_production = alternatives[production_idx]
            self.input = self.input[len(current_production):]
            self.input = alternatives[production_idx + 1] + self.input
        else:
            if not self.working:
                self.state = "e"
            else:
                self.back()

    def create_parsing_tree(self):
        father = -1
        for idx, item in enumerate(self.working):
            if isinstance(item, tuple):
                node = Node(item[0])
                node.production = item[1]
            else:
                node = Node(item)
            self.tree.append(node)

        for idx, item in enumerate(self.working):
            if isinstance(item, tuple):
                self.tree[idx].father = father
                father = idx
                production = self.grammar.get_productions()[item[0]][item[1]]
                children_indices = list(range(idx + 1, idx + 1 + len(production)))
                for i in range(len(children_indices) - 1):
                    self.tree[children_indices[i]].sibling = children_indices[i + 1]

    def run(self, w):
        while self.state not in {"f", "e"}:
            if self.state == "q":
                if not self.input and self.index == len(w):
                    self.success()
                elif not self.input:
                    self.state = "e"
                else:
                    if self.input[0] in self.grammar.get_non_terminals():
                        self.expand()
                    elif self.index < len(w) and self.input[0] == w[self.index]:
                        self.advance()
                    else:
                        self.momentary_insuccess()
            elif self.state == "b":
                if self.working and isinstance(self.working[-1], tuple):
                    self.another_try()
                else:
                    self.back()

        if self.state == "f":
            self.create_parsing_tree()


if __name__ == "__main__":
    grammar_file = "g2.txt"
    sequence_file = "PIF.out"
    output_file = "out2.txt"

    parser_output = ParserOutput(grammar_file, sequence_file, output_file)
    parser_output.run()
