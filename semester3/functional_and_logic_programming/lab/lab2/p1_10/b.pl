% Calculate the alternate sum of list’s elements (l1 - l2 + l3 ...).

% implementation using 2 elements and adding the first one and substracting the second one
alternate_sum([], 0).
alternate_sum([H], H).
alternate_sum([H1,H2|T], R):- alternate_sum(T, R1), R is R1 + H1 - H2.

% implementation using a variable to know wheater we should add or substract the next element.
alternate_sum_basic([], 0, _).
alternate_sum_basic([H|T], R, S):- S is 1, alternate_sum_basic(T, R1, -1), R is R1 + H.
alternate_sum_basic([H|T], R, S):- S is -1, alternate_sum_basic(T, R1, 1), R is R1 - H.
alternate_sum_basic_main([H|T], R):- alternate_sum_basic([H|T], R, 1).

% implementation using collectors - the most efficient one.
alternate_sum_collector([], S, S).
alternate_sum_collector([A], R, S):- Saux is S + A, alternate_sum_collector([], R, Saux).
alternate_sum_collector([H1,H2|T], R, S):- Saux is S + H1 - H2, alternate_sum_collector(T, R, Saux).
alternate_sum_collector_main([H|T], R):- alternate_sum_collector([H|T], R, 0).