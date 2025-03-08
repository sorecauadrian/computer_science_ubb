warning('off','all');
format long
clf;
hold on;



% a
syms x;
f(x) = sin(x);

fplot(f, [-pi, pi]);

for i = [3, 5]
    T(x) = taylor(f(x), x, 'order', i + 1);
    fplot(T(x), [-3, 3]);
end

title('a)');
grid on;
hold off;



% b - something similar could be at the exam
n = 0;
while (pi / 5)^(2 * n + 1) / factorial(2 * n + 1) >= 10^(-5)
  n = n + 1;
end

T(x) = taylor(f(x), x, 'order', 2 * n + 1);
approx = double(T(pi/5));
exact = double(f(pi/5));

disp('b)');
disp(['sin(pi/5) approximated = ' num2str(approx, '%.10f')]);
disp(['sin(pi/5) = ' num2str(exact, '%.10f')]);
disp(['using ' num2str(n + 1) ' terms.']);



% c - what happens is that we need a high order in order to approximate it correctly,
% so we're using the fact that sin is a periodic function in order to compute an approximation using a lower order of the taylor series
n = 0;
r = mod(10 * pi / 3, 2 * pi);
while (r^(2 * n + 1) / factorial(2 * n + 1) >= 10^(-5))
  n = n + 1;
end

T(x) = taylor(f(x), x, 'order', 2 * n + 1);
approx = double(T(r));
exact = double(f(r));

disp('c)');
disp(['sin(' num2str(r) ') approximated = ' num2str(approx, '%.10f')]);
disp(['sin(' num2str(r) ') = ' num2str(exact, '%.10f')]);
disp(['using ' num2str(n + 1) ' terms.']);
