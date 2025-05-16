function [I, g_nodes, g_coeff] = Gaussquad(f, n, g_type)
% Gaussquad - generates Gaussian quadrature
% computes nodes and coefficients, when alpha and beta are known
% method - Jacobi matrix; e-values, e-vectors.
% f - the function (WITHOUT the weight!)
% n - number of nodes
% g_type - type of Gaussian quadrature (1 to 5)

alpha = zeros(n, 1);  % α_k
beta = zeros(n, 1);   % β_k

switch g_type
    case 1  % Legendre
        beta(1) = 2;
        for k = 2 : n
            beta(k) = 1 / (4 - 1 / (k - 1)^2);
        end

    case 2  % Chebyshev 1st kind
        beta(1) = pi;
        if n >= 2
            beta(2) = 0.5;
        end
        for k = 3 : n
            beta(k) = 0.25;
        end

    case 3  % Chebyshev 2nd kind
        beta(1) = pi / 2;
        for k = 2 : n
            beta(k) = 0.25;
        end

    case 4  % Laguerre (with a = 0)
        a = 0;
        for k = 1 : n
            alpha(k) = 2 * (k - 1) + a + 1;
        end
        beta(1) = gamma(1 + a);
        for k = 2 : n
            beta(k) = (k - 1) * ((k - 1) + a);
        end

    case 5  % Hermite
        beta(1) = sqrt(pi);
        for k = 2 : n
            beta(k) = (k - 1) / 2;
        end

    otherwise
        error('Invalid g_type (must be 1 to 5)');
end

% Jacobi matrix construction
J = diag(alpha) + diag(sqrt(beta(2:end)), 1) + diag(sqrt(beta(2:end)), -1);
[v, d] = eig(J);

g_nodes = diag(d);
[~, idx] = sort(g_nodes);
g_nodes = g_nodes(idx);
v = v(:, idx);
g_coeff = v(1, :)'.^2;

% Compute approximate integral
I = sum(g_coeff .* f(g_nodes));
end

