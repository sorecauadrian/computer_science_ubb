function [H, dH] = hermiteInterpolation(x, f, df, X)
  T = hermiteDividedDifferences(x, f, df);
  coefs = T(1, :);
  z = repelem(x, 2);
  H = X;
  dH = X;
  for k = 1 :  length(X)
    P = 1;
    DP = 0;
    H(k) = coefs(1) * P;
    dH(k) = coefs(1) * DP;
    for i = 2 : length(coefs)
      DP = DP * (X(k) - z(i - 1)) + P;
      P = P * (X(k) - z(i - 1));
      H(k) = H(k) + coefs(i) * P;
      dH(k) = dH(k) + coefs(i) * DP;
    endfor
  endfor

