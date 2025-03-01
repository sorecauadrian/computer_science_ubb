# Feature Tour Testing Assignment

### Objective

Perform a quick feature tour test to identify potential defects in the app.

### Feature Tour Testing Table

| Step | Action Taken                                              | Expected Behavior                                 | Actual Behavior                                                                               | Test Result (Pass / Fail) | Issues & Notes                         |
|:----:| --------------------------------------------------------- | ------------------------------------------------- | --------------------------------------------------------------------------------------------- |:-------------------------:|:--------------------------------------:|
| 1    | Start the CLI/App                                         | The app starts and displays the menu              | The app starts and displays the menu, but some error messages are displayed as well           | Pass                      | Error messages shouldn't be displayed  |
| 2    | Add a valid student                                       | The student is added to the list of students      | The student is added to the list of students                                                  | Pass                      | N/A                                    |
| 3    | Add a student from an inexistent group (e.g. 1)           | The student is not added to the list of students  | The student is not added to the list of students, but a success message is displayed as well  | Pass                      | Success message shouldn't be displayed |
| 4    | Add a valid homework                                      | The homework is added to the list of homework     | The homework is added to the list of homework                                                 | Pass                      | N/A                                    |
| 5    | Add a homework with a startline greater than the deadline | The homework is not added to the list of homework | The homework is not added to the list of homework, but a success message is displayed as well | Pass                      | Success message shouldn't be displayed |
