function [ locs1, locs2] = matchPics( I1, I2 )
%MATCHPICS Extract features, obtain their descriptors, and match them!
%% Convert images to grayscale, if necessary
% I1 = imread('../data/hp_cover.jpg');
% I2 = imread('../data/hp_desk.png');
Img1 = im2double(im2gray(I1));
Img2 = im2double(im2gray(I2));
%% Detect features in both images
FT1 = detectFASTFeatures(Img1);
FT2 = detectFASTFeatures(Img2);
%% Obtain descriptors for the computed feature locations
[desc1, locs1] = computeBrief(Img1, FT1.Location);
[desc2, locs2] = computeBrief(Img2, FT2.Location);
%% Match features using the descriptors
indexPairs = matchFeatures(desc1,desc2,'MaxRatio',0.66,'MatchThreshold',10);%default is 0.6

matchedPoints1 = locs1(indexPairs(:,1),:);
matchedPoints2 = locs2(indexPairs(:,2),:);

locs1 = matchedPoints1;
locs2 = matchedPoints2;

showMatchedFeatures(Img1,Img2,matchedPoints1,matchedPoints2,'montage');

end

