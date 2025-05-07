f = @(x) 1 ./ x;
a = 1;
b = 2;

clf;
hold on;
format long;
fplot(f, [a, b], 'linewidth', 2);
axis([a, b 0 1]);

% exam problem: find the number of rectangles such that the error is less than 1e-10
% we use formula 3.5 from the course

syms n positive
exact = integral(f, a, b)

% error formula for rectangle
Rn = (b - a)^3 / (24 * n^2) * diff(1 / x, 2);
% worst case is by substituting x by 1
worst_Rn = subs(Rn, x, 1);
% we're taking the smallest integer bigger or equal to the number of rectangles required
N = ceil(double(solve(worst_Rn == sym(10)^-10)));
approx = composite_rectangle(f, a, b, N)
error = abs(exact - approx)

% error formula for trapezoid
Rn = (b - a)^3 / (12 * n^2) * diff(1 / x, 2);
worst_Rn = subs(Rn, x, 1);
N = ceil(double(solve(worst_Rn == sym(10)^-10)));
approx_trapezoidal = composite_trapezoidal(f, a, b, N)
error_trapezoidal = abs(exact - approx_trapezoidal)

% error formula for simpson
Rn = (b - a)^5 / (2880 * n^4) * diff(1 / x, 4);
worst_Rn = subs(Rn, x, 1);
N = ceil(double(solve(worst_Rn == sym(10)^-10)));
approx_simpson = composite_simpson(f, a, b, N)
error_simposon = abs(exact - approx_simpson)
