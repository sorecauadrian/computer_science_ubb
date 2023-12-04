clc;
clear all;

p = input("probability of success: ");
while p >= 1 || p <= 0
    p = input("probability should be between 0 and 1. try again: ");
end

s = input("number of simulations: ");

u = rand(1, s);

x = u < p;

u_x = unique(x);
n_x = hist(x, length(u_x));
freq = n_x / s;
[u_x; freq]