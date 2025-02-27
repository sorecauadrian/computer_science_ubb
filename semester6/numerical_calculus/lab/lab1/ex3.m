R = 3.8;
r = 1;
x = @(t) (R + r) * cos(t) - r * cos((R / r + 1) * t);
y = @(t) (R + r) * sin(t) - r * sin((R / r + 1) * t);
t = linspace(0, 10 * pi, 1000);
xt = x(t);
yt = y(t);
plot(xt, yt)
