cv_img = imread('../data/cv_cover.jpg');
desk_img = imread('../data/cv_desk.png');

[locs1, locs2] = matchPics(cv_img, desk_img);
[ H ] = computeH(locs2, locs1);
%[ H ] = computeH_norm(locs2, locs1);
%[ H, inliers ] = computeH_ransac(locs1, locs2);
%locs1 = locs1(inliers==1,:); 

random_NUM = 10;
randIndices = randperm(size(locs1,1), random_NUM );
Temp = zeros(random_NUM,2);
Temp(:,1) = locs1(randIndices,1);
Temp(:,2) = locs1(randIndices,2);

locs1 = Temp;

p1 = ones(3,size(locs1,1));
p1(1,:) = locs1(:,1);
p1(2,:) = locs1(:,2);    
p1 = inv(H) * p1;
p1 = p1./p1(3,:);

p2 = ones(2,size(locs1,1));
p2(1,:) = p1(1,:);
p2(2,:) = p1(2,:);

p2 = p2.'

showMatchedFeatures(cv_img, desk_img, locs1, p2, 'montage')