clf;
clc;
clear all;

n = input("number of trials: ");
p = input("probability of success: ");
k = 0:1:n;
y = binopdf(k, n, p);
x = 0:.01:n;
f = binocdf(x, n, p);
plot(k, y, "|")
hold on
plot(x, f)
legend("pdf", "cdf")
title("lab2")
hold off


