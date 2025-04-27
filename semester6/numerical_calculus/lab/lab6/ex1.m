% a)
fprintf("\n=== (a) lagrange interpolation L9f ===\n");

f = @(x) (x + 1) ./ (3 * x.^2 + 2 * x + 1);
nodes = linspace(-2, 4, 10);
values = f(nodes);

L9f = @(xq) lagrange(nodes, values, xq);

fprintf("L9f constructed using 10 nodes in [-2, 4].\n");

sample_x = linspace(-2, 4, 5);
fprintf(" x\tf(x)\tL9f(x)\n");
for i = 1:length(sample_x)
  fx = f(sample_x(i));
  lx = L9f(sample_x(i));
  fprintf("%6.2f\t%8.5f%8.5f\n", sample_x(i), fx, lx);
end

% b)
fprintf("\n=== (b) Plotting f(x), L9f(x), and nodes ===\n");

figure(1);
clf;
hold on;
fplot(f, [-2, 4], 'b', 'LineWidth', 1.5);
x_dense = linspace(-2, 4, 1000);
L_vals = L9f(x_dense);
plot(x_dense, L_vals, '--r', 'LineWidth', 1.5);
plot(nodes, values, 'ko', 'MarkerSize', 8, 'MarkerFaceColor', 'k');
legend('f(x)', 'L_9 f(x)', 'interpolation nodes', 'location', 'best');
title('(b)');
xlabel('x'); ylabel('y');
grid on;
hold off;

% c)
fprintf("\n=== (c) error analysis |f(x) - L9f(x)| ===\n");

x_dense = linspace(-2, 4, 1000);
f_vals = f(x_dense);
L_vals = L9f(x_dense);
errors = abs(f_vals - L_vals);

figure(2);
plot(x_dense, errors, 'm', 'LineWidth', 1.5);
title('(c)');
xlabel('x'); ylabel('error');
grid on;

max_error = max(errors);
fprintf("maximum interpolation error on [-2, 4]: %.8f\n", max_error);

% d)
fprintf("\n=== (d) approximate f(0.5) and compute error ===\n");

x0 = 0.5;
approx = L9f(x0);
exact = f(x0);
error_at_x0 = abs(exact - approx);

fprintf("approximation of f(0.5) using L_9f: %.8f\n", approx);
fprintf("exact value of f(0.5): %.8f\n", exact);
fprintf("error at x = 0.5: %.8f\n", error_at_x0);

