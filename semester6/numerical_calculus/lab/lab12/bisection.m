function [root, iterations] = bisection(f, a, b, tol)
    if f(a) * f(b) >= 0
        error('f(a) and f(b) must have opposite signs');
    end

    iterations = 0;
    while (b - a) / 2 > tol
        c = (a + b) / 2;
        if f(c) == 0
            break;
        elseif f(a) * f(c) < 0
            b = c;
        else
            a = c;
        endif
        iterations = iterations + 1;
    endwhile
    root = (a + b) / 2;
end

