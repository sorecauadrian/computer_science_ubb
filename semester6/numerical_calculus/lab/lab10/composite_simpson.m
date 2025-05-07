function area = composite_simpson(f, a, b, n)
    h = (b - a) / n;
    x_odd = a + h : 2 * h : b - h;
    x_even = a + 2 * h : 2 * h : b - 2 * h;

    area = h / 3 * (f(a) + 4 * sum(f(x_odd)) + 2 * sum(f(x_even)) + f(b));
end

