function im2 = task1(im1, conv_x, conv_y, approxi, thr_d, file_prefix)
%TASK1 Summary of this function goes here

im2 = [];

% Step2:
shakey_sobelX = conv2(im1, conv_x, "same");
shakey_sobelY = conv2(im1, conv_y, "same");

% show_image(abs(shakey_sobelX)>50);
% Task1:
if approxi == 1
    m = magnitude_approxi(shakey_sobelX, shakey_sobelY);
elseif approxi == -1
    m = shakey_sobelX;
elseif approxi == -2
    m = shakey_sobelY;
else 
    m = magnitude(shakey_sobelX, shakey_sobelY);
end
 

% guessing threshold around mean
% mm = mean(m(:))
% im2=[]; % abs(m)
% show_image(abs(m))
% title(['threshold: ', 'none']) 
% tt=[mm/4 mm/2 mm mm*2 mm*4];
% for t=tt
%     show_image(abs(m) >t)
%     title(['threshold: ', num2str(t)]);
% end  


% systematic way of finding better threshold for segment fg & bg
i = 1
d=10000
mean_last = mean(m(:)) 

% before threshold
new_im = abs(m)
im2 = cat(3, im2, new_im/mean_last);
show_image(new_im, [file_prefix , '0-0']);

if ~~thr_d

    % to compare
    new_im = abs(m) > mean_last/2; 
    im2 = cat(3, im2, new_im);
    show_image(new_im, [file_prefix , '0-', num2str(mean_last/2)]);
    
    while d > thr_d & i < 10
        new_im = abs(m) > mean_last; 
        im2 = cat(3, im2, new_im); 
        show_image(new_im, [file_prefix , num2str(i),'-', num2str(mean_last)]);
        i = i + 1
        mean_fg = mean2(m(new_im));
        mean_bg = mean2(m(~new_im));
        mean_avg = (mean_bg + mean_fg) / 2;
        d = abs(mean_avg - mean_last)
        mean_last = mean_avg
    end
    
    new_im = abs(m) > mean_last; 
    im2 = cat(3, im2, new_im);
    show_image(new_im, [file_prefix , num2str(i),'-', num2str(mean_last)]);

end

end

