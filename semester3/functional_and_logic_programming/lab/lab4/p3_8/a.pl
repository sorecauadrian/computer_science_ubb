% Generate all strings of n parentheses correctly closed.
% Eg: n=4 => (()) and ()()

% mathematical_model

% parenthesis(x) = | true, x = '(' or x = ')'
%				   | false, otherwise

% check(l1, ..., ln, c) = | true, l = [] & c = 0
%						  | check(l2, ..., ln, c + 1), l1 = '('
%						  | check(l2, ..., ln, c - 1), l1 = ')' and c > 0
%						  | false, otherwise

% allCombinations(n, result) = | result, n = 0
%							   | allCombinations(n - 1, parenthesis(x) U result), otherwise

% oneSolution(n, result) = | allCombinations(n, result), check(result, 0)



% parenthesis(X: char)
% flow model: paranthesis(i) - verifying if the argument is a parenthesis.
% flow model: parenthesis(o) - returning all the possible paranthesis ('(' and ')').
parenthesis('(').
parenthesis(')').

% check(List: list, Counter: number)
% flow model: check(i, i) - checking if a list of paranthesis is correctly closed (true|false).
check([], 0).
check(['('|RestOfList], Counter):- !, NewCounter is Counter + 1, check(RestOfList, NewCounter).
check([')'|RestOfList], Counter):- Counter > 0, NewCounter is Counter - 1, check(RestOfList, NewCounter).

% allCombinations(Length: number, PartialResult: list, Result: list)
% flow model: allCombinations(i, i, o) - returning all the combinations of paranthesis possible, one at a time.
allCombinations(0, Result, Result):- !.
allCombinations(Length, PartialResult, Result):- parenthesis(X), NewLength is Length - 1, allCombinations(NewLength, [X|PartialResult], Result). 

% oneSolution(Length: number, Result: list)
% flow model: oneSolution(i, o) - returning one solution at a time.
oneSolution(Length, Result):- allCombinations(Length, [], Result), check(Result, 0).

% allSolutions(Length: number, Result: list)
% flow model: allSolutions(i, o) - returning all the solutions.
allSolutions(N, Result):- findall(PartialResult, oneSolution(N, PartialResult), Result).