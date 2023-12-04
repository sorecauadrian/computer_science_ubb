clc;
clear all;

trials = input("number of trials: ");

p = input("probability of success: ");
while p >= 1 || p <= 0
    p = input("probability should be between 0 and 1. try again: ");
end

simulations = input("number of simulations: ");

u = rand(trials, simulations);

m = u < p;

x = sum(m);
u_x = unique(x);
n_x = hist(x, length(u_x));
freq = n_x / simulations

plot(u_x, freq, 'x')
hold on
plot(0:trials, binopdf(0:trials, trials, p), 'o')
legend("simulation", "binopdf")
title("lab4")
hold off