function [pts2] = epipolarCorrespondence(im1, im2, F, pts1)
% epipolarCorrespondence:
%   Args:
%       im1:    Image 1
%       im2:    Image 2
%       F:      Fundamental Matrix from im1 to im2
%       pts1:   coordinates of points in image 1
%   Returns:
%       pts2:   coordinates of points in image 2
%
points = zeros(size(pts1,1),2);
w = 20;

for i = 1:size(pts1,1)
    x1 = pts1(i,1);
    y1 = pts1(i,2);
    p1 = [x1;y1;1];

    epipolar_line = F*p1;
    epipolar_line = epipolar_line/-epipolar_line(2);

    least_dist = 10000000;

    window1 = double(im1((y1-w):(y1+w), (x1-w):(x1+w)));

    for j = x1(:,1)-30:x1(:,1)+30
        x2 = j;
        y2 = epipolar_line(1)*x2 + epipolar_line(3);
        p2 = [x2, y2, 1];
        window2 = double(im2((y2-w):(y2+w), (x2-w):(x2+w)));

        difference = window1-window2;
        difference = difference.^2;
        addition = sum(difference);
        addition = sum(addition);
        
        distance = sqrt(addition);
        
        if distance < least_dist
            least_dist = distance;
            points(i,1) = p2(1);
            points(i,2) = p2(2);
        end
    end
end
pts2 = points;
end