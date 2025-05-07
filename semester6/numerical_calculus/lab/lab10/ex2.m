f = @(x) (x .* exp(-x)) ./ (x.^2 + 1);
a = 0;
b = 1;

clf;
hold on;
fplot(f, [a, b], 'linewidth', 2);

format long;

exact = integral(f, a, b);
fprintf("exact: ", exact);

for n = [2 4 8 16 32 64 128 256]
    rect = composite_rectangle(f, a, b, n);
    trap = composite_trapezoidal(f, a, b, n);
    simp = composite_simpson(f, a, b, n);

    err_rect = abs(exact - rect);
    err_trap = abs(exact - trap);
    err_simp = abs(exact - simp);

    fprintf("results:\n n = %d, err_rect = %d, err_trap = %d, err_simp = %d\n", n, err_rect, err_trap, err_simp);
end

