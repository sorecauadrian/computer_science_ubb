% a. Substitute all occurrences of an element of a list with all the elements of another list. 
% Eg. subst([1,2,1,3,1,4],1,[10,11],X) produces X=[10,11,2,10,11,3,10,11,4].
% b. For a heterogeneous list, formed from integer numbers and list of numbers, replace in every sublist all 
% occurrences of the first element from sublist it a new given list.
% Eg.: [1, [4, 1, 4], 3, 6, [7, 10, 1, 3, 9], 5, [1, 1, 1], 7] si [11, 11] =>
% [1, [11, 11, 1, 11, 11], 3, 6, [11, 11, 10, 1, 3, 9], 5, [11 11 11 11 11 11], 7]

% substitute(List: list, Element: number, SubstituteList: list, Result: list)
% (i, i, i, o)
substitute([], _, _, []).
substitute([ElementToVerify|RestOfList], Element, SubstituteList, Result):- ElementToVerify =:= Element, !, concatenate(SubstituteList, Rest, Result), substitute(RestOfList, Element, SubstituteList, Rest).
substitute([ElementToVerify|RestOfList], Element, SubstituteList, Result):- Result = [ElementToVerify|Rest], substitute(RestOfList, Element, SubstituteList, Rest).
    
% concatenate(FirstList, SecondList, Result)
% (i, i, o)
concatenate([], SecondList, SecondList).
concatenate([Element|RestOfFirstList], SecondList, [Element|Result]):- concatenate(RestOfFirstList, SecondList, Result).

% first_element(List: list, Result: number)
% (i, o)
first_element([], 0).
first_element([H|_], H).

% heterogeneous_list(List: list, SubstituteList: list, Result: list)
% (i, i, o)
heterogeneous_list([], _, []).
heterogeneous_list([Element|RestOfList], SubstituteList, [Element|Result]):- number(Element), !, heterogeneous_list(RestOfList, SubstituteList, Result).
heterogeneous_list([Element|RestOfList], SubstituteList, [ResultedList|RestOfResult]):- is_list(Element), first_element(Element, FirstElement), substitute(Element, FirstElement, SubstituteList, ResultedList), heterogeneous_list(RestOfList, SubstituteList, RestOfResult).
