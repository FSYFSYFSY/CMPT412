% Your solution to Q2.1.5 goes here!

%% Read the image and convert to grayscale, if necessary
Img1 = imread('../data/cv_cover.jpg');
Img1 = im2double(im2gray(Img1));
%% Compute the features and descriptors
count = [];
FT1 = detectFASTFeatures(Img1);
[desc1,locs1] = computeBrief(Img1,FT1.Location);    

for i = 0:14
    % Rotate image
    Rot_img = imrotate(Img1, (i)*10);
    % Compute features and descriptors
    R_FT1 = detectFASTFeatures(Rot_img);
    [Rdesc1,Rlocs1] = computeBrief(Rot_img,R_FT1.Location);
    % Match features
    indexPairs =  matchFeatures(desc1,Rdesc1,'MaxRatio',0.7,'MatchThreshold',10);
    matchedPoints1 = locs1(indexPairs(:,1),:);
    matchedPoints2 = Rlocs1(indexPairs(:,2),:);
    % Update histogram
    count = [count, size(indexPairs(:,1),1)];
    showMatchedFeatures(Img1,Rot_img,matchedPoints1,matchedPoints2,'montage');
end

% Display histogram
figure()
bar(count)


%% Compute the features and descriptors by Surf
count = [];
FT1 = detectSURFFeatures(Img1);
[desc1,locs1] = extractFeatures(Img1,FT1.Location, 'Method', 'SURF');    

for i = 0:36
    % Rotate image
    Rot_img = imrotate(Img1, (i)*10);
    % Compute features and descriptors
    R_FT1 = detectSURFFeatures(Rot_img);
    [Rdesc1,Rlocs1] = extractFeatures(Rot_img,R_FT1.Location, 'Method', 'SURF');
    % Match features
    indexPairs = matchFeatures(desc1, Rdesc1);
    matchedPoints1 = locs1(indexPairs(:,1),:);
    matchedPoints2 = Rlocs1(indexPairs(:,2),:);
    % Update histogram
    count = [count, size(indexPairs(:,1),1)];
    showMatchedFeatures(Img1,Rot_img,matchedPoints1,matchedPoints2,'montage');
end

% Display histogram
figure()
bar(count)