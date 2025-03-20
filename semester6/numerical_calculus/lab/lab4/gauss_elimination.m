function x = gauss_eliminiation(A, b)
  A = [A b];
  n = length(b);
  for k = 1 : n - 1
    [valmax, pozmax] = max(abs(A(k : n, k)));
    pozpivot = pozmax + k - 1;
    if valmax == 0
      disp('NU avem solutie unica!');
      return;
    elseif pozpivot != k
      A([k, pozpivot], k : end)=A([pozpivot, k], k : end);
    end
    for i = k + 1 : n
      A(i, k : end) = A(i, k : end) - A(k, k : end) * A(i, k) / A(k, k);
    end
  end
  x = backward_substitution(A(:, 1 : end - 1) , A(:, end));
endfunction
