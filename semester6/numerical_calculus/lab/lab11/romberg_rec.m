function [I, i] = romberg_rec(f, a, b, err, NrmaxIter)
  T = zeros(2);
  i = 1;
  while true
    if ((i > 2 && abs(T(end - 1, end - 1) - T(end, end)) < err) || i > NrmaxIter)
      I = T(end, end);
      return;
    end
    T(i, 1) = composite_trapezoidal(f, a, b, 2 ^ i);
    for j = 2 : i
      T(i, j) = (4 ^ (1 - j) * T(i - 1, j - 1) - T(i, j - 1)) / (4 ^ (1 - j) - 1);
    end
    i = i + 1;
  end
endfunction
