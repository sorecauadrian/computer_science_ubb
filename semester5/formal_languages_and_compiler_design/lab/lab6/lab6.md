```python
def expand(self):
    # print("---expand---")
    self.write_in_out("---expand---")
    non_terminal = self.input.pop(0)
    self.working.append((non_terminal, 0))
    # self.input.append(self.grammar.get_productions_for_non_terminal(non_terminal)[0])
    new_production = self.grammar.get_productions_for_non_terminal(non_terminal)[0]
    self.input = new_production + self.input

def advance(self):
    # print("---advance---")
    self.write_in_out("---advance---")
    self.working.append(self.input.pop(0))
    self.index += 1

def momentary_insuccess(self):
    # print("---momentary insuccess---")
    self.write_in_out("---momentary insuccess---")
    self.state = "b"

def back(self):
    # print("---back---")
    self.write_in_out("---back---")
    new_thing = self.working.pop()
    self.input = [new_thing] + self.input
    self.index -= 1

def success(self):
    # print("---success---")
    self.write_in_out("---success---")
    self.state = "f"

def another_try(self):
    # print("---another try---")
    self.write_in_out("---another try---")
    last_nt = self.working.pop()  # (nt, production_nr)
    if last_nt[1] + 1 < len(self.grammar.get_productions_for_non_terminal(last_nt[0])):
        self.state = "q"
        # put working next production for the nt
        new_tupple = (last_nt[0], last_nt[1] + 1)
        self.working.append(new_tupple)
        # change production on top input
        len_last_production = len(self.grammar.get_productions_for_non_terminal(last_nt[0])[last_nt[1]])
        # delete last production from input
        self.input = self.input[len_last_production:]  # maybe len -1
        # put new production in input
        new_production = self.grammar.get_productions_for_non_terminal(last_nt[0])[last_nt[1] + 1]
        self.input = new_production + self.input
    elif self.index == 1 and last_nt[0] == self.grammar.get_start_symbol():
        self.state = "e"
    else:
        # change production on top input
        len_last_production = len(self.grammar.get_productions_for_non_terminal(last_nt[0])[last_nt[1]])
        # delete last production from input
        self.input = self.input[len_last_production:]
        self.input = [last_nt[0]] + self.input
```