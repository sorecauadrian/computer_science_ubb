A = [2 1 -1 -2; 4 4 1 3; -6 -1 10 10; -2 1 8 4];
b = [2; 4; -5; 1];

solution = gauss_elimination(A, b);

disp('solution using gaussian elimination:');
for i = 1 : length(solution)
    fprintf('x%d = %.4f\n', i, solution(i));
end
