
function h = gaussian_dervative(sigma,theta)

% kernel size
 n = 10;
r=[cos(theta) -sin(theta);
   sin(theta)  cos(theta)];
for i = 1 : n 
    for j = 1 : n
        u = r * [j-(n+1)/2 i-(n+1)/2]';
        h(i,j) = gauss(u(1),sigma)*dgauss(u(2),sigma);
    end
end
h = h / sqrt(sum(sum(abs(h).*abs(h))));

% Function "gauss.m":
function y = gauss(x,std)
y = exp(-x^2/(2*std^2)) / (std*sqrt(2*pi));

% Function "dgauss.m"(first order derivative of gauss function):
function y = dgauss(x,std)
y = -x * gauss(x,std) / std^2;


