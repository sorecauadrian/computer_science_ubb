function [root, iterations] = secant(f, a, b, tol)
    iterations = 0;
    while abs(b - a) > tol
        if f(b) - f(a) == 0
            error('division by zero');
        end

        c = b - f(b) * (b - a) / (f(b) - f(a));
        a = b;
        b = c;
        iterations = iterations + 1;
    endwhile
    root = b;
end
