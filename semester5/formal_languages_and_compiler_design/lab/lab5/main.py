from domain.grammar import Grammar

FILE_NAME = 'g2.txt'

def main():
    grammar = Grammar.from_file(FILE_NAME)
    print("Grammar:")
    print(grammar)

    print("\nProductions for program:")
    print(grammar.get_productions_for("program"))

    print("\nIs CFG:")
    print(grammar.is_cfg())

if __name__ == '__main__':
    main()
