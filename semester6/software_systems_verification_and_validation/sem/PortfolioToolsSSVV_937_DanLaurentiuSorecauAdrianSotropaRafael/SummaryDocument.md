# Summary Document

> **Title**: *PseudoSweep: A Pseudo-Tested Code Identifier*
> 
> **DOI**: [10.1109/ICSME58944.2024.00094](https://doi.org/10.1109/ICSME58944.2024.00094)
> 
> **Team members**: Dan Laurențiu, Șorecău Adrian-Vasile, Șotropa Konstantinos-Rafael

#### Approach and Motivation

Pseudo-tested code refers to statements or methods that are executed (covered) by tests yet can be deleted without causing any test failures. This situation indicates a testing deficiency: the code appears covered, but does not truly affect the program’s observable behavior under test. 

*PseudoSweep* addresses this challenge by systematically applying statement and method deletion mutation, removing specific lines of code and then re-running the test suite. If a deletion passes the tests unchanged, that code is flagged as “pseudo-tested.” 

The core motivation for developing PseudoSweep is to help developers identify and fix inadequate tests early, reducing the risk of overlooking faults and spending unnecessary resources on more expensive testing strategies.

#### Aim of the Tool and Novelty

The main goal of PseudoSweep is to pinpoint pseudo-tested statements more precisely than existing “extreme mutation” tools that only operate at the method level. By working at both the method and the statement granularity, PseudoSweep reveals tinier testing gaps.

PseudoSweep’s novelty lies in its ability to generate a mutant version of the code that surrounds suspicious statements with conditional checks. In turn, the tool selectively activates or deactivates individual lines, thereby highlighting pseudo-tested regions in a manner that is easy to locate and correct.

#### Validation

PseudoSweep was validated through an empirical study on 27 real-world Java projects, which uncovered hundreds of pseudo-tested statements that would be missed if only method-level checks were performed. 

These findings underscore the practical relevance of identifying pseudo-tested statements: many projects contained code that was nominally covered yet trivially removable without any test suite failures. By exposing these testing gaps, PseudoSweep allows developers to add any missing or improved assertions, thereby enhancing overall test quality before moving on to more resource-intensive mutation testing approaches (like PIT, MuJava or Major).
