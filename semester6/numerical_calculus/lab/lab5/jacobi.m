function [x, iterations, spectral_radius] = jacobi(A, b, max_iterations = 1e4, tolerance = 1e-14, p = Inf)
  D = diag(diag(A));           % diagonal of A
  R = A - D;                   % remainder (A without diagonal)
  T = -D \ R;                  % iteration matrix
  c = D \ b;                   % constant vector in iteration
  spectral_radius = max(abs(eig(T))); % spectral radius

  if norm(T, p) >= 1
    error('Method does not converge: norm(T, p) >= 1')
  end

  convergence_factor = norm(T, p) / (1 - norm(T, p));
  x_prev = zeros(size(b));    % initial guess
  iterations = 1;
  x = x_prev;

  while iterations < max_iterations
    x = c + T * x_prev;
    if convergence_factor * norm(x - x_prev, p) < tolerance
      return;
    else
      x_prev = x;
      iterations = iterations + 1;
    end
  end
end

