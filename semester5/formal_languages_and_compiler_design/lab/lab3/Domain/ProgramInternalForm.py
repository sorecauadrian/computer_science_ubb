class ProgramInternalForm:
    def __init__(self):
        self.__content = []

    def add(self, token, pos) -> None:
        self.__content.append((token, pos))

    def __str__(self) -> str:
        result = ""
        for pair in self.__content:
            result += pair[0] + " -> " + str(pair[1]) + "\n"
        return result