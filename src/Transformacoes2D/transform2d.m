
nx = 300;
ny = 200;
e = [10;10;10];
d = 10;
l = -10;
r = 10;
t = 10;
b = -10;
img = zeros(nx, ny, 3);
img2 = zeros(nx, ny, 3);
obj = {};

obj{1} = struct();
obj{1}.raio = 5;
obj{1}.centro = [30; 30; 30];
obj{1}.cor = [200; 45; 55];

w=e./norm(e); 
[~, k] = min(abs(w));
tmp=w;
tmp(k)=1;
u=cross(tmp,w)./norm(cross(tmp,w));
v=cross(u,w);

for i=1:1:nx
  for j=1:1:ny
    uu = l + (r - l)*(i + 0.5) / nx;
    vv = b + (t - b)*(j + 0.5) / ny;
    
    %Aqui, faço as transformações
    retval  = scale(2, 0.5)*rotation(30)*[uu; vv];
    retval2 = scale(2, 0.5)*rotation(30)*reflexy()*[uu; vv];
    
    dir = (-d*w) + u*retval(1) + v*retval(2);
    dir2 = (-d*w) + u*retval2(1) + v*retval2(2); 
    c = obj{1}.centro;
    raio = obj{1}.raio;
    
    delta  = (dot(2*dir, e - c)^2) - 4*dot(dir,dir)*(dot(e-c, e-c) - (raio^2));
    delta2 = (dot(2*dir2, e - c)^2) - 4*dot(dir2,dir2)*(dot(e-c, e-c) - (raio^2));
   
    if (delta >= 0) 
      img(i, j, 1) = obj{1}.cor(1);
      img(i, j, 2) = obj{1}.cor(2);
      img(i, j, 3) = obj{1}.cor(3);
    end
    
    if(delta2 >= 0)
      img2(i, j, 1) = obj{1}.cor(1);
      img2(i, j, 2) = obj{1}.cor(2);
      img2(i, j, 3) = obj{1}.cor(3);
    end
  end
end

subplot(1,2,1);
imshow(uint8(img));
subplot(1,2,2);
imshow(uint8(img2));
