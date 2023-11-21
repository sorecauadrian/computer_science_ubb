clf;
clc;
clear all;

alpha = input("alpha: ");
beta = input("beta: ");

model = input("choose the model (normal, student, x2, fisher, poisson): ", "s");
switch model
    case "normal"
        fprintf("normal form\n");
        miu = input("miu: ");
        sigma = input("sigma: ");
        
        a1 = normcdf(0, miu, sigma);
        b1 = normcdf(1, miu, sigma) - normcdf(-1, miu, sigma);
        c = norminv(alpha, miu, sigma);
        d = norminv(1 - beta, miu, sigma);
    case "student"
        fprintf("student form\n");
        n = input("n: ");

        a1 = tcdf(0, n);
        b1 = tcdf(1, n) - tcdf(-1, n);
        c = tinv(alpha, n);
        d = tinv(1 - beta, n);
    case "x2"
        fprintf("x2 form\n");
        n = input("n: ");

        a1 = chi2cdf(0, n);
        b1 = chi2cdf(1, n) - chi2cdf(-1, n);
        c = chi2inv(alpha, n);
        d = chi2inv(1 - beta, n);
    case "fisher"
        fprintf("fisher form\n");
        m = input("m: ");
        n = input("n: ");

        a1 = fcdf(0, m, n);
        b1 = fcdf(1, m, n) - fcdf(-1, m, n);
        c = finv(alpha, m, n);
        d = finv(1 - beta, m, n);
    otherwise
        fprintf("input not valid");
end

a2 = 1 - a1;
b2 = 1 - b1;

fprintf("P(x <= 0) = %9.5f\n", a1);
fprintf("P(x >= 0) = %9.5f\n", a2);
fprintf("P(-1 <= x <= 1) = %9.5f\n", b1);
fprintf("P(x <= -1 or x >= 1) = %9.5f\n", b2);
fprintf("P(x <= %f) = %f\n", c, alpha);
fprintf("P(x >= %f) = %f\n", d, beta);


