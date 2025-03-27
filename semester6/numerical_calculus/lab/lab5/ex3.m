% n = 10;
n = 1000;

main_diag = diag(5 * ones(n, 1));
sub_diag = diag(-1 * ones(n - 1, 1), -1);
super_diag = diag(-1 * ones(n - 1, 1), 1);
sub3_diag = diag(-1 * ones(n - 3, 1), -3);
super3_diag = diag(-1 * ones(n - 3, 1), 3);

A = main_diag + sub_diag + super_diag + sub3_diag + super3_diag;
b = [3; 2; 2; ones(n - 6, 1); 2; 2; 3];

tol = 1e-5;
maxit = 10000;
x0 = zeros(n, 1);

[x_jacobi, iter_jacobi, ~] = jacobi(A, b, maxit, tol, inf);
[x_gs, iter_gs, ~] = gauss_seidel(A, b, maxit, tol, inf);

omega = 1.1;
[x_sor, iter_sor] = sor(A, b, omega, x0, tol, maxit);

disp('a) jacobi method');
disp('--------------------------------');
fprintf('number of iterations: %d\n', iter_jacobi);
disp('--------------------------------');

disp('b) gauss-seidel method');
disp('--------------------------------');
fprintf('number of iterations: %d\n', iter_gs);
disp('--------------------------------');

disp('c) sor method');
disp('--------------------------------');
fprintf('number of iterations: %d\n', iter_sor);
fprintf('omega used: %.2f\n', omega);
disp('--------------------------------');

disp('d) comparison summary');
disp('--------------------------------');
fprintf('n = %d\n', n);
fprintf('jacobi iterations      : %d\n', iter_jacobi);
fprintf('gauss-seidel iterations: %d\n', iter_gs);
fprintf('sor iterations         : %d (omega = %.2f)\n', iter_sor, omega);
disp('--------------------------------');

