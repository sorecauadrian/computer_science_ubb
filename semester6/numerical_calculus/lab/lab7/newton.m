function L = newton(x, f, X)
  T = dividedDifferences(x, f);
  coefs = T(1, :);
  n = length(coefs);
  L = zeros(size(X));
  for k = 1 : length(X)
    L(k) = coefs(1);
    p = 1;
    for i = 2 : n
      p = p * (X(k) - x(i-1));
      L(k) = L(k) + coefs(i) * p;
    end
  end
end
