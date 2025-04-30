T = [0 10 20 30 40 60 80 100];
P = [0.0061 0.0123 0.0234 0.0424 0.0738 0.1992 0.4736 1.0133];

x_plot = linspace(0, 100, 1000);
[p_quad, s_quad] = polyfit(T, P, 2);
[p_cubic, s_cubic] = polyfit(T, P, 3);
y_quad = polyval(p_quad, x_plot);
y_cubic = polyval(p_cubic, x_plot);

clf;
hold on;
plot(x_plot, y_quad);
plot(x_plot, y_cubic);
scatter(T, P);
legend('quadratic', 'cubic', 'data');
xlabel('temperature');
ylabel('pressure');
grid on;

x_val = 45;
y_est_quad = polyval(p_quad, x_val);
y_est_cubic = polyval(p_cubic, x_val);

fprintf('quadratic estimate at T = 45°C: %.5f bar\n', y_est_quad);
fprintf('cubic estimate at T = 45°C: %.5f bar\n', y_est_cubic);
fprintf('quadratic error (norm): %.5f\n', s_quad.normr);
fprintf('cubic error (norm): %.5f\n', s_cubic.normr);

