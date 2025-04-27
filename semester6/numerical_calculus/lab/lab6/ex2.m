x_nodes = [1980 1990 2000 2010 2020];
y_vals = [4451 5287 6090 6970 7821];

l = @(x) lagrange(x_nodes, y_vals, x);

x_interp = [2005, 2015];
actual = [6474, 7405];

approx = l(x_interp);
rel_errors = abs((approx - actual) ./ actual);

fprintf('\nyear\tapprox.\t\tactual\t\trel. error (%%)\n');
for i = 1:length(x_interp)
  fprintf('%d\t%.2f\t\t%d\t\t%.4f%%\n', ...
          x_interp(i), approx(i), actual(i), rel_errors(i) * 100);
end

xx = linspace(1980, 2020, 1000);
yy = l(xx);

figure;
plot(xx, yy, 'r-', 'LineWidth', 1.5); hold on;
plot(x_nodes, y_vals, 'ko', 'MarkerSize', 8, 'MarkerFaceColor', 'k');
plot(x_interp, approx, 'bx', 'MarkerSize', 12, 'LineWidth', 2);
plot(x_interp, actual, 'g+', 'MarkerSize', 12, 'LineWidth', 2);

legend('interpolated polynomial', 'data points', ...
       'interpolated values', 'actual values', 'Location', 'NorthWest');
title('world population interpolation using lagrange polynomial');
xlabel('year');
ylabel('population (millions)');
grid on;

