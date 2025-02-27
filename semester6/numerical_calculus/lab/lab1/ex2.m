for i = 1 : 3
    subplot(3, 1, i)
    fplot(@(x) sin(i*x), [0, 2*pi])
end
