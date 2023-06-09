function P = estimate_pose(x, X)
% ESTIMATE_POSE computes the pose matrix (camera matrix) P given 2D and 3D
% points.
%   Args:
%       x: 2D points with shape [2, N]
%       X: 3D points with shape [3, N]
total_points = size(x,2);
A = zeros(2 * total_points,12);
pts2d = x;
pts3d = X;

for i= 1:total_points
    x = pts3d(1,i);
    y = pts3d(2,i);
    z = pts3d(3,i);
    xd = pts2d(1,i);
    yd = pts2d(2,i);
    
    %Same as Homography matrix, projection
    A(2*i-1,:) = -[x,y,z,1,0,0,0,0,-xd*x,-xd*y,-xd*z,-xd];
    A(2*i,:) = -[0,0,0,0,x,y,z,1,-x*yd,-yd*y,-z*yd,-yd];
end
[~,~,V]=svd(A);

P = (reshape(V(:,end),4,3))';

end