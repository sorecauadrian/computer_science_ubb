clear all;
clc;
clf;

n = 3;
p = .5;
k = 0:1:n;
x = [k; [binopdf(k, n, p)]];

c1 = binopdf(0, n, p);
c2 = 1 - binopdf(1, n, p);
d1 = binocdf(2, n, p);
d2 = binocdf(2, n, p) - binopdf(2, n, p);
e1 = 1 - binocdf(1, n, p) + binopdf(1, n, p);
e2 = 1 - binocdf(1, n, p);