function [min_depth,max_depth] = getminmaxdepth()
% read txt
filename = '../data/templeR_par.txt';
data = importdata(filename);
data = data.data;

% data,textdata

K1 = [data(1,1:3);data(1,4:6);data(1,7:9)];

R1 = [data(1,10:12);data(1,13:15);data(1,16:18)];

t1 = data(1,19:21)';

P1 = K1*[R1,t1];

% Load image and paramters
im1 = imread('../data/templeR0013.png');
% im11 = double(im1);

x = [-0.023121,0.078626];
y = [-0.038009,0.121636];
z = [-0.091940,-0.01739];



XYZ  =zeros(8,3);
nnn = 1;
for i  = 1:2
    for j = 1:2
        for k= 1:2
            XYZ(nnn,:) =[x(i),y(j),z(k)]; 
            nnn = nnn+1;
        end
    end
end

XYZ_tmp = [XYZ';ones(1,8)];

XY = P1*XYZ_tmp;
XY1 = XY./(XY(3,:));

min_depth = min(XY(3,:));
max_depth = max(XY(3,:));
figure;
imshow(im1);
hold on;
plot(XY1(1,:),XY1(2,:),'R*')
% select = 1./(XY(3,:));