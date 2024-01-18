clear all
clc

% this is X
premiumSample = [22.4,24.5,21.6,22.4,24.8,21.7,23.4,23.3,21.6,20];
regularSample = [17.7,19.6,12.1,15.4,14.0,14.8,19.6,14.8,12.6,12.2];

n1 = length(premiumSample); % premiumSampleSize 
n2 = length(regularSample); % regularSampleSize

alpha = input("Enter the significance level (alpha): "); %0.05
confidenceLevel = 1 - alpha;
alpha = 1 - confidenceLevel;

% a) are (theta1)^2 and (theta2)^2 equal?

% theta = theta1/theta2
% H0: theta = 1
% H1: theta != 1
% we use the Fisher model: F(n1-1, n2-1)
% bilateral test

% RR = (-inf, finv(alpha/2, n1-1, n2-1)) U (..., inf)
%[H, P, CI, STATS] = vartest2(premiumSample, regularSample, alpha, tail);
% stats: fstat = TS0, df1 = n1-1, df2 = n2-1 (n1 is len(premiumGas) and
% n2 is len(regularGas))

fprintf("Part a:\n");
fprintf("Bilateral test for the ratio of two population variances\n");
m=1;
fprintf("Test value m0 = %4.1f\n\n", m);

%RR = RR1 U RR2
RR1 = [-inf, finv(alpha/2, n1-1, n2-1)];
RR2 = [finv(1-alpha/2, n1-1, n2-1), inf]; % !!! I HAVE NO IDEA IF THIS IS THE CORRECT RR2, ASK THE TEACHER !!!
[H, P, CI, STATS] = vartest2(premiumSample, regularSample, alpha, 0);


fprintf("H is %1.0f, ", H);
if H == 1
    fprintf("so the null hypothesis is rejected, i.e. the data suggests that the standard IS NOT met.\n");
elseif H == 0
    fprintf("So the null hypothesis is not rejected, i.e. the data suggests that the standard IS met.\n");
else
    fprintf("Something is wrong, this should not have happened.\n")
end   

fprintf("The rejection region is (%5.3f, %5.3f) U (%5.3f, %5.3f).\n", RR1(1), RR1(2), RR2(1), RR2(2));
fprintf("The value of the test statistic is %5.3f.\n", STATS.fstat);

fprintf("The P-value of the test is %6.4f\n", P);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% b) is the mean of the premiumGas > the mean of the regularGas?
% (or miu1 > miu2)
% theta = miu1 - miu2
% H0: theta = 0 //the mean of the premiumGas IS NOT > the mean of the regularGas
% H1: theta > 0 (right-tailed test) //the mean of the premiumGas IS > the mean of the regularGas

% [H, P, CI, STATS] = ttest2(premiumGas, regularGas, alpha, tail, vartype)
% vartype = "equal" if the variances are equal or "unequal" if they are not
% (we discovered this in part a) and yes, they are equal) 
% STATS: tstat = TS0

fprintf("Part a:\n");
fprintf("Right-tailed test for the difference of two population means\n");
m=0;
fprintf("Test value m0 = %4.0f\n\n", m);

RR = [tinv(1-alpha, n1+n2-2),inf];
[H, P, CI, STATS] = ttest2(premiumSample, regularSample, alpha, 1, "equal");


fprintf("H is %1.0f, ", H);
if H == 1
    fprintf("so the null hypothesis is rejected, i.e. the data suggests that the standard IS NOT met.\n");
elseif H == 0
    fprintf("So the null hypothesis is not rejected, i.e. the data suggests that the standard IS met.\n");
else
    fprintf("Something is wrong, this should not have happened.\n")
end   

fprintf("The rejection region is (%5.3f, %5.3f).\n", RR(1), RR(2));
fprintf("The value of the test statistic is %5.3f.\n", STATS.tstat);

fprintf("The P-value of the test is %6.4f\n", P);


% homework: finish the table from lab 4







