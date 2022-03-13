function new_im = convolve(im, kernel, paddings)

arguments
    im (:, :) 
    kernel 
    paddings {mustBeMember(paddings, {'both'})} = 'both'
end

% kernel = gaussian_mn([15, 15], 5); % defined in folder part2, need to add part2/ to path
kmn = (size(kernel) - 1 ) ./ 2;
km = kmn(1); 
kn = kmn(2);
% im = checkerboardP(1:5, 1:5);
[imm, imn] = size(im);
new_im = zeros(imm, imn);
pad_im = padarray(im, [km, kn], 0, paddings);

for i = 1:imm
    for j = 1:imn
        for p = 1: (km * 2 + 1)
            for q = 1: (kn * 2 + 1)
                new_im(i, j) = new_im(i, j) + kernel(p,q) * pad_im(i+p-1, j+q-1);
            end
        end
    end
end

% verifying if the result is correct with internal conv2 restult
verifying = (conv2(im, kernel, 'same') - new_im);
verifying_loss = sum(abs(verifying(:))) / prod(size(verifying))

end

