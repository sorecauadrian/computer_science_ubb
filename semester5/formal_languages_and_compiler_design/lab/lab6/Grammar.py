
"""
Grammar file will be constructed as follows:
line 1: non-terminals separated by space
line 2: terminals separated by space
line 3: start symbol
line 4+: productions on each line following this rule:
            non-terminal separated by space from symbols
            and the symbols separated by "@"
            ex: S a@b@S
"""


class Grammar:
    def __init__(self, filename="g1.txt"):
        self.file = filename
        self.__grammar = self.__read_grammar()
        self.__non_terminals = self.__grammar[0]
        self.__terminals = self.__grammar[1]
        self.__productions = self.__represent_productions(self.__grammar[3])
        self.__start_symbol = self.__grammar[2]

    def __read_grammar(self):
        g = []
        with open(self.file) as f:
            # get the set of  non-terminal symbols
            line = f.readline()
            g.append(line[0:-1].split(" "))
            # get the alphabet (set of terminal symbols)
            line = f.readline()
            g.append(line[0:-1].split(" "))
            # get the start symbol
            line = f.readline()
            g.append(line[0:-1].split(" "))
            # get the finite set of productions
            p = []
            line = f.readline()
            while line:
                production = line[0:-1]

                p.append(production.split(" "))
                line = f.readline()
            g.append(p)
        return g

    @staticmethod
    def __represent_productions(productions):
        rep = {}
        for p in productions:
            if p[0] not in rep.keys():
                rep[p[0]] = []
            rep[p[0]].append(p[1].split("@"))
        return rep

    def get_non_terminals(self):
        return self.__non_terminals

    def get_terminals(self):
        return self.__terminals

    def get_start_symbol(self):
        return self.__start_symbol

    def get_productions(self):
        return self.__productions

    def get_productions_for_non_terminal(self, nt):
        return self.__productions[nt]

    def print_productions_for_non_terminal(self, nt):
        pretty_str = ""
        if nt in self.__productions.keys():
            pretty_str += "The productions for {0} are: \n".format(nt)
            for p in self.__productions[nt]:
                pretty_str += nt + " -> " + " ".join(p) + "\n"
        else:
            pretty_str += "There is no such non terminal"
        return pretty_str


def menu():
    grammar = Grammar("g1.txt")
    while True:
        try:
            option = int(input(
                "\nEnter \n1 get the set of  non-terminal symbols \n2 get the alphabet (set of terminal symbols) \n3 "
                "get the start symbol \n4 get the finite set of productions \n5 get productions from a non-terminal "
                "\n0 to exit.\n>> "))
            if option == 1:
                print(grammar.get_non_terminals())
            elif option == 2:
                print(grammar.get_terminals())
            elif option == 3:
                print(grammar.get_start_symbol())
            elif option == 4:
                print(grammar.get_productions())
            elif option == 5:
                nt = input("Give non-terminal >> ")
                print(grammar.print_productions_for_non_terminal(nt))
            elif option == 0:
                return
            else:
                print("Wrong option!")
        except Exception as e:
            print(e)
            print("Something went wrong!")


menu()
