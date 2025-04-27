f = @(x) 1 ./ (1 + x);
df = @(x) -1 ./ (1 + x).^2;

x = [0 1 2];
y = f(x);
dy = df(x);

X = linspace(-0.5, 2.5, 500);

Y_lagrange = lagrange(x, y, X);

[Y_hermite, ~] = hermiteInterpolation(x, y, dy, X);

% lagrange polynomial has degree 2 because it interpolates 3 points (degree = points - 1).
% hermite polynomial has degree 5 because it matches 3 values and 3 derivatives (6 conditions -> degree = conditions - 1).
figure;
hold on; grid on;
plot(X, Y_lagrange, 'r-', 'LineWidth', 2);
plot(X, Y_hermite, 'b-', 'LineWidth', 2);
plot(x, y, 'ko', 'MarkerFaceColor', 'k', 'MarkerSize', 8);
legend('lagrange interpolation (deg 2)', 'hermite interpolation (deg 5)', 'data points');
xlabel('x');
ylabel('y');
title('lagrange vs hermite interpolation');

