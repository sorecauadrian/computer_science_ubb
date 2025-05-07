function area = composite_trapezoidal(f, a, b, n)
    h = (b - a) / n;
    x = a : h : b;
    area = h * (sum(f(x)) - 0.5 * (f(a) + f(b)));
end

