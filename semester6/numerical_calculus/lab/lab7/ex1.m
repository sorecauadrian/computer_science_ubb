x = [0, 1/3, 1/2, 1];
f = cos(pi * x);

fprintf("\n--- (a) lagrange polynomial using newton's divided differences ---\n");
T = dividedDifferences(x, f);
disp("divided differences table:");
disp(T);

N = @(X) newton(x, f, X);

fprintf("\n--- (b) error bound for L_3(x) ---\n");
% the 4th derivative of cos(pi x) is pi^4 * cos(pi x)
% max of |f^(4)(Xi)| in [0,1] is pi^4
max_f4 = pi^4;
product_term = max(abs((0:0.01:1) - x(1)) .* abs((0:0.01:1) - x(2)) .* ...
                   abs((0:0.01:1) - x(3)) .* abs((0:0.01:1) - x(4)));
error_bound = (max_f4 / factorial(4)) * product_term;

fprintf("maximum |f^(4)(x)| ≈ %.3f\n", max_f4);
fprintf("estimated error bound R3f(x) ≤ %.5f\n", error_bound);

fprintf("\n--- (c) plot of f(x) and L_3(x) ---\n");
clf;
hold on;
fplot(@(x) cos(pi*x), [0, 1], "--", "LineWidth", 1.5);
fplot(N, [0, 1], "LineWidth", 1.5);
plot(x, f, "ko", "MarkerFaceColor", "k");
legend("f(x) = cos(pi*x)", "L_3(x)", "Nodes");
title("interpolation of cos(pi*x) with L_3(x)");
grid on;

fprintf("\n--- (d) approximate cos(π/5) using L_3(x) ---\n");
x_val = 1/5;
approx = N(x_val);
exact = cos(pi * x_val);
fprintf("L_3(1/5) = %.6f\n", approx);
fprintf("exact value cos(π/5) = %.6f\n", exact);
fprintf("absolute error = %.6e\n", abs(approx - exact));

fprintf("\n--- (e) error bound for this approximation ---\n");
prod_term = abs((x_val - x(1)) * (x_val - x(2)) * (x_val - x(3)) * (x_val - x(4)));
bound_approx = (max_f4 / factorial(4)) * prod_term;
fprintf("error bound at x = 1/5: ≤ %.5e\n", bound_approx);
