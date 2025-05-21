function [root, iterations] = false_position(f, a, b, tol)
    if f(a) * f(b) >= 0
        error('f(a) and f(b) must have opposite signs');
    end

    iterations = 0;
    while abs(b - a) > tol
        c = (a * f(b) - b * f(a)) / (f(b) - f(a));
        if f(c) == 0
            break;
        elseif f(a) * f(c) < 0
            b = c;
        else
            a = c;
        endif
        iterations = iterations + 1;
    endwhile
    root = (a * f(b) - b * f(a)) / (f(b) - f(a));
end

