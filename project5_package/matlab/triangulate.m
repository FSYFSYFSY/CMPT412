function pts3d = triangulate(P1, pts1, P2, pts2 )
% triangulate estimate the 3D positions of points from 2d correspondence
%   Args:
%       P1:     projection matrix with shape 3 x 4 for image 1
%       pts1:   coordinates of points with shape N x 2 on image 1
%       P2:     projection matrix with shape 3 x 4 for image 2
%       pts2:   coordinates of points with shape N x 2 on image 2
%
%   Returns:
%       Pts3d:  coordinates of 3D points with shape N x 3
%
    pts3d = [zeros(size(pts1)), zeros(size(pts1,1),2)];
    p_size = size(pts1,1);
    p = [pts1'; ones(1,p_size)];
    p_2 = [pts2'; ones(1,p_size)];

    for i = 1: size(pts1,1)
    x = pts1(i,1);
    y = pts1(i,2);
    xd = pts2(i,1);
    yd = pts2(i,2);
    A = [y.*P1(3,:) - P1(2,:); 
        P1(1,:) - x.*P1(3,:); 
        yd.*P2(3,:) - P2(2,:); 
        P2(1,:) - xd.*P2(3,:)];
    [~,~,v] = svd(A);
    X = v(:,end).';
    pts3d(i,:) = X/X(4);
    end

    p3d = pts3d(:,:).';
    pts3d = pts3d(:,1:3);

    %Project the 3d coor back to 2d by P1 P2
    pts_err1 = 0;
    pts_err2 = 0;
    re_pro1 = P1*p3d;
    re_pro2 = P2*p3d;
    
    %Compute the error by each pixel
    for j = 1:size(re_pro1,2)
        %normalization
        re_pro1(:,j) = re_pro1(:,j)/re_pro1(3,j);
        re_pro2(:,j) = re_pro2(:,j)/re_pro2(3,j);
        
        single_error1 = sqrt((p(1,j)-re_pro1(1,j)).^2 + (p(2,j)-re_pro1(2,j)).^2 );
        pts_err1 = pts_err1 + single_error1;
        
        single_error2 = sqrt((p_2(1,j)-re_pro2(1,j)).^2 + (p_2(2,j)-re_pro2(2,j)).^2 );
        pts_err2 = pts_err2 + single_error2;
    end
    
    %Average error
    avgerr1 = pts_err1/size(re_pro1,2)
    avgerr2 = pts_err2/size(re_pro2,2)
end
