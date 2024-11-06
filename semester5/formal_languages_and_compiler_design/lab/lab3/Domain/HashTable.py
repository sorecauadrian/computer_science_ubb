from collections import deque


class HashTable:

    def __init__(self, size):
        self.__items = [deque() for _ in range(size)]
        self.__size = size

    def hash(self, key) -> int:
        # modular hashing, h(k)= k mod size

        sum = 0
        for character in key:
            sum += ord(character) - ord('0')
        return sum % self.__size

    def add(self, key) -> tuple[int, int]:
        if self.contains(key):
            return self.get_position(key)
        self.__items[self.hash(key)].append(key)
        return self.get_position(key)

    def remove(self, key) -> None:
        self.__items[self.hash(key)].remove(key)

    def contains(self, key) -> bool:
        return key in self.__items[self.hash(key)]

    def get_position(self, key) -> tuple[int, int]:
        list_position = self.hash(key)
        deque_position = 0
        for item in self.__items[list_position]:
            if item != key:
                deque_position += 1
            else:
                break
        return list_position, deque_position

    def __str__(self) -> str:
        result = "Symbol Table:\n"
        for i in range(self.__size):
            result = result + str(i) + " -> " + str(self.__items[i]) + "\n"
        return result