clear all
clc

% this is X
sample = [7,7,4,5,9,9,4,12,8,1,8,7,3,13,2,1,17,7,12,5,6,2,1,13,14,10,2,4,9,11,3,5,12,6,10,7];

alpha = input("Enter the significance level (alpha): "); %0.05
confidenceLevel = 1 - alpha;
sigma = 5;
m = input("Enter the test value (m): "); %8.5

% what does theta mean for me?
% what is H0?
% what is H1?

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% a)

% "on average" in the problem statement -> theta is the mean

% H0: is theta equal to 8.5 millions? (we ALWAYS ask for equality in H0)
% H1: is theta below 8.5 millions? (left-tailed test)

% find the dist. model: we are working with the normal distribution 
% model N(0,1) (look in the Confidence Intervals pdf file from lab6)

% find the rejection region: RR = (-inf, norminv(alpha, 0, 1))

fprintf("Part a:\n");
fprintf("Left-tailed test for the mean (sigma known)\n");
fprintf("Test value m0 = %4.1f\n\n", m);


RR = [-inf, norminv(alpha, 0, 1)];
[H, P, CI, ZVAL] = ztest (sample, m, sigma , alpha, -1);


fprintf("H is %1.0f, ", H);
if H == 1
    fprintf("so the null hypothesis is rejected, i.e. the data suggests that the standard IS NOT met.\n");
elseif H == 0
    fprintf("So the null hypothesis is not rejected, i.e. the data suggests that the standard IS met.\n");
else
    fprintf("Something is wrong, this should not have happened.\n")
end   

fprintf("The rejection region is (%5.3f, %5.3f).\n", RR(1), RR(2));
fprintf("The value of the test statistic z is %5.3f.\n", ZVAL);

fprintf("The P-value of the test is %6.4f\n", P);
 
% [H, P, CI, ZVAL] = ztest (X, M, SIGMA , ALPHA, TAIL)
% X is the sample
% M is the number (8.5)
% sigma is sigma
% alpha is alpha
% tail is -1 for the left-tailed test, 1 for the right-tailed test and 0
% for the bilateral test
% H is 1 if we reject H0 or 0 if we don't reject H0
% P is the P-value
% CI = confidence interval (!!but it depends on the type of test!!)
% ZVAL is the observed value (TS0 or TT0)

% better use the formulas from the previous laboratory if you need to find
% the confidence interval for something


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% b)

% theta is miu
% H0: theta = 5.5
% H1: theta > 5.5 (right-tailed test)
% case 1, second subcase because we don't know sigma->student model T(n-1)
% RR = [tinv(1-alpha, n-1), inf]
% the command name is ttest because we are using the T model
% [H,P,CI,STATS] = ttest(X, M, ALPHA, TAIL)
% X is sample, M is 5.5, ALPHA is alpha, TAIL is 1 (bcs right-tailed test)
% STATS: tstat = TS0 (or TT0); dl = n-1; sd = an approximation of sigma

fprintf("\n\nPart b:\n");
fprintf("Right-tailed test for the mean (sigma unknown)\n");
m = input("Test value m0 = ");

n = length(sample);
RR = [tinv(1-alpha, n-1), inf];
[H,P,CI,STATS] = ttest(sample, m, alpha, 1);


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








