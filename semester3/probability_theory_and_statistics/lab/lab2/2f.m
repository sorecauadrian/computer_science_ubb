clear all;
clf;
clc;

n = 3;
p = 0.5;
s = input("how many times do you want to run: ");
table = p < rand(3, s);
h = sum(table);
hist(h)