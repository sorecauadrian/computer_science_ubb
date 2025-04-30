function out = hermiteDividedDifferences(x, f, d_f)
  n = 2 * length(x);
  answer = zeros(n, n);
  answer(1 : 2 : n, 1) = f(:);
  answer(2 : 2 : n, 1) = f(:);
  answer(1 : 2 : n, 2) = d_f(:);
  answer(2 : 2 : n - 2, 2) = diff(f) ./ diff(x);

  z = zeros(n);
  z(1 : 2 : n) = x;
  z(2 : 2 : n) = x;

  for i = 3 : 1 : n
    for j = 1 : 1: n - i + 1
      answer(j, i) = (answer(j + 1, i - 1) - answer(j, i - 1)) ./ (z(j + i - 1) - z(j));
    endfor
  endfor
  out = answer;
endfunction
