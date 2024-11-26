class Grammar:
    def __init__(self, terminals, non_terminals, start_symbol, productions):
        self.E = terminals
        self.N = non_terminals
        self.S = start_symbol
        self.P = productions

    @staticmethod
    def from_file(file_name):
        with open(file_name, 'r') as file:
            non_terminals = Grammar._parse_line(file.readline())
            terminals = Grammar._parse_line(file.readline())
            start_symbol = file.readline().split('=')[1].strip()
            productions = Grammar._parse_productions(file.readlines())

        return Grammar(terminals, non_terminals, start_symbol, productions)

    @staticmethod
    def _parse_line(line):
        try:
            after_equal = line.strip().split('=', 1)[1].strip()
            if not after_equal.startswith('{') or not after_equal.endswith('}'):
                raise ValueError(f"Line does not contain a properly enclosed set: {line}")
            content = after_equal[1:-1].strip()
            return [item.strip() for item in content.split(',')] if content else []
        except IndexError as e:
            raise ValueError(f"Error parsing line: {line}") from e

    @staticmethod
    def _parse_productions(lines):
        productions = {}
        for line in lines:
            if '->' in line:
                lhs, rhs = line.strip().split('->')
                lhs = lhs.strip()
                rhs = [rule.strip().split() for rule in rhs.split('|')]

                if lhs not in productions:
                    productions[lhs] = []

                productions[lhs].extend(rhs)
        return productions

    def get_productions_for(self, non_terminal):
        if non_terminal not in self.N:
            raise ValueError(f"'{non_terminal}' is not a non-terminal.")
        return self.P.get(non_terminal, [])

    def is_cfg(self):
        for lhs, rhs_list in self.P.items():
            if lhs not in self.N:
                return False
            for rhs in rhs_list:
                if not all(sym in self.N or sym in self.E for sym in rhs):
                    return False
        return True

    def __str__(self):
        return (
            f"Non-terminals: {self.N}\n"
            f"Terminals: {self.E}\n"
            f"Start Symbol: {self.S}\n"
            f"Productions: {self.P}"
        )
