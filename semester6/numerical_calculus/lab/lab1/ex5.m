function ex5
    disp("f(2) = "),    disp(nestedFraction(2))
    disp("f(10) = "),   disp(nestedFraction(10))
    disp("f(100) = "),  disp(nestedFraction(100))
    disp("f(2025) = "), disp(nestedFraction(2025))
end

function val = nestedFraction(n)
    val = 2;  % f(0) = 2
    for k = 1:n
        val = 1 + 1/val;
    end
end
