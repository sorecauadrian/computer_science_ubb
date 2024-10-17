class HashTable:

    def __init__(self, size):
        self.__items = [[] for _ in range(size)]
        self.__size = size

    def hash(self, key) -> int:
        # modular hashing, h(k)= k mod size
        return sum(ord(character) for character in key) % self.__size

    def add(self, key) -> None:
        if not self.contains(key):
            self.__items[self.hash(key)].append(key)

    def contains(self, key) -> bool:
        return key in self.__items[self.hash(key)]

    def __str__(self) -> str:
        result = ""
        for i in range(self.__size):
            result = result + str(i) + "->" + str(self.__items[i]) + "\n"
        return result