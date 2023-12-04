% a. Sort a list with keeping double values in resulted list. E.g.: [4 2 6 2 3 4] --> [2 2 3 4 4 6]
% b. For a heterogeneous list, formed from integer numbers and list of numbers, write a predicate to sort every 
% sublist, keeping the doubles.
% Eg.: [1, 2, [4, 1, 4], 3, 6, [7, 10, 1, 3, 9], 5, [1, 1, 1], 7] =>
% [1, 2, [1, 4, 4], 3, 6, [1, 3, 7, 9, 10], 5, [1, 1, 1], 7].


% a. mathematical model

% insertion_sort(l1, ..., ln) = | [], n == 0
%								| result = insertion_sort(l2, ..., ln), insert_into_sorted_list(l1, result)

% insert_into_sorted_list(e, l1, ..., ln) = | e, n == 0
%											| e U l1, ..., ln, e <= l1
%											| l1 U insert_into_sorted_list(e, l2, ..., ln), e > l1

% insert_into_sorted_list(Number: number, List: list, Result: list)
% (i, i, o)
insert_into_sorted_list(Number, [], [Number]).
insert_into_sorted_list(Number, [FirstElement|RestOfList], [Number, FirstElement|RestOfList]):- Number =< FirstElement.
insert_into_sorted_list(Number, [FirstElement|RestOfList], [FirstElement|RestOfSortedList]):- Number > FirstElement, insert_into_sorted_list(Number, RestOfList, RestOfSortedList).

% insertion_sort(List: list, Result: list)
% (i, o)
insertion_sort([], []).
insertion_sort([X|RestOfList], SortedList):- insertion_sort(RestOfList, PartiallySortedList), insert_into_sorted_list(X, PartiallySortedList, SortedList).

% b. mathematical model

% heterogeneous_list(l1, ..., ln) = | [], n == 0
%									| l1 U heterogeneous_list(l2, ..., ln), l1 is a number
%									| sort_and_remove_duplicates(l1) U heterogeneous_list(l2, ..., ln), l1 is a list

% heterogeneous_list(List: list, Result: list)
% (i, o)
heterogeneous_list([], []).
heterogeneous_list([Number|RestOfList], [Number|RestOfResult]):- number(Number), heterogeneous_list(RestOfList, RestOfResult).
heterogeneous_list([List|RestOfList], [SortedAndDuplicatesRemovedList|RestOfResult]):- is_list(List), insertion_sort(List, SortedAndDuplicatesRemovedList), heterogeneous_list(RestOfList, RestOfResult).
