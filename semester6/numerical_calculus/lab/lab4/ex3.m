n = 10;

mainDiagonal = diag(ones(n, 1));
subDiagonal = diag(ones(n - 1, 1), -1);
superDiagonal = diag(ones(n - 1, 1), 1);

subsubsubDiagonal = diag(ones(n - 3, 1), -3)
supersupersuperDiagonal = diag(ones(n - 3, 1), 3)

A = 5 * mainDiagonal - subDiagonal - superDiagonal - subsubsubDiagonal - supersupersuperDiagonal;
b = [3; 2; 2; 1 * ones(n - 6, 1); 2; 2; 3];

solution = gauss_elimination(A, b);

disp('solution using gaussian elimination:');
for i = 1 : length(solution)
    fprintf('x%d = %.4f\n', i, solution(i));
end
