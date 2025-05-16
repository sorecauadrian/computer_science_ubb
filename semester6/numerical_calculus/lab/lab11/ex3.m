a = 0;
b = pi / 4;
f = @(x) exp(cos(x));
g = @(t) f((b - a)/2 * t + (a + b)/2);

exact = integral(f, a, b);

for n = 1:5
    I = Gaussquad(g, n, 1) * (b - a)/2;
    err = abs(I - exact);
    fprintf('n = %d, I ≈ %.10f, err = %.1e\n', n, I, err);
end

