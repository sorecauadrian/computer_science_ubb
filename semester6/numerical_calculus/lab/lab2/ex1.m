warning('off','all');
format long
clf;
hold on;



% a
syms x;
f(x) = exp(x);

fplot(f, [-3, 3]);

for i = 1 : 4
    T(x) = taylor(f(x), x, 'order', i + 1);
    fplot(T(x), [-3, 3]);
end

title('a)');
grid on;
hold off;



% b
n = 0;
while 3 / factorial(n + 1) >= 10^(-6)
  n = n + 1;
end

T(x) = taylor(f(x), x, 'order', n + 1);
approx = double(T(1));
exact = double(exp(1));

disp('b)');
disp(['exp(1) approximated = ' num2str(approx, '%.10f')]);
disp(['exp(1) = ' num2str(exact, '%.10f')]);
disp(['using ' num2str(n + 1) ' terms.']);
