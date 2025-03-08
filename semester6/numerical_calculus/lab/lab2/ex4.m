% 999^(1/3) =
% (1000 - 1)^(1/3) =
% (1000 * (1 - 1/1000))^(1/3) =
% 10 * (1 - 1/1000)^(1/3)

a = 1/3;
x = -1/1000; % |x| < 1
approx_sum = 0;
n = 0;
err = Inf;

while err >= 1e-10
    coeff = 1;
    for k = 1:n
        coeff = coeff * (a - (k - 1)) / k;
    end
    term = coeff * x^n;
    approx_sum = approx_sum + term;

    coeff_next = 1;
    for k = 1:(n+1)
        coeff_next = coeff_next * (a - (k - 1)) / k;
    end
    next_term = coeff_next * x^(n+1);
    err = abs(10 * next_term);  % error after multiplying by 10

    n = n + 1;
end

exact = nthroot(999, 3);
approx = approx_sum * 10;

disp(['nthroot(999, 3) approximated = ' num2str(approx, '%.10f')]);
disp(['nthroot(999, 3) = ' num2str(exact, '%.10f')]);
disp(['using ' num2str(n) ' terms.']);

