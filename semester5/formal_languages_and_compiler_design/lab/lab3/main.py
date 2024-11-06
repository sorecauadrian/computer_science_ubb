import re

from Domain.ProgramInternalForm import ProgramInternalForm
from Domain.Scanner import Scanner
from Domain.SymbolTable import SymbolTable
from Domain.Symbols import read_file


class Main:

    def __init__(self, separators, operators, reserved_words):
        self.separators = separators
        self.operators = operators
        self.reserved_words = reserved_words
        self.symbol_table = SymbolTable(17)
        self.program_internal_form = ProgramInternalForm()
        self.scanner = Scanner(separators, operators)

    def run(self):

        problem_file = "Problem1err.txt"
        exception_message = ""

        with open(problem_file, 'r') as file:
            line_counter = 0
            for line in file:
                line_counter += 1
                tokens = self.scanner.tokenize(line.strip())
                for i in range(len(tokens)):
                    if tokens[i] in reserved_words + separators + operators:
                        if tokens[i] == ' ':
                            continue
                        self.program_internal_form.add(tokens[i], (-1, -1))
                    elif self.scanner.is_identifier(tokens[i]):
                        id = self.symbol_table.add(tokens[i])
                        self.program_internal_form.add("identifier", id)
                    elif self.scanner.is_constant(tokens[i]):
                        const = self.symbol_table.add(tokens[i])
                        self.program_internal_form.add("const", const)
                    else:
                        exception_message += 'Program has an error at token ' + tokens[i] + ', at line ' + str(
                            line_counter) + "\n"

        with open('Symbol Table.out', 'w') as writer:
            writer.write(str(self.symbol_table))

        with open('Program Internal Form.out', 'w') as writer:
            writer.write(str(self.program_internal_form))

        if exception_message == '':
            print("Program is lexically correct!")
        else:
            print(exception_message)


separators, operators, reserved_words = read_file()
print(separators)
print(operators)
print(reserved_words)
main = Main(separators, operators, reserved_words)
main.run()