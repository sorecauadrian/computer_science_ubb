from fa import FiniteAutomata

class Console:

    def __readFA(self):
        self.fa = FiniteAutomata.readFromFile('fa2.in')

    def __displayStates(self):
        print(self.fa.Q)

    def __displayAlphabet(self):
        print(self.fa.E)

    def __displayTransitions(self):
        print(self.fa.S)

    def __displayFinalStates(self):
        print(self.fa.F)

    def __checkDFA(self):
        print(self.fa.isDfa())

    def __checkAccepted(self):
        seq = input()
        print(self.fa.isAccepted(seq))

    def __displayMenu(self):
        print("1.Read FA")
        print("2.States")
        print("3.Alphabet")
        print("4.Transitions")
        print("5.Final states")
        print("6.Check DFA")
        print("7.Check accepted sequence")

    def run(self):
        commands = {'1': self.__readFA, '2': self.__displayStates, '3': self.__displayAlphabet,
                    '4': self.__displayTransitions, '5': self.__displayFinalStates, '6': self.__checkDFA,
                    '7': self.__checkAccepted}
        stopProgram = False
        while not stopProgram:
            self.__displayMenu()
            print(">>")
            command = input()
            if command in commands.keys():
                commands[command]()
            elif command == "stopProgram":
                stopProgram = True
            else:
                continue


if __name__ == '__main__':
    ui = Console()
    ui.run()