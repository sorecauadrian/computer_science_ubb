from Domain.HashTable import HashTable


class SymbolTable:

    def __init__(self, size) -> None:
        self.__hash_table = HashTable(size)

    def add(self, key) -> tuple[int, int]:
        return self.__hash_table.add(key)

    def remove(self, key) -> None:
        self.__hash_table.remove(key)

    def contains(self, key) -> bool:
        return self.__hash_table.contains(key)

    def get_position(self, key) -> tuple[int, int]:
        return self.__hash_table.get_position(key)

    def __str__(self) -> str:
        return str(self.__hash_table)