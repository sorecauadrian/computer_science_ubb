x = [0 3 5 8 13];
f = [0 225 383 623 993];
d_f = [0 77 80 74 72];

t0 = 10;

X = t0;
[s_approx, v_approx] = hermiteInterpolation(x, f, d_f, X);

fprintf('at t = %.2f seconds:\n', t0);
fprintf('approximated position = %.4f meters\n', s_approx);
fprintf('approximated velocity = %.4f meters/second\n', v_approx);

X_plot = linspace(0, 13, 1000);
[s_plot, v_plot] = hermiteInterpolation(x, f, d_f, X_plot);

figure;
hold on; grid on;
plot(X_plot, s_plot, 'b-', 'LineWidth', 2);
plot(x, f, 'ro', 'MarkerSize', 8, 'MarkerFaceColor', 'r');
xlabel('time (s)');
ylabel('position (m)');
title('position vs time using hermite interpolation');
legend('hermite interpolation', 'data points');

