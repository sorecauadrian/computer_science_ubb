# Program Documentation

## Overview

This program implements a custom `HashTable` structure, a `SymbolTable` for efficient symbol storage, and a `Scanner` for lexical analysis. It is designed to process programming language tokens, manage symbol positions, and support internal representation of tokens within a program.

## Components

The program is divided into the following main components:

1. **HashTable**: Provides a custom hash table implementation with modular hashing.
2. **SymbolTable**: A table that uses the hash table for managing and retrieving symbols.
3. **ProgramInternalForm (PIF)**: Manages the internal representation of tokens and their associated positions.
4. **Scanner**: A lexical analyzer that tokenizes lines of code into identifiers, constants, operators, and separators.

Each of these components is described in detail below.

------

### 1. HashTable

The `HashTable` class is a data structure that implements modular hashing with chaining to handle collisions. Keys are stored in deques (double-ended queues) within each bucket. The table size is fixed upon initialization, and hashing is performed based on the ASCII values of characters in the key.

- **Attributes**:
  - `__items`: A list of deques, each representing a bucket for storing hashed keys.
  - `__size`: The fixed size of the hash table.
- **Methods**:
  - **`hash(key: str) -> int`**: Computes a hash for the given key based on modular hashing.
  - **`add(key: str) -> tuple[int, int]`**: Adds a key to the table if it does not already exist.
  - **`remove(key: str) -> None`**: Removes the specified key from the table.
  - **`contains(key: str) -> bool`**: Checks if a key is present in the table.
  - **`get_position(key: str) -> tuple[int, int]`**: Returns the bucket and position within the deque where the key is stored.
  - **`__str__() -> str`**: Provides a formatted string representation of the hash table for easy visualization.

### 2. SymbolTable

The `SymbolTable` class is a wrapper around the `HashTable`, specifically tailored for managing symbols in a programming language context. It supports operations such as adding, removing, checking for existence, and locating the position of symbols.

- **Attributes**:
  - `__hash_table`: An instance of `HashTable` that stores the symbols.
- **Methods**:
  - **`add(key: str) -> tuple[int, int]`**: Adds a symbol to the table, returning its position.
  - **`remove(key: str) -> None`**: Removes a symbol from the table.
  - **`contains(key: str) -> bool`**: Checks if a symbol exists in the table.
  - **`get_position(key: str) -> tuple[int, int]`**: Retrieves the position of a symbol in the table.
  - **`__str__() -> str`**: Provides a formatted string representation of the symbol table.

### 3. ProgramInternalForm (PIF)

The `ProgramInternalForm` class is responsible for maintaining a record of tokens and their corresponding positions. Each token is stored as a tuple consisting of the token itself and its position in the form of a `(token, pos)` pair.

- **Attributes**:
  - `__content`: A list of tuples, where each tuple contains a token and its position.
- **Methods**:
  - **`add(token: str, pos: tuple[int, int]) -> None`**: Adds a token and its position to the internal form.
  - **`__str__() -> str`**: Generates a string representation of the program internal form, displaying each token and its associated position.

### 4. Scanner

The `Scanner` class performs lexical analysis, dividing a line of code into individual tokens, such as identifiers, constants, operators, and separators. The scanner uses regular expressions to identify token types and handles multi-character operators and quoted strings.

- **Attributes**:
  - `__separators`: List of separator symbols.
  - `__operators`: List of operator symbols.
  - `cases`: List of special operator combinations for specific handling.
- **Methods**:
  - **`is_identifier(token: str) -> bool`**: Checks if a token is a valid identifier according to a specified pattern.
  - **`is_constant(token: str) -> bool`**: Determines if a token is a numeric or character constant.
  - **`is_part_of_an_operator(char: str) -> bool`**: Checks if a character is part of an operator.
  - **`get_string_between_quotes(line: str, index: int) -> tuple[str, int]`**: Extracts a string literal enclosed in single quotes from a line of code.
  - **`get_operator_token(line: str, index: int) -> tuple[str, int]`**: Extracts an operator token from a line, handling multi-character operators.
  - **`tokenize(line: str) -> list[str]`**: Tokenizes a line of code, returning a list of individual tokens.

