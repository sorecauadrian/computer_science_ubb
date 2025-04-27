% probably in the final exam
nodes = [81 100 121 144];
values = [9 10 11 12];

syms x
L(x) = prod(x - [100, 121, 144])/prod(81 - [100, 121, 144]) * 9 + ...
    prod(x - [81, 121, 144])/prod(100 - [81, 121, 144]) * 10 + ...
    prod(x - [81, 100, 144])/prod(121 - [81, 100, 144]) * 11 + ...
    prod(x - [81, 121, 100])/prod(144 - [81, 121, 100]) * 12;

L(x) = expand(L(x))

approx = double(subs(L, x, 118));
true_val = sqrt(118);
error = abs(approx - true_val);

fprintf('\n=== approximation of sqrt(118) using manual lagrange formula ===\n');
fprintf('interpolated value: %.6f\n', approx);
fprintf('actual sqrt(118):   %.6f\n', true_val);
fprintf('absolute error:     %.6f\n', error);
