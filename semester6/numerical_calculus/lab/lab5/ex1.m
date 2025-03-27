n = 10;
% n = 1000;

main_diagonal = diag(ones(n, 1));
sub_diagonal = diag(ones(n - 1, 1), -1);
super_diagonal = diag(ones(n - 1, 1), 1);

A = 5 * main_diagonal - sub_diagonal - super_diagonal;
b = [4; 3 * ones(n - 2, 1); 4];

[x_jacobi, iterations_jacobi, spectral_radius_jacobi] = jacobi(A, b, 1000, 1e-5, 2);
[x_gs, iterations_gs, spectral_radius_gs] = gauss_seidel(A, b, 1000, 1e-5, 2);

disp('a) solution using jacobi method');
disp('--------------------------------');
for i = 1:length(x_jacobi)
    fprintf('x%d = %.4f\n', i, x_jacobi(i));
end
fprintf('number of iterations: %d\n', iterations_jacobi);
fprintf('spectral radius: %.6f\n', spectral_radius_jacobi);
disp('--------------------------------');

disp('b) solution using gauss-seidel method');
disp('--------------------------------');
for i = 1:length(x_gs)
    fprintf('x%d = %.4f\n', i, x_gs(i));
end
fprintf('number of iterations: %d\n', iterations_gs);
fprintf('spectral radius: %.6f\n', spectral_radius_gs);
disp('--------------------------------');

