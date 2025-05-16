f = @(x) pi;
I = Gaussquad(f, 2, 2);
err = abs(pi - I);
fprintf('I ≈ %.10f, exact = %.10f, error = %.1e\n', I, pi, err)
