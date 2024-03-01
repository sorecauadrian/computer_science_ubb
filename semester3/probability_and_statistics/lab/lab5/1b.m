clear all
clc
batteryDuration = [7, 7, 4, 5, 9, 9 , 4, 12, 8, 1, 8, 7, 3, 13, 2, 1, 17, 7, 12, 5, 6, 2, 1, 13, 14, 10, 2, 4, 9, 11, 3, 5, 12, 6, 10, 7];
n = length(batteryDuration);
sigma = 5;
confLevel = input("Enter the confidence level:")
alpha = 1 - confLevel;
xm = mean(batteryDuration);
tl = xm-sigma/sqrt(n)*norminv(1-alpha/2);
tu = xm-sigma/sqrt(n)*norminv(alpha/2);
fprintf("a) The %2.0f%% confidence interval " + ...
        "for the mean is (%5.3f, %5.3f)\n" + ...
        "", (1-alpha)*100, tl, tu)

s=std(batteryDuration);
tl = xm-s/sqrt(n)*tinv(1-alpha/2, n - 1);
tu = xm-s/sqrt(n)*tinv(alpha/2, n - 1);
fprintf("b) The %2.0f%% confidence interval " + ...
        "for the mean is (%5.3f, %5.3f)\n" + ...
        "", (1-alpha)*100, tl, tu)
vars = var(batteryDuration);
tl = (n-1)*vars/chi2inv(1-alpha/2, n-1);
tu = (n-1)*vars/chi2inv(alpha/2, n-1);
fprintf("c) The %2.0f%% confidence interval " + ...
        "for the mean is (%5.3f, %5.3f)\n" + ...
        "", (1-alpha)*100, tl, tu)
fprintf("c) The %2.0f%% confidence interval " + ...
        "for the mean is (%5.3f, %5.3f)\n" + ...
        "", (1-alpha)*100, sqrt(tl), sqrt(tu))

x1 = [22.4, 21.7, 24.5, 23.4, 21.6, 23.3, 22.4, 21.6, 24.8, 20.0]
x2 = [17.7, 14.8, 19.6, 19.6, 12.1, 14.8, 15.4, 12.6, 14.0, 12.2]
n1 = length(x1)
n2 = length(x2)
x1bar = mean(x1)
x2bar = mean(x2)
tl = x1bar - x2bar - tinv(1-alpha/2, n1 + n2 -1)
