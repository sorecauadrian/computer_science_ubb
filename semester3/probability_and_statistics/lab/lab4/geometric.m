clc;
clear all;

p = input("probability of success: ");
while p >= 1 || p <= 0
    p = input("probability should be between 0 and 1. try again: ");
end

simulations = input("number of simulations: ");

x = zeros(1, simulations)

%not done
while simulations

    simulations = simulations - 1
end

u_x = unique(x);
n_x = hist(x, length(u_x));
freq = n_x / simulations

plot(u_x, freq, 'x')
hold on
plot(0:max(u_x), geopdf(0:max(u_x), p), 'o')
legend("simulation", "geopdf")
title("lab4")
hold off