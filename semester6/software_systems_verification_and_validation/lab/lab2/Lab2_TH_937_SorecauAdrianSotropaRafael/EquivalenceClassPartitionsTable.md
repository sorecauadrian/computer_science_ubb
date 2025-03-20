# Equivalence Class Partitions Table

| Equivalence Class (EC)    | Example Inputs                                  | Expected Output            | Notes                                         |
| ------------------------- | ----------------------------------------------- | -------------------------- | --------------------------------------------- |
| E1: Valid student         | id = "1", name = "Șotropa Rafael", group = 937  | Student saved successfully | All fields meet the validation rules.         |
| E2: Empty name            | id = "1", name = "", group = 937                | Exception thrown           | Name is mandatory and cannot be empty or null |
| E3: Negative group number | id = "1", name = "Șotropa Rafael", group = -937 | Exception thrown           | The group number must be a positive number    |
