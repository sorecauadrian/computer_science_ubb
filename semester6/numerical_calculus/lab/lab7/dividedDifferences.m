function T = dividedDifferences(x, f)
  n = length(x);
  T = NaN(n);
  T(:, 1) = f;
  for j = 2 : n
    for i = 1 : n - j + 1
      T(i, j) = (T(i + 1, j - 1) - T(i, j - 1)) / (x(i + j - 1) - x(i));
    endfor
  endfor
endfunction
