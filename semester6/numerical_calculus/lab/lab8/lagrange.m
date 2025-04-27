function polynomial = lagrange(x, f, X)
  n = length(x);
  polynomial = zeros(size(X));
  for k = 1 : length(X)
    for i = 1 : n
      z = 1;
      for j = [1 : i - 1, i + 1 : n]
        z = z .* (X(k) - x(j)) / (x(i) - x(j));
      endfor
      polynomial(k) = polynomial(k) + z * f(i);
    endfor
  endfor
endfunction
