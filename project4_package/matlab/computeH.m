function [ H2to1 ] = computeH(x1, x2)

n = size(x1, 1);
if ~isequal(size(x1), size(x2))
    error('Points matrices different sizes');
end
if size(x1, 2) ~= 2
    error('Points matrices must have two columns');
end
if n < 4
    error('Need at least 4 matching points');
end

H = zeros(2*n,9);
for i = 1:n
    x = x1(i,1);
    y = x1(i,2);
    xd = x2(i,1);
    yd = x2(i,2);
    
    H(2*i-1,:) = -[x,y,1,0,0,0,-x*xd, -xd*y,-xd];
    H(2*i,:) = -[0,0,0,x,y,1,-x*yd,-yd*y,-yd];
end

[~, ~, V] = svd(H);

[H2to1] = reshape(V(:,end), 3, 3)';
end


