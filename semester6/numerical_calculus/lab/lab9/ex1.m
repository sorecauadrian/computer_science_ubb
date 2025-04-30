f = @(x) (x + 1) ./ (3*x.^2 + 2*x + 1);
df = @(x) ((1 .* (3*x.^2 + 2*x + 1)) - (x + 1) .* (6*x + 2)) ./ (3*x.^2 + 2*x + 1).^2;

x = linspace(-2, 4, 7);
X = linspace(-2, 4, 500);

Y = f(X);
Y_Lagrange = lagrange(x, f(x), X);
[Y_Hermite, ~] = hermiteInterpolation(x, f(x), df(x), X);
Y_Spline = spline(x, f(x), X);

hold on;
plot(X, Y);
plot(X, Y_Lagrange);
plot(X, Y_Hermite);
plot(X, Y_Spline);
plot(x, f(x), '*');
legend('f(x)', 'lagrange', 'hermite', 'spline', 'nodes');
xlabel('x'); ylabel('f(x)');
