function area = composite_rectangle(f, a, b, n)
    h = (b - a) / n;
    x_mid = a + h / 2 : h : b - h / 2;
    area = sum(f(x_mid) * h);
end

