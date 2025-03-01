# Review Form

### Document Details

**Document Title**: Lab 01 - TH

**Reviewer Name**: Șorecău Adrian-Vasile & Șotropa Rafael-Konstantinos

**Review Date**: 01.03.2025

### Requirements Phase Defects

| No. | Checked Item                           | Doc Page / Line | Comments / Improvements                                                                                                                                                     |
|:---:| -------------------------------------- | --------------- | --------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| 1   | D_01 – Incomplete Requirements         | 3.1 (FR7.0)     | The filtering functionality is described too vaguely without clear criteria or parameters.                                                                                  |
| 2   | D_02 - Missing Requirements            | 3.1 (FR4.0)     | Didn't mention the fact that "The app will offer the ability to unsubscribe from these notifications"                                                                       |
| 3   | D_02 - Missing Requirements            | 3.1 (FR2.0)     | Didn't mention the fact that "any delays due to delays in delivery of a theme will be automatically calculated, showing the student's maximum mark on the topic"            |
| 4   | D_01 - Incomplete Requirements         | 3.1 (FR1.0)     | There is an inconsistency in the CRUD description: while FR1.0 focuses on student operations, section 4 also mention deleting assignments and grades without clear details. |
| 5   | D_06 – Inadequate User Needs Statement | 3.2             | The user interface and usability requirements are very generic (e.g., "user friendly", "easy to learn") and do not offer concrete guidelines or measurable criteria.        |

### Design Phase Defects

| No. | Checked Item                                  | Doc Page / Line | Comments / Improvements                                                                                                                                                                                                                                                                |
|:---:| --------------------------------------------- | --------------- | -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| 1   | D_03 – Insufficient Error Handling Strategy   | 3.1             | All fields being specified is not enough for creating a student. Detailed validation rules and user feedback mechanisms are missing.                                                                                                                                                   |
| 2   | D_02 – Incomplete Coverage of Requirements    | 1               | The requirements are only focusing on CRUD operations for the student entity, while the functionalities for the laboratory themes and grades are omited.                                                                                                                               |
| 3   | D_04 - Design patterns                        | 5.3             | Although GRASP principles are mentioned, the application of established patterns (e.g., MVC, Observer) is not demonstrated.                                                                                                                                                            |
| 4   | D_05 - Clear name and description for classes | 4.1             | The class description is missing from the analysis document, only the name and their attributes are mentioned. In order to have a clearly view of their role a short description might be useful.                                                                                      |
| 5   | D_02 – Incomplete Coverage of Requirements    | 3               | The requirements are also suggesting adding use cases for listing the students, listing the assignments, listing the grades, adding a new assignment, adding a new grade for a student to an assignment, deleting an existing assignment and extending the deadline for an assignment. |

### Coding Phase Defects

| No. | Checked Item                                | Doc Page / Line                       | Comments / Improvements                                                                                                                                                                                                                                             |
|:---:| ------------------------------------------- | ------------------------------------- | ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| 1   | D_06 - Confusion in using the parameters    | StudentValidator.java / Line 12       | Without looking at the code the user won't know the group of the student has to be between 111 and 937                                                                                                                                                              |
| 2   | D_02 - Branching is erroneous               | TemaValidator.java / Line 12, Line 15 | It would be better to check separately if the startLine is greater than the deadLine and throw a different validation exception for that case instead of telling the user that the deadline and startline are invalid.                                              |
| 3   | D_01 - Decision logic is erroneous          | Service.java / Line 59 - 63           | In the saveNota method, the penalty calculation subtracts 2.5*(predata - deadline). When an assignment is submitted before the deadline (i.e. predata < deadline), this calculation increases the grade instead of leaving it unchanged or applying a zero penalty. |
| 4   | D_05 - Subprogram  invocations are violated | Service.java / Line 32 - 110          | The return conventions differ between similar operations: for example, saveStudent returns 1 on success, whereas updateStudent returns 1 on failure. This inconsistency in subprogram return values can cause confusion during integration and error handling.      |
| 5   | D_02 – Branching is Erroneous               | Service.java / Line 126               | The condition if (currentWeek <= tema.getDeadline()) in extendDeadline does not handle cases when the current week is past the deadline, resulting in a silent failure without any feedback or alternative flow for the user.                                       |

### Effort to Review Document (Hours): 4
