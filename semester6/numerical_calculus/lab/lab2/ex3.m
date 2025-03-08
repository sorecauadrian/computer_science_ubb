warning('off','all');
format long
clf;
hold on;



% a
syms x;
f(x) = log(1 + x);

fplot(f, [-0.9, 1]);

for i = [2, 5]
    T(x) = taylor(f(x), x, 'order', i + 1);
    fplot(T(x), [-0.9, 1]);
end

title('a)');
grid on;
hold off;


% b
% in the formula of ln(1 + x) we replace x with 1 (=> ln(2)) and we're looking only at the error/remainder (last term)
% it will be 1 / (n + 1) * (1 + Xi(x))^(n + 1)
% since Xi(x) is between 0 (x0 = 0) and 1 (x = 1), we're taking the worst case scenario => Xi(x) = 0
% thus, the error will be > 1 / (n + 1)
% 1 / (n + 1) < 10^(-5) => n = 10^5, so we don't need any computation

% you could do this if you want to waste time:
% n = 0;
% while (1 / (n+1) >= 1e-5)
%     n = n + 1;
% end

% T(x) = taylor(f(x), x, 'order', 10**5);
% not going to do that since it will take an eternity
n = 10; % it should be 10**5
approx = double(T(1));
exact = double(f(1));

disp('b)');
disp(['ln2 approximated = ' num2str(approx, '%.10f')]);
disp(['ln2 = ' num2str(exact, '%.10f')]);
disp(['using ' num2str(n + 1) ' terms.']);


% c
f(x) = log(1 - x);
% we obtain the formula for ln(1 - x) by replacing x with -x, thus the formula will be:
% ln(1 - x) = -x - x^2 / 2 - x^3 / 3 - ...

n = 10;
T(x) = taylor(f(x), x, 'order', n);

disp(['c) an order ' num2str(n + 1) ' expansion of ' char(f(x)) ' is:'])
disp(T(x))


% d
f(x) = log((1 + x) / (1 - x));
% ln((1 + x) / (1 - x)) = ln(1 + x) - ln(1 - x) would be 2 * (x + x^3 / 3 + x^5 / 5 + ...)

n = 10;
T(x) = taylor(f(x), x, 'order', n);

disp(['d) an order ' num2str(n + 1) ' expansion of ' char(f(x)) ' is:'])
disp(T(x))


% e

% (1 + x) / (1 - x) = 2
% 1 + x = 2 - 2x
% 3x = 1
% x = 1/3

% another approach, and more intuitive, is to add the terms until the error is less than 10^(-5)
x = 1/3;
approx = 0;
n = 0;
err = Inf;

while err >= 1e-5
    term = 2 * x^(2 * n + 1) / (2 * n + 1);
    approx = approx + term;
    err = 2 * x^(2 * (n + 1) + 1) / (2 * (n + 1) + 1);
    n = n + 1;
end

exact = double(f(1/3));

disp('e)');
disp(['ln2 approximated = ' num2str(approx, '%.10f')]);
disp(['ln2 = ' num2str(exact, '%.10f')]);
disp(['using ' num2str(n + 1) ' terms.']);
