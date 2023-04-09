function [ bestH2to1, best_inlier] = computeH_ransac( locs1, locs2)
%COMPUTEH_RANSAC A method to compute the best fitting homography given a
%list of matching points.
total_points = size(locs1,1);
num_random_points = 4;


num_inliers = 0;
best_inlier = [];
total_iter = 10000;

for i = 1:total_iter
    
    current_inliers = zeros(1,total_points);
    
    F1 = zeros(num_random_points,2);
    F2 = zeros(num_random_points,2);
    
   random_pick = randperm(total_points,num_random_points);
   for j = 1:num_random_points
       F1(j,:) = locs1(random_pick(j),:);
       F2(j,:) = locs2(random_pick(j),:);
   end
    [ H ] = computeH_norm(F1, F2);

    p1 = ones(3,total_points);
    p1(1,:) = locs1(:,1);
    p1(2,:) = locs1(:,2);    
    p1 = H*p1;
    p1 = p1./p1(3,:);
    

    p2 = ones(3,total_points);
    p2(1,:) = locs2(:,1);
    p2(2,:) = locs2(:,2);

    difference = p1 - p2;
    
    x = difference(1,:).^2;
    y = difference(2,:).^2;
    difference = sqrt(x + y);


    inliers = 0;

    for k = 1:total_points
        if difference(k) < 10
            inliers = inliers+1;
            current_inliers(k) = 1; 
        end
    end
    
    if inliers > num_inliers
        num_inliers = inliers;
        best_inlier = current_inliers;
    end
end 
p1_new = locs1(best_inlier==1,:);
p2_new = locs2(best_inlier==1,:);
bestH2to1 = computeH_norm(p2_new,p1_new);


