function F = eightpoint(pts1, pts2, M)
% eightpoint:
%   pts1 - Nx2 matrix of (x,y) coordinates
%   pts2 - Nx2 matrix of (x,y) coordinates
%   M    - max (imwidth, imheight)

% Q2.1 - Todo:
%     Implement the eightpoint algorithm
%     Generate a matrix F from correspondence '../data/some_corresp.mat'
N = size(pts1, 1);
pts1_scale = pts1./M;
pts2_scale = pts2./M;

x1 = pts1_scale(:, 1);
x2 = pts2_scale(:, 1);
y1 = pts1_scale(:, 2); 
y2 = pts2_scale(:, 2);

%p1Fp2 = 0
A = [x1.*x2, x1.*y2, x1, y1.*x2, y1.*y2, y1, x2, y2, ones(N,1)];
[~,~,V] = svd(A);

%By definition, pick the least column of V
F = V(:,end);
F = reshape(F,3,3);

%Rank 2 constraint, only contain first two sigular values.
[U,S,V] = svd(F);
S(end) = 0;
F = U*S*V';

F_refine = refineF(F, pts1_scale,pts2_scale);
scaled = [1/M,0,0;0,1/M,0;0,0,1;];

F = scaled' * F_refine* scaled;
