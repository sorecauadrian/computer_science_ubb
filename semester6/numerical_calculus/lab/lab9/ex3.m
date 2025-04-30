x_data = [0.5 1.5 2 3 3.5 4.5 5 6 7 8];
y_data = [5 5.8 5.8 6.8 6.9 7.6 7.8 8.2 9.2 9.9];

% a
x_fit = linspace(min(x_data), max(x_data), 200);

[p, stats] = polyfit(x_data, y_data, 3);
y_fit = polyval(p, x_fit);

% b
error_norm = stats.normr;

% c
x_est = 4;
y_est = polyval(p, x_est);

fprintf('estimated value at x = %.1f: %.4f\n', x_est, y_est);
fprintf('norm of residuals (approximation error): %.4f\n', error_norm);

% d
clf;
hold on;
scatter(x_data, y_data);
plot(x_fit, y_fit);
plot(x_est, y_est);

xlabel('x'); ylabel('f(x)');
legend('data', 'fit', 'estimate at x = 4');
grid on;

