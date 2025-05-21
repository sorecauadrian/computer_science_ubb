function [root, iterations] = newton(f, df, x0, tol)
    iterations = 0;
    while abs(f(x0)) > tol
        dfx = df(x0);
        if dfx == 0
            error('derivative is zero. newton method fails.');
        end
        x0 = x0 - f(x0) / dfx;
        iterations = iterations + 1;
    end
    root = x0;
end

