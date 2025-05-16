f = @(x) 4 ./ (1 + x .^ 2);
a = 0;
b = 1;

exact = integral(f, a, b);
fprintf('integral result: %.15f\n', exact);

[approx_romberg, i_romberg] = romberg_rec(f, a, b, 1e-6, 100);
fprintf('romberg result: %.15f (in %d iterations)\n', approx_romberg, i_romberg);

g = @(t) f((t + 1) / 2);
[gauss_result, nodes, weights] = Gaussquad(g, 5, 1);
gauss_result
