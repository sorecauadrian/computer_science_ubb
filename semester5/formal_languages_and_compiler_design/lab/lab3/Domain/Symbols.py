def read_file() -> tuple[list, list, list]:
    separators = []
    operators = []
    reserved_words = []
    number_of_separators = 11
    number_of_operators = 14
    number_of_reserved_words = 13

    with open('Domain/Tokens.in', 'r') as tokens_file:
        for i in range(number_of_separators):
            separator = tokens_file.readline().strip()
            separator = " " if separator == "<space>" else separator
            separators.append(separator)

        for i in range(number_of_operators):
            operators.append(tokens_file.readline().strip())

        for i in range(number_of_reserved_words):
            reserved_words.append(tokens_file.readline().strip())

    return separators, operators, reserved_words