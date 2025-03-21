# Equivalence Class Partitions Table

#### Id input

| Equivalence Class (EC)                  | Id                            | Expected Output  | Notes                              |
| --------------------------------------- | ----------------------------- | ---------------- | ---------------------------------- |
| E1: Positive number id                  | "1", "2", ...                 | Success          | -                                  |
| E2: Negative number id                  | "-1", "-2", ...               | Exception thrown | Id should not be a negative number |
| E3: Null or empty id                    | "", null                      | Exception thrown | Id field is mandatory              |
| E4: Id starting with 0                  | "01", "001", ...              | Exception thrown | Id should not start with "0"       |
| E5: Id containg anything except numbers | "a", "a0", "a1%", "b20c", ... | Exception thrown | Id should be a number              |

#### Name input

| Equivalence Class (EC) | Name                                           | Expected Output  | Notes                   |
| ---------------------- | ---------------------------------------------- | ---------------- | ----------------------- |
| E6: Null or empty name | "", null                                       | Exception thrown | Name field is mandatory |
| E7: Non-empty name     | "Șotropa Rafael", "Șorecău Adrian-Vasile", ... | Success          | -                       |

#### Group input

| Equivalence Class (EC) | Group        | Expected Output  | Notes                                 |
| ---------------------- | ------------ | ---------------- | ------------------------------------- |
| E8: Negative group     | -1, -2, ...  | Exception thrown | Group should not be a negative number |
| E9: Positive group     | 0, 1, 2, ... | Success          | -                                     |
| E10: Null group        | null         | Exception thrown | Group field is mandatory              |
