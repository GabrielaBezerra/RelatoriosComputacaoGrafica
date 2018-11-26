nx = 1000;
ny = 1000;
e = [5;5;5];
d = 10;
l = -10;
r = 10;
t = 10;
b = -10;
m = zeros(nx, ny, 3);
obj = {};

obj{1} = struct();
obj{1}.centro = [30;30;30];
obj{1}.raio = 10;
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

for i=1:nx 
    for j=1:ny 
        u_ = l + (r-l)*(0.5+i)/nx;
        v_ = b + (t-b)*(0.5+j)/ny;
        
        origem = e;
        direcao = (d*w) + (u_ * u) + (v_ * v);
        
        A = dot(direcao, direcao);
        B = dot(2*direcao, (origem - obj{1}.centro));
        C = (dot(origem-obj{1}.centro, origem-obj{1}.centro) - obj{1}.raio^2);
        
        delta = B^2 - 4*A*C;
              
        %Raio intercepta esfera
        if(delta >= 0)
        
          %SHADING
          posluz = [20;200;-10];
          
          T1 = (-B + sqrt(delta))/A;
          T2 = (-B - sqrt(delta))/A;

          T = min(T1,T2);          
          
          P = origem + T*direcao;   
          
          normal = (P - obj{1}.centro) / obj{1}.raio;  
          
          luz = P - posluz; 
          ilumi = 1;
          
          uniLuz = luz/norm(luz);
          uniVis = w;
          
          red = obj{1}.cor(1);
          Lred = 100 * ilumi * max(0, dot(normal,uniLuz));
          
          green = obj{1}.cor(2);
          Lgreen = 0 * ilumi * max(0, dot(normal,uniLuz));
          
          blue = obj{1}.cor(3);
          Lblue = 255 * ilumi * max(0, dot(normal,uniLuz));
                    
          m(i,j,1) = Lred;
          m(i,j,2) = Lgreen;
          m(i,j,3) = Lblue;
          
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

 