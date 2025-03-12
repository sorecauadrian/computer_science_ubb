warning('off','all');
format short;

syms x;
f(x) = 1 / (1 + x);
df(x) = diff(f, x);

x_values = [0 1 2];
f_values = double(f(x_values));
df_values = double(df(x_values));

% a
disp('a) divided differences table (simple nodes) for f(x)=1/(1+x):');
disp(dividedDifferences(x_values, f_values));

% b
disp('b) divided differences table (double nodes) for f(x)=1/(1+x):');
disp(hermiteDividedDifferences(x_values, f_values, df_values));

% c
x_values = linspace(1, 2, 11);
f_values = double(f(x_values));
df_values = double(df(x_values));

disp('c)');
disp('divided differences table (simple nodes) for f(x)=1/(1+x), 11 equidistant nodes:');
disp(dividedDifferences(x_values, f_values));

disp('divided differences table (double nodes) for f(x)=1/(1+x), 11 equidistant nodes:');
disp(hermiteDividedDifferences(x_values, f_values, df_values));


