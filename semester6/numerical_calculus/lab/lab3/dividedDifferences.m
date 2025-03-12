function out = dividedDifferences(x, f)
  n = length(x);
  answer = zeros(n, n);
  answer(:, 1) = f(:);
  for i = 2 : 1 : n
    for j = 1 : 1 : n - i + 1
      answer(j, i) = (answer(j + 1, i - 1) - answer(j, i - 1)) / (x(j + i - 1) - x(j));
    endfor
  endfor;
  out = answer;
endfunction
