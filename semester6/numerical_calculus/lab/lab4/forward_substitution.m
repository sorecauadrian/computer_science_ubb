function x = forward_substitution(A, b)
  n = length(b);
  x = b;
  for i = 1 : n
    x(i) = (b(i) - A(i, 1 : i - 1) * x(1 : i - 1)) / A(i, i);
  endfor
endfunction
