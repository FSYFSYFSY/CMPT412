
clear all ;
close all;


% read txt
filename = '../data/templeR_par.txt';
data = importdata(filename);
data = data.data;

% data,textdata

K1 = [data(1,1:3);data(1,4:6);data(1,7:9)];
K2 = [data(2,1:3);data(2,4:6);data(2,7:9)];
K3 = [data(3,1:3);data(3,4:6);data(3,7:9)];
K4 = [data(4,1:3);data(4,4:6);data(4,7:9)];
K5 = [data(5,1:3);data(5,4:6);data(5,7:9)];


R1 = [data(1,10:12);data(1,13:15);data(1,16:18)];
R2 = [data(2,10:12);data(2,13:15);data(2,16:18)];
R3 = [data(3,10:12);data(3,13:15);data(3,16:18)];
R4 = [data(4,10:12);data(4,13:15);data(4,16:18)];
R5 = [data(5,10:12);data(5,13:15);data(5,16:18)];

t1 = data(1,19:21)';
t2 = data(2,19:21)';
t3 = data(3,19:21)';
t4 = data(4,19:21)';
t5 = data(5,19:21)';

P1 = K1*[R1,t1];
P2 = K2*[R2,t2];
P3 = K3*[R3,t3];
P4 = K4*[R4,t4];
P5 = K5*[R5,t5];

% Load image and paramters
im1 = imread('../data/templeR0013.png');
im2 = imread('../data/templeR0014.png');
im3 = imread('../data/templeR0016.png');
im4 = imread('../data/templeR0043.png');
im5 = imread('../data/templeR0045.png');

gray1 = rgb2gray(im1);
BW1 = imbinarize(gray1);
% imshow(BW1)

S = 5;
ss = (S-1)/2;

% [min_depth,min_depth] = getminmaxdepth()
% [] = getminmaxdepth();
% [minx,miny,minz]=[- 0.023121 -0.038009 -0.091940]
[min_depth,max_depth] = getminmaxdepth();
% min_depth = 1;
% max_depth = 10;
depth_step = 0.01;

im1_tmp = im2double(im1);
im2_tmp = im2double(im2);
im3_tmp = im2double(im3);
im4_tmp = im2double(im4);



depthmap1 = zeros(size(BW1));

[r,c] = find(BW1~=0);
for i = 1:length(c)
    i
    yy = (r(i)-ss:r(i)+ss)';
    xx = c(i)-ss:c(i)+ss;
    xx = repmat(xx,S,1);
    yy = repmat(yy,1,S);
    xx = xx(:)';
    yy = yy(:)';
%     P = im1_tmp(xx-ss:xx+ss,yy-ss:yy+ss,:);

    d1 = min_depth:depth_step:max_depth;
    scores = zeros(length(d1),1);
    qq  = 1;
    for d = d1
%         X = zeros(3,S*S);
        X = Get3dCoord(xx,yy, P1, d);
%         nnn = 1;
%             for ii = 1:S
%                 for jj = 1:S
%                     XYZ = Get3dCoord(xx(ii),yy(ii), P1, d);
%                     X(:,nnn) = XYZ;
%                     nnn = nnn +1;                    
%                 end
%             end
         result1 = ComputeConsistency(im1_tmp,im2_tmp,X,P1,P2);
         result2 = ComputeConsistency(im1_tmp,im3_tmp,X,P1,P2);
         result3 = ComputeConsistency(im1_tmp,im4_tmp,X,P1,P2);
        scores(qq) = mean([result1,result2,result3]);
        qq = qq+1;
    end
    
    [maxs,I] = max(scores);
    I
    if maxs>0.2
        depthmap1(r(i),c(i)) = d1(I);
    end
end


figure; imagesc(depthmap1.*(im1>40)); colormap(gray); axis image;