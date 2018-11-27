nx = 100;
ny = 100;
e = [0.5;0.5;0.5];
d = 10;
l = -10;
r = 10;
t = 10;
b = -10;
m = zeros(nx, ny, 3);
obj = {};

obj{1} = struct();
obj{1}.centro = [30;30;30];
obj{1}.raio = 3;
obj{1}.cor = [20, 10, 200];
obj{1}.tipo = 'esfera';

w = e/norm(e);
[~, p] = min(abs(w));
tmp=w;
tmp(p) = 1;
tmpxw = cross(tmp, w);
u=tmpxw./norm(tmpxw);
v=cross(u,w);

%Caso Oblíquo

for i=1:1:nx 
    for j=1:1:ny 
        u_ = l + (r-l)*(0.5+i)/nx;
        v_ = b + (t-b)*(0.5+j)/ny;
        
        origem = e;
        direcao = (d*w) + (u_ * u) + (v_ * v);
        
        delta = (dot(2*direcao, (origem - obj{1}.centro))^2 - 4*dot(direcao, direcao)*(dot(origem-obj{1}.centro, origem-obj{1}.centro) - obj{1}.raio^2));
        
        if(delta >= 0)
            m(i,j,1) = obj{1}.cor(1);
            m(i,j,2) = obj{1}.cor(2);
            m(i,j,3) = obj{1}.cor(3);
        end
    end
end

imshow(uint8(m));

%Caso Ortográfico
%
% m = zeros(nx, ny, 3);
% 
% for i=1:1:nx 
%     for j=1:1:ny 
%         u_ = l + (r-l)*(0.5+i)/nx;
%         v_ = b + (t-b)*(0.5+j)/ny;
%         
%         origem = e + u_ * u + v_ * v;
%         direcao = -w;
%         
%         delta = (dot(2*direcao, (origem - obj{1}.centro))^2 - 4*dot(direcao, direcao)*(dot(origem-obj{1}.centro, origem-obj{1}.centro) - obj{1}.raio^2));
%         
%         if(delta >= 0)
%             m(i,j,1) = obj{1}.cor(1);
%             m(i,j,2) = obj{1}.cor(2);
%             m(i,j,3) = obj{1}.cor(3);
%         end
%     end
% end
% 
% imshow(uint8(m));

 