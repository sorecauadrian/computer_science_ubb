format long

% a: laguerre, weight e^-x
f = @(x) sin(x);
disp('a) integral of e^{-x} sin(x) from 0 to inf')
for n = 2:2:10
    I = Gaussquad(f, n, 4);
    fprintf('n = %2d, I ~ %.10f, err = %.1e\n', n, I, abs(I - 0.5));
end

% b: hermite, weight e^{-x^2}
g = @(x) cos(x);
disp(' ')
disp('b) integral of e^{-x^2} cos(x) over R')
for n = 2:2:10
    I = Gaussquad(g, n, 5);
    fprintf('n = %2d, I ~ %.10f\n', n, I);
end

% c: chebyshev 1st kind, weight 1/sqrt(1 - x^2)
h = @(x) sin(x.^2);
disp(' ')
disp('c) integral of sin(x^2)/sqrt(1 - x^2) from -1 to 1')
for n = 2:2:10
    I = Gaussquad(h, n, 2);
    fprintf('n = %2d, I ~ %.10f\n', n, I);
end

