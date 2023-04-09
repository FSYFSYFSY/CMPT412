function [H2to1] = computeH_norm(x1, x2)

%% Compute centroids of the points
centroid1 = mean(x1(:,1:2));
centroid2 = mean(x2(:,1:2));

%% Shift the origin of the points to the centroid
x1(:,1) = x1(:,1) - centroid1(1);
x1(:,2) = x1(:,2) - centroid1(2);
x2(:,1) = x2(:,1) - centroid2(1);
x2(:,2) = x2(:,2) - centroid2(2);
%% Normalize the points so that the average distance from the origin is equal to sqrt(2).
sum1 = x1(:,1).^2 + x1(:,2).^2;
sum1 = sqrt(sum1);
mean1 = mean(sum1);

sum2 = x2(:,1).^2 + x2(:,2).^2;
sum2 = sqrt(sum2);
mean2 = mean(sum2);

x1 = sqrt(2)*(x1/mean1);
x2 = sqrt(2)*(x2/mean2);

%% similarity transform 1
T1 = [1,0,-centroid1(1);0,1,-centroid1(2);0,0,1];
T1(1,:) = T1(1,:)* (sqrt(2)/mean1);
T1(2,:) = T1(2,:)* (sqrt(2)/mean1);

%% similarity transform 2
T2 = [1,0,-centroid2(1);0,1,-centroid2(2);0,0,1];
T2(1,:) = T2(1,:)* (sqrt(2)/mean2);
T2(2,:) = T2(2,:)* (sqrt(2)/mean2);

%% Compute Homography
[ H ] = computeH( x1, x2 );
%% Denormalization
H2to1 = T2\H*T1;
