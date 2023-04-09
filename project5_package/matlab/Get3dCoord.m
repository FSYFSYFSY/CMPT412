function [XYZ] = Get3dCoord(xx,yy, P1, d)
%GET3DCOORD 此处显示有关此函数的摘要
%   此处显示详细说明

P1_tmp = P1(:,1:3);

d1 = d*xx-P1(1,4);
d2 = d*yy-P1(2,4);
d3 = d-P1(3,4);
d3 = d3*ones(1,size(d2,2));
d_sum = [d1;d2;d3];
XYZ = inv(P1_tmp)*d_sum;

end

