% a)
disp('a) original system and solution');
A = [10 7 8 7;
     7 5 6 5;
     8 6 10 9;
     7 5 9 10];

b = [32; 23; 33; 31];
x = A \ b;
disp('original solution:');
disp(x);
disp('--------------------------------');

% b)
disp('b) perturbed right-hand side b');
bp = [32.1; 22.9; 33.1; 30.9];
xp = A \ bp;
disp('solution with perturbed b:');
disp(xp);

cond_A = cond(A, 2);
rel_err_input_b = norm(b - bp, 2) / norm(b, 2);
rel_err_output_x = norm(x - xp, 2) / norm(x, 2);
amplification_b = rel_err_output_x / rel_err_input_b;

disp('condition number of A:');
disp(cond_A);
disp('relative error in b:');
disp(rel_err_input_b);
disp('relative error in x:');
disp(rel_err_output_x);
disp('error amplification factor:');
disp(amplification_b);
disp('--------------------------------');

% c)
disp('c) perturbed system matrix A');
Ap = [10   7    8.1  7.2;
      7.8  5.04 6    5;
      8    5.98 9.89 9;
      6.99 4.99 9    9.98];

xp2 = Ap \ b;
disp('solution with perturbed A:');
disp(xp2);

cond_Ap = cond(Ap, 2);
rel_err_input_A = norm(A - Ap, 2) / norm(A, 2);
rel_err_output_x2 = norm(x - xp2, 2) / norm(x, 2);
amplification_A = rel_err_output_x2 / rel_err_input_A;

disp('condition number of perturbed A:');
disp(cond_Ap);
disp('relative error in A:');
disp(rel_err_input_A);
disp('relative error in x:');
disp(rel_err_output_x2);
disp('error amplification factor:');
disp(amplification_A);
disp('--------------------------------');

% d)
disp('d) explanation:');
disp('a small change in the input (b or A) can cause large changes in the solution x,');
disp('especially when the condition number is high. this system is ill-conditioned.');
disp('--------------------------------');

