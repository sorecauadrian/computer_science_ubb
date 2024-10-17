from hash_table import HashTable

class SymbolTable:

    def __init__(self, size) -> None:
        self.__hash_table = HashTable(size)

    def add(self, key) -> None:
        self.__hash_table.add(key)

    def contains(self, key) -> bool:
        return self.__hash_table.contains(key)

    def __str__(self) -> str:
        return str(self.__hash_table)