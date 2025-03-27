function [x, iterations, spectral_radius] = gauss_seidel(A, b, max_iterations = 1e4, tolerance = 1e-14, p = Inf)
  D = diag(diag(A));              % diagonal of A
  L = tril(A, -1);                % lower triangle (below diagonal)
  U = triu(A, 1);                 % upper triangle (above diagonal)

  T = -(D + L) \ U;               % iteration matrix for gauss-seidel
  c = (D + L) \ b;                % constant vector
  spectral_radius = max(abs(eig(T)));

  if norm(T, p) >= 1
    error('method does not converge: norm(T, p) >= 1')
  end

  convergence_factor = norm(T, p) / (1 - norm(T, p));
  x = zeros(size(b));             % initial guess
  iterations = 1;

  while iterations < max_iterations
    x_old = x;

    for i = 1:length(b)
      sum1 = A(i, 1:i-1) * x(1:i-1);       % use updated values
      sum2 = A(i, i+1:end) * x_old(i+1:end); % use old values
      x(i) = (b(i) - sum1 - sum2) / A(i, i);
    end

    if convergence_factor * norm(x - x_old, p) < tolerance
      return;
    else
      iterations = iterations + 1;
    end
  end
end

