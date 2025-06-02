# Short Answers

**Name:** Șorecău Adrian-Vasile
**Group:** 937

---

### Q1: Black box testing – equivalence classes

Black box testing treats the system as a “black box” and focuses on inputs and outputs without looking at internal code. Equivalence class partitioning divides input data into valid and invalid partitions where test cases are designed to cover one value from each class. This reduces the number of tests while ensuring good coverage.  
**Example**: For an input age field that accepts 18 to 65, equivalence classes might be:  

- Valid: [18–65] → e.g. 30  
- Invalid: <18 → e.g. 10, >65 → e.g. 70  

---

### Q2: White box testing – predicate coverage

White-box testing is based on the internal logic of the code. Predicate coverage ensures that each Boolean expression (predicate) in the code evaluates to both true and false at least once during testing.  
**Example**: For the predicate `(x > 5 && y < 10)`, a good test set includes:  

- x = 6, y = 9 (true)  
- x = 4, y = 11 (false)  

---

### Q3: Symbolic execution tree

Symbolic execution uses symbols (like x or y) instead of actual values to represent program inputs and explores all execution paths based on conditions. A symbolic execution tree shows how execution paths branch based on decision points.  
**Example**:  
If (x > 0) → x++; else x--  
Tree:  

- True branch: x > 0 → x = x + 1  
- False branch: x ≤ 0 → x = x – 1  

---

### Q4: Model checking – liveness properties

Model checking is a formal method used to automatically verify finite-state systems. Liveness properties ensure that “something good eventually happens.” They are different from safety properties, which ensure “nothing bad happens.”  
**Example**: In a login system, liveness means a user will eventually gain access after correct input – i.e., the system won’t stay stuck forever.
