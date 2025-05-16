f = @(x) 1 ./ (2 + sin(x));
a = 0;
b = pi / 2;

format long
exact = pi * sqrt(3) / 9;

[approx, i] = romberg_rec(f, a, b, 1e-5, 100);
err = abs(approx - exact);

disp(['exact value      = ', num2str(exact, 16)])
disp(['romberg approx   = ', num2str(approx, 16)])
disp(['absolute error   = ', num2str(err)])
disp(['iterations used  = ', num2str(i)])

