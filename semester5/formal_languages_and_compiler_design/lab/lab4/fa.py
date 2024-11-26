class FiniteAutomata:

    def __init__(self, Q, E, q0, F, S):
        self.Q = Q  # a finite set of states
        self.E = E  # a finite set of input symbols called the alphabet
        self.q0 = q0  # an initial or start state
        self.F = F  # a set of accept or final states
        self.S = S  # a set of state transitions

    @staticmethod
    def getLine(line):
        return line.strip().split(' ')[2:]

    @staticmethod
    def validate(Q, E, q0, F, S):
        if q0 not in Q:
            return False
        for f in F:
            if f not in Q:
                return False
        for key in S.keys():
            state = key[0]
            symbol = key[1]
            if state not in Q:
                return False
            if symbol not in E:
                return False
            for dest in S[key]:
                if dest not in Q:
                    return False
        return True

    @staticmethod
    def readFromFile(file_name):
        with open(file_name) as file:
            Q = FiniteAutomata.getLine(file.readline())
            E = FiniteAutomata.getLine(file.readline())
            q0 = FiniteAutomata.getLine(file.readline())[0]
            F = FiniteAutomata.getLine(file.readline())
            file.readline()

            S = {}  # transitions
            for line in file:
                # example (A,0) -> A, source=A, route=0, destination=A
                source = line.strip().split('->')[0].strip().replace('(', '').replace(')', '').split(',')[0]
                route = line.strip().split('->')[0].strip().replace('(', '').replace(')', '').split(',')[1]
                destination = line.strip().split('->')[1].strip()

                if (source, route) in S.keys():
                    S[(source, route)].append(destination)
                else:
                    S[(source, route)] = [destination]

            if not FiniteAutomata.validate(Q, E, q0, F, S):
                raise Exception("Wrong input file.")

            return FiniteAutomata(Q, E, q0, F, S)

    """
    DFA refers to Deterministic Finite Automaton. A Finite Automata(FA) is said to be deterministic, 
    if corresponding to an input symbol, there is single resultant state i.e. there is only one transition.
    """
    def isDfa(self):
        for k in self.S.keys():
            if len(self.S[k]) > 1:
                return False
        return True

    def isAccepted(self, sequence):
        if self.isDfa():
            current = self.q0
            for symbol in sequence:  # check if we get to a final state
                if (current, symbol) in self.S.keys():
                    current = self.S[(current, symbol)][0]
                else:
                    return False
            return current in self.F
        return False