% Determine the product of a number represented as digits in a list to a given digit. 
% Eg.: [1 9 3 5 9 9] * 2 => [3 8 7 1 9 8]

% mathematical model

% product([l1, ..., ln], digit) = reverse([l1, ..., ln]), multiply_main([l1, ..., ln], digit), reverse([l1, ..., ln])

% multiply_main([l1, ..., ln], digit) = multiply([l1, ..., ln], digit, 0, [])

% multiply([l1, ..., ln], digit, carry, [r1, ..., rn]) =| [r1, ..., rn], carry = 0 and l = []
%														| carry U [r1, ..., rn], l = []
%														| carry = (l1 * digit) // 10, multiply([l2, ..., ln], digit, carry, [(l1 * digit) % 10, r1, ..., rn]), otherwise 

% reverse([l1, ..., ln]) = | [], l = []
% 						   | reverse([l2, ..., ln]) U l1, otherwise


% reverse(List: list, Result: list, CollectorResult: list)
% flow model: reverse(i, i, o)
reverse([], Result, Result).
reverse([H|T], ResultedList, Result):- reverse(T, [H|ResultedList], Result).

% multiply(List: list, Digit: number, Carry: number, Result: list)
% flow model: multiply(i, i, i, o)
multiply([], _, 0, []):- !.
multiply([], _, Carry, [Carry]).
multiply([H|T], Digit, Carry, [ResultedDigit|Result]):- MultiplicationResult is H * Digit + Carry, ResultedDigit is MultiplicationResult mod 10, Quotient is MultiplicationResult div 10, multiply(T, Digit, Quotient, Result). 

% multiplyMain(List: list, Digit: number, Result: list)
% flow model: multiplyMain(i, i, o)
multiplyMain(List, Digit, Result):- multiply(List, Digit, 0, Result).

% product(List: list, Digit: number, Result: list)
% flow model: product(i, i, o)
product(List, Digit, Result):- reverse(List, [], ReversedList), multiplyMain(ReversedList, Digit, MultipliedReversedList), reverse(MultipliedReversedList, [], Result).