function boxf = box_blur(n)

arguments
    n double = 3
end

% n = 15
boxf = (zeros(n, n) + 1) / n / n;

end

