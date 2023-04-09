function I = RealWorldImage(n)
I = cell(1,n);
for i = 1:n
    imageName = strcat(num2str(i),'.jpg');
    Image = im2double(rgb2gray(imread(imageName)));
    I{i} = reshape(Image(1:28,1:28),784,1);
end
end
