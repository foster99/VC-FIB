% Apartado 1a
A = [1 2 3 4 5];
B = [1 1 1]';
A.*B

% Apartado 1b
A = [-1 0 1 2]';
B = [1 1 1];
A.*B

% Apartado 2

x = [0:2*pi/30:2*pi];
y = -cos(x);
y(y<0) = 0;
plot(x,y)

% Apartado 3

[x y] = meshgrid(-15:1:15);
z = cos(sqrt(x.^2 + y.^2)/7.5);
z(z<0) = 0;
surf(x,y,z);
colormap hot;

%apartado 4

[x y] = meshgrid(-15:1:15);
z = cos(sqrt(x.^2 + y.^2)/7.5);
z(z<0) = 0;

d = [z z;z z];
[a,b] = meshgrid(0:1:61);

surf(a,b,d);
colormap default;

% apartado 5

x = linspace(0.85,1.85,100);
y = x - median(x) + 0.4*rand(1,100);

t=1;
alpha = -pi/4;
xm = x*cos(alpha) - y*sin(alpha);
ym = x*sin(alpha) + y*cos(alpha);

xm = xm - 1;
ym = ym + 0.8;

s = scatter(xm,ym,'filled')



