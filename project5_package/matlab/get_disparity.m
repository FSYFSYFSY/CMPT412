function dispM = get_disparity(im1, im2, maxDisp, windowSize)
% GET_DISPARITY creates a disparity map from a pair of rectified images im1 and
%   im2, given the maximum disparity MAXDISP and the window size WINDOWSIZE.
mask = ones(windowSize, windowSize);

dist = zeros(size(im1,1),size(im1,2));

disparity = zeros(size(im1,1),size(im1,2), maxDisp+1);


for i = 0:maxDisp

    rows = size(im1,1);
    cols = size(im1,2);
    
    %how much pixel we need to compute
    total_dis = 1: (rows * (cols - i));

    %move images by i
    move_img1 = im1(total_dis + rows*i);
    move_img2 = im2(total_dis);
    dist(total_dis) = (move_img1 - move_img2).^2;

    %compute dispM
    disparity(:,:,i+1) = conv2(dist,mask,'same');   
end

[~, index] = min(disparity, [], 3);
dispM = index-1;

end