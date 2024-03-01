% Define a predicate to test if a list of an integer elements has a "valley" aspect (a set has 
% a 'valley' aspect if elements decreases up to a certain point, and then increases).
% eg: 10 8 6 9 11 13 – has a “valley” aspect.

is_valley([H1,H2|T]) :-H1 > H2, valley_dec([H1,H2|T]).

valley_dec([H1,H2|T]) :-H1 > H2, valley_dec([H2|T]).
valley_dec([H1,H2|T]) :-H1 < H2, valley_inc([H1,H2|T]).

valley_inc([_]).
valley_inc([H1,H2|T]) :-H1 < H2, valley_inc([H2|T]).