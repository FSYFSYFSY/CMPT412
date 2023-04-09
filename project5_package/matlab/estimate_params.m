function [K, R, t] = estimate_params(P)
% ESTIMATE_PARAMS computes the intrinsic K, rotation R and translation t from
% given camera matrix P.

[~,~,V] = svd(P);
C = V(:,end);
C = C(1:3)/C(end);
A = P(1:3,1:3);
if det(A) ~= 0
    a1 = -A(3,3)/sqrt(A(3,2)*A(3,2)+A(3,3)*A(3,3));
    a2 = A(3,2)/sqrt(A(3,2)*A(3,2)+A(3,3)*A(3,3));
    Q3dx = [1,0,0; 0,a1,-a2; 0,a2,a1];
    A = A*Q3dx;

    a1 = A(3,3)/sqrt(A(3,1)*A(3,1)+A(3,3)*A(3,3));
    a2 = A(3,1)/sqrt(A(3,1)*A(3,1)+A(3,3)*A(3,3));
    Q3dy = [a1,0,a2; 0,1,0; -a2,0,a1];
    A = A*Q3dy;

    a1 = -A(2,2)/sqrt(A(2,1)*A(2,1)+A(2,2)*A(2,2));
    a2 = A(2,1)/sqrt(A(2,1)*A(2,1)+A(2,2)*A(2,2));
    Q3dz = [a1,-a2,0; a2,a1,0; 0,0,1];
    A = A*Q3dz;
    K = A;
    
    R = Q3dz'*Q3dy'*Q3dx';
end
t = -R*C;
end


