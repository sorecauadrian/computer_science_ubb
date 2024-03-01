clear
clc
close all

x = [21.8, 22.6, 21.0, 19.7, 21.9, 21.6, 22.5, 23.1, 22.2, 20.1, 21.4, 20.5];
y = [36.5, 35.2, 36.2, 34.0, 36.4, 36.1, 37.5, 38.0, 36.3, 35.9, 35.7, 34.9];

n1 = length(x);
n2 = length(y); % length of each array
mx = mean(x);
my = mean(y); % mean for each set of values
sx = var(x);
sy = var(y); % variances for each set of values

alpha = 0.05; % significance level

% a)
% Null hypothesis: the population variances are equal.
% Alternative hypothesis: the population variances differ.

typea=0; % two-tailed test
fprintf('a)\n')
fprintf('SIGNIFICANCE LEVEL %.2f:\n', alpha)
fprintf('We are doing a two-tailed test for variances.\n');

switch typea
     case -1
         l=-Inf;
         r=icdf('f',alpha,n1,n2);
         fprintf('The rejection region, RR, is (%f, %f)\n',l,r);
     case 0
         r=icdf('f',1-alpha/2,n1,n2);
         l=icdf('f',alpha/2,n1,n2);
         fprintf('The rejection region, RR, is (%f, %f) U (%f, %f)\n',-Inf,l,r,Inf);
     case 1
         l=icdf('f',1-alpha,n1,n2);
         r=Inf;
         fprintf('The rejection region, RR, is (%f, %f)\n',l,r);
end 
% finding the rejection region

[ha, pa, cia, valstata] = vartest2(x, y, alpha, typea); 
f = sx / sy;
fprintf('The value of the test statistic f is %f (given by vartest2 %f).\n', f, valstata.fstat)
fprintf('The P-value of the test is %f.\n', pa)
if ha == 1
    fprintf('The null hypothesis is rejected (f in RR), i.e. the variances seem to be different.\n')
else
    fprintf('The null hypothesis is NOT rejected (f not in RR), i.e. the variances seem to be equal.\n')
end    

% b)
fprintf('b)\n');
if ha==1
    n1=length(x);
    n2=length(y);

    mx=mean(x);
    my=mean(y);
    vx=var(x);
    vy=var(y);

    c=(vx/n1)/(vx/n1+vy/n2);
    n=1/(c^2/(n1-1)+(1-c)^2/(n2-1));

    t=icdf('t',1-alpha/2,n);
    rad=sqrt(vx/n1+vy/n2);

    li=mx-my-t*rad;
    ri=mx-my+t*rad;
else
    n1=length(x);
    n2=length(y);
    n=n1+n2-2;

    mx=mean(x);
    my=mean(y);
    vx=var(x);
    vy=var(y);

    t=icdf('t',1-alpha/2,n);
    rad=sqrt(1/n1+1/n2);
    sp=sqrt(((n1-1)*vx+(n2-1)*vy)/n);

    li=mx-my-t*sp*rad;
    ri=mx-my+t*sp*rad;
end
fprintf('Confidence interval for the difference of the means (%.4f,%.4f)\n',li,ri);

