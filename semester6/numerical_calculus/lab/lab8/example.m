% having the time, distance and speed in 5 points,
% the police is constructing the graph of how you drove
x = [0 3 5 8 13];
f = [0 225 383 623 993];
d_f = [75 77 80 74 72];

clf; hold on;
grid on;

% if they compute it like this, you would get a fine
X = linspace(0, 13, 1000);
[H, dH] = hermiteInterpolation(x, f, d_f, X);
plot(f, d_f, '*r');
plot(H, dH, '-b');

% but if you show them the computation of the hermite interpolation graph
% between each of those 2 points, you won't get that fine anymore
for i = 1 : 4
  X = linspace(x(i), x(i + 1), 1000);
  [H, dH] = hermiteInterpolation(x(i : i + 1), f(i : i + 1), d_f(i : i + 1), X);
  plot(H, dH, '-g');
endfor

