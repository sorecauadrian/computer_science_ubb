function [x, iterations] = sor(A, b, w, x0, tol, max_iterations)
  n = length(b);
  x = x0;
  iterations = 0;

  while iterations < max_iterations
    x_old = x;

    for i = 1:n
      sigma = A(i, 1 : i - 1) * x(1 : i - 1) + A(i, i + 1 : end) * x_old(i + 1 : end);
      x(i) = (1 - w) * x_old(i) + (w / A(i, i)) * (b(i) - sigma);
    end

    if norm(x - x_old, inf) < tol
      return;
    end

    iterations = iterations + 1;
  end
end

