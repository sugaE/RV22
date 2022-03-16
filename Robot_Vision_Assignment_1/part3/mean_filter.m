function new_im = mean_filter(I, W, H, paddings)

arguments
    I (:, :) 
    W double {mustBePositive, mustBeInteger} = 3
    H double {mustBePositive, mustBeInteger} = 3
    paddings {mustBeMember(paddings, {'both'})} = 'both'
end

km = (W - 1) / 2;
kn = (H - 1) / 2;
[imm, imn] = size(I);
new_im = zeros(imm, imn);
pad_im = padarray(I, [km, kn], 0, paddings);

for i = 1:imm
    for j = 1:imn
        for p = 1: W
            for q = 1: H 
                block = pad_im(i: i+p-1, j: j+q-1);
                new_im(i, j) = mean2(block);
            end
        end
    end
end


end

