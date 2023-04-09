function result = ComputeConsistency(I0,I1,X,P0,P1)
%COMPUTECONSISTENCY �˴���ʾ�йش˺�����ժҪ
%   �˴���ʾ��ϸ˵��
n = size(X,2);
X_tmp = [X;ones(1,n)];

x = P0*X_tmp;
x = x./(x(3,:));
% x = x(1:2,:);
x0 = round(x(1:2,:));

x = P1*X_tmp;
x = x./(x(3,:));
% x = x(1:2,:);
x1 = round(x(1:2,:));

R = I0(:,:,1);
G = I0(:,:,2);
B = I0(:,:,3);

inx = sub2ind(size(R), x0(2,:), x0(1,:));
R_C0 = R(inx);
G_C0 = G(inx);
B_C0 = B(inx);

% R_C0 = reshape(R_C0,S,S);
% G_C0 = reshape(G_C0,S,S);
% B_C0 = reshape(B_C0,S,S);

% C0 =cat(3,R_C0,G_C0,B_C0);

C0 = [R_C0;G_C0;B_C0];


R = I1(:,:,1);
G = I1(:,:,2);
B = I1(:,:,3);

inx = sub2ind(size(R), x1(2,:), x1(1,:));
R_C0 = R(inx);
G_C0 = G(inx);
B_C0 = B(inx);

% R_C0 = reshape(R_C0,S,S);
% G_C0 = reshape(G_C0,S,S);
% B_C0 = reshape(B_C0,S,S);
C1 = [R_C0;G_C0;B_C0];
% C1 =cat(3,R_C0,G_C0,B_C0);
result = NormalizedCrossCorrelation(C0,C1);
end


function diff = NormalizedCrossCorrelation(C0,C1)


C0_mean = mean(C0,2);
C0_mean = repmat(C0_mean,1,size(C0,2));
C0_sum = sqrt(sum((C0-C0_mean).^2,2));

C1_mean = mean(C1,2);
C1_mean = repmat(C1_mean,1,size(C1,2));
C1_sum = sqrt(sum((C1-C1_mean).^2,2));

diff = C0_sum'*C1_sum;
% % C0_a = mean(C0,3);
% C0_R = C0(:,:,1);
% C0_G = C0(:,:,2);
% C0_B = C0(:,:,3);
% 
% C0_R_mean =mean(C0_R(:));
% C0_G_mean =mean(C0_G(:));
% C0_B_mean =mean(C0_B(:));
% 
% C0_R1 = sum(sum((C0_R - C0_R_mean).^2));
% C0_G1 = sum(sum((C0_G - C0_G_mean).^2));
% C0_B1 = sum(sum((C0_B - C0_B_mean).^2));
% 
% C0_v = [C0_R1,C0_G1,C0_B1];


% %
% C0_R = C1(:,:,1);
% C0_G = C1(:,:,2);
% C0_B = C1(:,:,3);
% 
% C0_R_mean =mean(C0_R(:));
% C0_G_mean =mean(C0_G(:));
% C0_B_mean =mean(C0_B(:));
% 
% C0_R1 = sqrt(sum(sum((C0_R - C0_R_mean).^2)));
% C0_G1 = sqrt(sum(sum((C0_G - C0_G_mean).^2)));
% C0_B1 = sqrt(sum(sum((C0_B - C0_B_mean).^2)));
% 
% C1_v = [C0_R1,C0_G1,C0_B1];
% 
% diff = C0_v*C1_v';
end

