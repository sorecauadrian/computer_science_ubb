warning('off','all');
format short;

x_values = [-2 -1 0 1 2 3 4];
f_values = [-5 1 1 1 7 25 60];

% a
disp('a) divided differences table:');
disp(dividedDifferences(x_values, f_values));

% b
disp('b) forward differences table:');
disp(forwardDifferences(f_values));

% c
disp('c) backward differences table:');
disp(backwardDifferences(f_values));
