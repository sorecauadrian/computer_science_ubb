function out = forwardDifferences(f)
  n = length(f);
  answer = zeros(n, n);
  answer(:, 1) = f(:);
  for i = 2 : n
    for j = 1 : n - i + 1
      answer(j, i) = answer(j + 1, i - 1) - answer(j, i - 1);
    endfor
  endfor;
  out = answer;
endfunction
