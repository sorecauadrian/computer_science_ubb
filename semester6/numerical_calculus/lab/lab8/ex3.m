f = @(x) x.^(1/3);
df = @(x) (1/3) * x.^(-2/3);

x = [1 4 6 8];
y = f(x);
dy = df(x);

X = 7;

[Y_hermite, ~] = hermiteInterpolation(x, y, dy, X);

fprintf('approximation of cbrt(7) using hermite interpolation: %.10f\n', Y_hermite);
fprintf('actual value of cbrt(7): %.10f\n', 7^(1/3));
fprintf('absolute error: %.10e\n', abs(Y_hermite - 7^(1/3)));
