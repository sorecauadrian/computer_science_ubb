p = [1 -5 -16 16 -17 21];
f = @(x) polyval(p, x);

% a
fplot(f, [-4, 7.2], "LineWidth", 2)
% b
f(-2.5)
% c
roots(p)
