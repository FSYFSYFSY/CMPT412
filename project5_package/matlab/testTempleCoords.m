% A test script using templeCoords.mat
%
% Write your code here
%

% save extrinsic parameters for dense reconstruction
im1 = imread('../data/im1.png');
im2 = imread('../data/im2.png');
im1 = rgb2gray(im1);
im2 = rgb2gray(im2);
load('../data/someCorresp.mat', 'M','pts1', 'pts2');
F = eightpoint(pts1, pts2, M);

templeCoords = load('../data/templeCoords.mat');
im1_pts1 = templeCoords.pts1;
im1_pts2 = epipolarCorrespondence(im1, im2, F, im1_pts1);

intrinsics = load('../data/intrinsics.mat');
K1 = intrinsics.K1;
K2 = intrinsics.K2;
E = essentialMatrix(F, K1, K2)

identity = [1,0,0,0;0,1,0,0;0,0,1,0];
P1 = K1* identity;
P2_candidates = camera2(E);
 
max_depth = -inf;

for i = 1:4
    P2 = K2*P2_candidates(:,:,i);
    pts3d = triangulate(P1, im1_pts1, P2, im1_pts2 );
    if max_depth <= sum(pts3d(:,3)>0)
        max_depth = sum(pts3d(:,3)>0);
        plot_y = pts3d;
        proj = i;
    end
end

plot3(plot_y(:, 1), plot_y(:, 3), -plot_y(:, 2), '.'); 
axis equal

R1 = [1,0,0;0,1,0;0,0,1];
t1 = [0;0;0];
R2 = P2_candidates(:, 1:3, proj);
R2 (1:3,2) = -R2 (1:3,2); 
R2 (1:3,3) = -R2 (1:3,3);
t2 = P2_candidates(:, 4, proj);

save('../data/extrinsics.mat', 'R1', 't1', 'R2', 't2');
