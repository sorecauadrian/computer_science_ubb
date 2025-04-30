f = @(x) x .* sin(pi .* x);
df = @(x) sin(pi .* x) + pi .* x .* cos(pi .* x);

x = [-1, -1/2, 0, 1/2, 1, 3/2];
X = linspace(-1, 3/2, 100);

% a
Y = f(X);
Y_Spline = spline(x, f(x), X);

X_HermitePiecewise = [];
Y_HermitePiecewise = [];
for i = 1 : length(x) - 1
  nodes = [x(i) x(i + 1)];
  X_Piecewise = linspace(x(i), x(i + 1), 100);
  [Y_Piecewise, ~] = hermiteInterpolation(nodes, f(nodes), df(nodes), X_Piecewise);
  X_HermitePiecewise = [X_HermitePiecewise X_Piecewise];
  Y_HermitePiecewise = [Y_HermitePiecewise Y_Piecewise];
endfor

Y_Pchip = pchip(x, f(x), X);

% b
clf;
hold on;
plot(X, Y);
plot(X, Y_Spline);
plot(X_HermitePiecewise, Y_HermitePiecewise);
plot(X, Y_Pchip);
plot(x, f(x), '*');

legend('f(x)', 'spline', 'hermite piecewise', 'pchip', 'nodes');
xlabel('x'); ylabel('f(x)');
