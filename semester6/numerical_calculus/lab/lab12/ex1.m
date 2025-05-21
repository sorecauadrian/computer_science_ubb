f = @(x) x - exp(-x);
df = @(x) 1 + exp(-x);
tol = 1e-10;
x = linspace(0, 1, 100);

format long;
[root_bis, it_bis] = bisection(f, 0, 1, tol)
[root_false, it_false] = false_position(f, 0, 1, tol)
[root_sec, it_sec] = secant(f, 0, 1, tol)
[root_new, it_new] = newton(f, df, 1, tol)
root = fsolve(f, 0.5);

hold on;
plot(x, f(x), "g--");
plot(root, f(root));

fprintf('root: %d\n', root);
fprintf('bisection error: %d (in %d iterations)\n', abs(root_bis - root), it_bis);
fprintf('false position error: %d (in %d iterations)\n', abs(root_false - root), it_false);
fprintf('secant error: %d (in %d iterations)\n', abs(root_sec - root), it_sec);
fprintf('newton error: %d (in %d iterations)\n', abs(root_new - root), it_new);
