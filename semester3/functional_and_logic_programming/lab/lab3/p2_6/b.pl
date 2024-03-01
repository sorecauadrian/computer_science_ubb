% For a heterogeneous list, formed from integer numbers and list of numbers, write a predicate to 
% replace every sublist with the position of the maximum element from that sublist.
% [1, [2, 3], [4, 1, 4], 3, 6, [7, 10, 1, 3, 9], 5, [1, 1, 1], 7] =>
% [1, [2], [1, 3], 3, 6, [2], 5, [1, 2, 3], 7]

% mathematical model

% replace (l1, ..., ln) = | [], l = []
%						  |	l1 U replace(l2, ..., ln), l1 is a number
%						  | replaceSublist(l1, 1, maximum(l1)) U replace(l2, ..., ln), l1 is a list 

% replaceSublist(l1, ..., ln, p, maximum) = | [], l = []
%								   			| replaceSublist(l2, ..., ln, p + 1, maximum), l1 != maximum
%								   			| p U replaceSublist(l2, ..., ln, p + 1, maximum), l1 == maximum

% maximum(l1, ..., ln, result) = | result, l = []
%						 		 | maximum(l2, ..., ln, l1), l1 > result
%  						 		 | maximum(l2, ..., ln, result), l1 <= result



% list_maximum(List: list, Max: number, Result: number)
% flow model: list_maximum(i, i, o)
list_maximum([], Result, Result).
list_maximum([H|T], Max, Result):- H > Max, !, list_maximum(T, H, Result).
list_maximum([_|T], Max, Result):- list_maximum(T, Max, Result).

% maximum(List: list, Result: number)
% flow model: maximum(i, o)
maximum(List, Result):- list_maximum(List, 0, Result).



% replaceSublist(List: list, FinalList: list, P: number, Max: number)
% flow model: replaceSublist(i, o, i, i)
replaceSublist([], [], _, _).
replaceSublist([H|T], FinalList, P, Max):- H =\= Max, !, P1 is P + 1, replaceSublist(T, FinalList, P1, Max).
replaceSublist([_|T], [P|FinalList], P, Max):- P1 is P + 1, replaceSublist(T, FinalList, P1, Max).

% replaceSublistMain(List: list, Result: list)
% flow model: replaceSublistMain(i, o)
replaceSublistMain(List, Result):- maximum(List, Maximum), replaceSublist(List, Result, 1, Maximum).



% replace(List: list, FinalList: list)
% flow model: replace(i, o)
replace([], []).
replace([H|T], [H|RestOfList]):- number(H), !, replace(T, RestOfList).
replace([H|T], [Result|Rs]):- is_list(H), replaceSublistMain(H, Result), replace(T, Rs).

