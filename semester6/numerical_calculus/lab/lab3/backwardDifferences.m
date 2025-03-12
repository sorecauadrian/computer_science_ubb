function out = backwardDifferences(f)
  n = length(f);
  answer = zeros(n, n);
  answer(:, 1) = f(:);
  for i = 2 : n
    for j = n : -1 : i
      answer(j, i) = answer(j, i - 1) - answer(j - 1, i - 1);
    endfor
  endfor;
  out = answer;
endfunction
