format long;

x = [1000 : 10 : 1050];
f = [3.0000000 3.0043214 3.0086002 3.0128372 3.0170333 3.0211893];

X = [1001 : 1009];

N = @(X) newton(x, f, X);
F = @(X) log10(X);

approx_vals = N(X);
exact_vals = F(X);
errors = abs(approx_vals - exact_vals);

fprintf("\n--- lagrange interpolation of log10(x) using newton's method ---\n");
fprintf("  x\t  interpolated\t  true log10(x)\t  abs error\n");
for i = 1:length(X)
  fprintf("%4d\t%12.7f\t%12.7f\t%10.2e\n", X(i), approx_vals(i), exact_vals(i), errors(i));
end

clf;
hold on;
plot(x, f, 'ko', 'MarkerFaceColor', 'k');
fplot(N, [1000, 1050], 'b', 'LineWidth', 1.5);
fplot(F, [1000, 1050], 'r--', 'LineWidth', 1.5);
legend("data points", "interpolated L(x)", "log_{10}(x)", "Location", "NorthWest");
title("interpolation of log_{10}(x) using newton/lagrange polynomial");
xlabel("x");
ylabel("log_{10}(x)");
grid on;

