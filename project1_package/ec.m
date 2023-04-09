layers = get_lenet();
layers{1, 1}.batch_size = 10;
load lenet.mat

I = imread('..imagesimage1.jpg');
I = im2double(im2gray(I))';
se = strel('disk',200);
background = imopen(I,se);
%imshow(background');
I2 = I - background;
%imshow(I2')
I3 = imadjust(I2);
%imshow(I3');
bw = imbinarize(I3);
bw = bwareaopen(bw,50);
bw = abs(bw - 1);
%imshow(bw')
L = bwlabel(bw,4);

for a = 110
    [r, c] = find(L==a);
    rc = [r, c];
    for i = min(r)  max(r)
        for j = min(c)  max(c)
            B(i - min(r) + 1, j - min(c) + 1) = bw(i, j);
        end
    end
    B = imresize(B, [20, 20]);
    B = padarray(B, [4, 4], 0, 'both');
    my_xtest1(, a) = reshape(B, 784, 1);
end

[output, my_P] = convnet_forward(params, layers, my_xtest1(, 110));
[~, my_prediction] = max(my_P, [], 1);
my_prediction = my_prediction - 1;


I_trans = I';
for a = 110
    [r, c] = find(L==a);
    I_trans = insertText(I_trans, [min(r), min(c)], my_prediction(a), 'FontSize', 40);
    I_trans = insertShape(I_trans, 'Rectangle', [min(r), min(c), max(r)-min(r), max(c)-min(c)]);
end
figure(1)
imshow(I_trans);

%%
layers = get_lenet();
layers{1, 1}.batch_size = 10;
load lenet.mat
I = imread('..imagesimage2.jpg');
I = im2double(im2gray(I))';
se = strel('disk',200);
background = imopen(I,se);
%imshow(background');
I2 = I - background;
%imshow(I2')
I3 = imadjust(I2);
%imshow(I3');
bw = imbinarize(I3);
bw = bwareaopen(bw,50);
bw = abs(bw - 1);
%imshow(bw')
L = bwlabel(bw,4);

for a = 110
    [r, c] = find(L==a);
    rc = [r, c];
    for i = min(r)  max(r)
        for j = min(c)  max(c)
            B(i - min(r) + 1, j - min(c) + 1) = bw(i, j);
        end
    end
    B = imresize(B, [20, 20]);
    B = padarray(B, [4, 4], 0, 'both');
    my_xtest2(, a) = reshape(B, 784, 1);
end

[output, my_P] = convnet_forward(params, layers, my_xtest2(, 110));
[~, my_prediction] = max(my_P, [], 1);
my_prediction = my_prediction - 1;


I_trans = I';
for a = 110
    [r, c] = find(L==a);
    I_trans = insertText(I_trans, [min(r), min(c)], my_prediction(a), 'FontSize', 40);
    I_trans = insertShape(I_trans, 'Rectangle', [min(r), min(c), max(r)-min(r), max(c)-min(c)]);
end
figure(2)
imshow(I_trans);


%%
layers = get_lenet();
layers{1, 1}.batch_size = 5;
load lenet.mat
I = imread('..imagesimage3.png');
I = im2double(im2gray(I))';
se = strel('disk',200);
background = imopen(I,se);
%imshow(background');
I2 = I - background;
%imshow(I2')
I3 = imadjust(I2);
%imshow(I3');
bw = imbinarize(I3);
bw = bwareaopen(bw,50);
bw = abs(bw - 1);
%imshow(bw')
L = bwlabel(bw,4);

for a = 110
    [r, c] = find(L==a);
    rc = [r, c];
    for i = min(r)  max(r)
        for j = min(c)  max(c)
            B(i - min(r) + 1, j - min(c) + 1) = bw(i, j);
        end
    end
    B = imresize(B, [20, 20]);
    B = padarray(B, [4, 4], 0, 'both');
    my_xtest3(, a) = reshape(B, 784, 1);
end

[output, my_P] = convnet_forward(params, layers, my_xtest3(, 15));
[~, my_prediction] = max(my_P, [], 1);
my_prediction = my_prediction - 1;

I_trans = I';
for a = 15
    [r, c] = find(L==a);
    I_trans = insertText(I_trans, [min(r), min(c)], my_prediction(a));
    I_trans = insertShape(I_trans, 'Rectangle', [min(r), min(c), max(r)-min(r), max(c)-min(c)]);
end
figure(3)
imshow(I_trans);


%%
layers = get_lenet();
layers{1, 1}.batch_size = 52;
load lenet.mat
I = imread('..imagesimage4.jpg');
I = im2double(im2gray(I))';
se = strel('disk',19);
background = imopen(I,se);
%imshow(background');
I2 = I - background;
%imshow(I2')
I3 = imadjust(I2);
%imshow(I3');
bw = imbinarize(I3);
bw = bwareaopen(bw,50);
bw = abs(bw - 1);
imshow(bw')


L = bwlabel(bw,4);

for a = 152
    [r, c] = find(L==a);
    rc = [r, c];
    for i = min(r)  max(r)
        for j = min(c)  max(c)
            B(i - min(r) + 1, j - min(c) + 1) = bw(i, j);
        end
    end
    B = imresize(B, [20, 20]);
    B = padarray(B, [4, 4], 0, 'both');
    my_xtest4(, a) = reshape(B, 784, 1);
end


[output, my_P] = convnet_forward(params, layers, my_xtest4(, 152));
[~, my_prediction] = max(my_P, [], 1);
my_prediction = my_prediction - 1;


I_trans = I';
for a = 152
    [r, c] = find(L==a);
    I_trans = insertText(I_trans, [min(r), min(c)], my_prediction(a));
    I_trans = insertShape(I_trans, 'Rectangle', [min(r), min(c), max(r)-min(r), max(c)-min(c)]);
end
figure(4)
imshow(I_trans);