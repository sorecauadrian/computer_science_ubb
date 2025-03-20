n = 10;

mainDiagonal = diag(ones(n, 1));
subDiagonal = diag(ones(n - 1, 1), -1);
superDiagonal = diag(ones(n - 1, 1), 1);

A = 5 * mainDiagonal - subDiagonal - superDiagonal;
b = [4; 3 * ones(n - 2, 1); 4];

solution = gauss_elimination(A, b);

disp('solution using gaussian elimination:');
for i = 1 : length(solution)
    fprintf('x%d = %.4f\n', i, solution(i));
end
