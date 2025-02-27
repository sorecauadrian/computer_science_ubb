[X, Y] = meshgrid(-2 : .1 : 2, 0.5 : .1 : 4.5);
Z = sin(exp(X)) .* cos(log(Y));
mesh(X,Y,Z)
