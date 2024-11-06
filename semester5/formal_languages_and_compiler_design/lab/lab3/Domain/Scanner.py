import re


class Scanner:

    def __init__(self, separators, operators):
        self.__separators = separators
        self.__operators = operators

    def is_identifier(self, token) -> bool:
        return re.match(r'^[a-z]([a-zA-Z]|[0-9])*$', token) is not None



    def is_constant(self, token) -> bool:
        return re.match(r'^(0|[+-]?[1-9][0-9]*)$|^\'.\'$|^\'.*\'$', token) is not None


    def is_part_of_an_operator(self, char) -> bool:
        for operator in self.__operators:
            if char in operator:
                return True
        return False

    def get_string_between_quotes(self, line, index) -> tuple[str, int]:
        token = ''
        quotes = 0

        while index < len(line) and quotes < 2:
            if line[index] == '\'':
                quotes += 1
            token += line[index]
            index += 1

        return token, index

    def get_operator_token(self, line, index) -> tuple[str, int]:
        token = ''

        while index < len(line) and self.is_part_of_an_operator(line[index]):
            token += line[index]
            index += 1

        return token, index

    def tokenize(self, line) -> list[str]:
        token = ''
        tokens = []
        index = 0

        while index < len(line):
            if self.is_part_of_an_operator(line[index]):
                if token:
                    tokens.append(token)
                token, index = self.get_operator_token(line, index)
                tokens.append(token)
                token = ''

            elif line[index] == '\'':
                if token:
                    tokens.append(token)
                token, index = self.get_string_between_quotes(line, index)
                tokens.append(token)
                token = ''

            elif line[index] in self.__separators:
                if token:
                    tokens.append(token)
                token, index = line[index], index + 1
                tokens.append(token)
                token = ''

            else:
                token += line[index]
                index += 1
        if token:
            tokens.append(token)
        return tokens