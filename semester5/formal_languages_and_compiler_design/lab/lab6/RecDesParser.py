from Grammar import Grammar


class Node:
    def __init__(self, value):
        self.father = -1
        self.sibling = -1
        self.value = value
        self.production = -1

    def __str__(self):
        return str(self.value) + "  " + str(self.father) + "  " + str(self.sibling)


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
        self.input = [self.grammar.get_start_symbol()[0]]  # ['S'], ['a', 'S', 'b', 'S', 'b', 'S']
        # q - normal state, b - back state, f - final state, e -error state
        self.state = "q"
        # position of current symbol in input sequence
        self.index = 0
        # representation- parsing tree
        self.tree = []
        # run the Parser for the sequence
        self.run(self.sequence)

    def read_sequence(self, seq_file):
        seq = []
        with open(seq_file) as f:
            if seq_file == "PIF.out":
                line = f.readline()
                line = f.readline()
                while line:
                    elems_line = line.split(" ")
                    seq.append(elems_line[0])
                    line = f.readline()
            else:
                line = f.readline()
                while line:
                    seq.append(line[0:-1])
                    line = f.readline()
        return seq

    def get_situation(self):
        with open(self.out_file, 'a') as f:
            # f.write("--------------\n")
            f.write(str(self.state) + " ")
            f.write(str(self.index) + "\n")
            f.write(str(self.working) + "\n")
            f.write(str(self.input) + "\n")
        # print("--------------")
        # print(self.state)
        # print(self.index)
        # print(self.working)
        # print(self.input)

    def init_out_file(self):
        f = open(self.out_file, 'w')
        f.write("")
        f.close()

    def write_in_out(self, message, final=False):
        with open(self.out_file, 'a') as f:
            if final:
                f.write("-------RESULT:-------\n")
            f.write(message + "\n")

    def expand(self):
        # print("---expand---")
        self.write_in_out("---expand---")
        non_terminal = self.input.pop(0)
        self.working.append((non_terminal, 0))
        # self.input.append(self.grammar.get_productions_for_non_terminal(non_terminal)[0])
        new_production = self.grammar.get_productions_for_non_terminal(non_terminal)[0]
        self.input = new_production + self.input

    def advance(self):
        # print("---advance---")
        self.write_in_out("---advance---")
        self.working.append(self.input.pop(0))
        self.index += 1

    def momentary_insuccess(self):
        # print("---momentary insuccess---")
        self.write_in_out("---momentary insuccess---")
        self.state = "b"

    def back(self):
        # print("---back---")
        self.write_in_out("---back---")
        new_thing = self.working.pop()
        self.input = [new_thing] + self.input
        self.index -= 1

    def success(self):
        # print("---success---")
        self.write_in_out("---success---")
        self.state = "f"

    def another_try(self):
        # print("---another try---")
        self.write_in_out("---another try---")
        last_nt = self.working.pop()  # (nt, production_nr)
        if last_nt[1] + 1 < len(self.grammar.get_productions_for_non_terminal(last_nt[0])):
            self.state = "q"
            # put working next production for the nt
            new_tupple = (last_nt[0], last_nt[1] + 1)
            self.working.append(new_tupple)
            # change production on top input
            len_last_production = len(self.grammar.get_productions_for_non_terminal(last_nt[0])[last_nt[1]])
            # delete last production from input
            self.input = self.input[len_last_production:]  # maybe len -1
            # put new production in input
            new_production = self.grammar.get_productions_for_non_terminal(last_nt[0])[last_nt[1] + 1]
            self.input = new_production + self.input
        elif self.index == 1 and last_nt[0] == self.grammar.get_start_symbol():
            self.state = "e"
        else:
            # change production on top input
            len_last_production = len(self.grammar.get_productions_for_non_terminal(last_nt[0])[last_nt[1]])
            # delete last production from input
            self.input = self.input[len_last_production:]
            self.input = [last_nt[0]] + self.input

    def print_working(self):
        print(self.working)
        self.write_in_out(str(self.working))

    def run(self, w):
        while (self.state != 'f') and (self.state != 'e'):
            self.get_situation()
            if self.state == 'q':
                if len(self.input) == 0 and self.index == len(w):
                    self.success()
                elif len(self.input) == 0:
                    self.state = 'e'
                    print("No input, still have terminals to parse")
                    break
                else:
                    if self.input[0] in self.grammar.get_non_terminals():
                        self.expand()
                    else:
                        if self.index < len(w) and self.input[0] == w[self.index]:
                            self.advance()
                        else:
                            self.momentary_insuccess()
            else:
                if self.state == 'b':
                    if self.index == 0 and len(self.working) == 0:
                        self.state = 'e'
                        print("no top working to look at in Back!")
                        break
                    if self.working[-1] in self.grammar.get_terminals():
                        self.back()
                    else:
                        self.another_try()
        if self.state == 'e':
            mesaj = "ERROR! @ index: {}".format(self.index)
        else:
            mesaj = "Sequence is accepted!"
            self.print_working()
        print(mesaj)
        self.write_in_out(mesaj, True)
        self.create_parsing_tree()
        self.write_parsing_tree()

    def create_parsing_tree(self):
        father = -1
        for index in range(0, len(self.working)):
            if type(self.working[index]) == tuple:
                self.tree.append(Node(self.working[index][0]))
                self.tree[index].production = self.working[index][1]
            else:
                self.tree.append(Node(self.working[index]))

        for index in range(0, len(self.working)):
            if type(self.working[index]) == tuple:
                self.tree[index].father = father
                father = index
                len_prod = len(self.grammar.get_productions()[self.working[index][0]][self.working[index][1]])
                vector_indx = []
                for i in range(1, len_prod + 1):
                    vector_indx.append(index + i)
                for i in range(0, len_prod):
                    if self.tree[vector_indx[i]].production != -1:
                        offset = self.get_len_depth(vector_indx[i])
                        for j in range(i + 1, len_prod):
                            vector_indx[j] += offset
                for i in range(0, len_prod - 1):
                    self.tree[vector_indx[i]].sibling = vector_indx[i + 1]
            else:
                self.tree[index].father = father
                father = -1

    def get_len_depth(self, index):
        production = self.grammar.get_productions()[self.working[index][0]][self.working[index][1]]
        len_prod = len(production)
        sum = len_prod
        for i in range(1, len_prod + 1):
            if type(self.working[index + i]) == tuple:
                sum += self.get_len_depth(index + i)
        return sum

    def write_parsing_tree(self):
        if self.state != "e":
            self.write_in_out("\nParsing tree: ")
            self.write_in_out("idx val f  sibling")
            for index in range(0, len(self.working)):
                msg = str(index) + "  " + str(self.tree[index])
                self.write_in_out(msg)


parcer_trial2 = ParserRecursiveDescendent("g2.txt", "PIF.out", "out2.txt")
# parcer_trial1 = ParserRecursiveDescendent("g1.txt", "seq.txt", "out1.txt")