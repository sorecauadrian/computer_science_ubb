from symbol_table import SymbolTable

symbol_table = SymbolTable(8)

symbol_table.add('a')
symbol_table.add('b')
symbol_table.add('1')

#print(symbol_table)

assert (symbol_table.contains('a') is True)
assert (symbol_table.contains('b') is True)
assert (symbol_table.contains('1') is True) 
assert (symbol_table.contains('c') is False)

print("All tests passing")