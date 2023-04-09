close all
clear variables 
book = loadVid('../data/book.mov');
ar_source = loadVid('../data/ar_source.mov');
image1 = imread('../data/cv_cover.jpg');
video = VideoWriter('../results/movie.avi');
open(video);
for i = 1: size(ar_source, 2)
    image2 = book(i).cdata;
    
    %applying ransac
    [locs1, locs2] = matchPics(image1, image2);
    [bestH2to1, ~] = computeH_ransac(locs1, locs2);
    
    %Crop the target video and move it onto othe one by mask the frame.
    image3 = ar_source(i).cdata;
    image3 = imcrop(image3, [45 45 size(image3, 2) size(image3, 1)-90]);
    scaled_hp = imresize(image3, [size(image1,1) size(image1,2)]);
    writeVideo(video, compositeH(inv(bestH2to1), scaled_hp, image2)); %inv(bestH2to1) 
    imshow(compositeH(inv(bestH2to1), scaled_hp, image2));%compositeH doing the mask and Homograph and replace.
end
close(video);
