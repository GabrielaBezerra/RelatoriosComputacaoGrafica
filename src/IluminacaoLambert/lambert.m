nx = 1000;
ny = 1000;
e = [0.3;0.3;0.3];
d = 35;#/10;
l = -10;#/10;
r = 10;#/10;
t = 10;#/10;
b = -10;#/10;
m1 = zeros(nx, ny, 3);
m2 = zeros(nx, ny, 3);
obj = {};

obj{1} = struct();
#obj{1}.centro = [30/10;30/10;30/10];
obj{1}.centro = [30;30;30];
obj{1}.raio = 10;#/10;
obj{1}.cor = [20, 10, 200];
obj{1}.tipo = 'esfera';

obj{2} = struct();
#obj{2}.centro = [30/10;30/10;20/10];
obj{2}.centro = [30;30;25];
obj{2}.raio = 4;#/10;
obj{2}.cor = [10, 200, 20];
obj{2}.tipo = 'esfera2';


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
          #posluz = [200/10;100/10;-60/10];
          #posluz = [20/10;80/10;80/10];
          posluz = [20;80;80];
          
          T1 = (-B + sqrt(delta))/A;
          T2 = (-B - sqrt(delta))/A;

          T = min(T1,T2);          
          
          P = origem + T*direcao;   
          
          normal = (P - obj{1}.centro) / obj{1}.raio;  
          
          luz = posluz - P; 
          ilumi = 1;
          
          uniLuz = luz/norm(luz);
          uniVis = w;
          
          red = obj{1}.cor(1);
          Lred = 100 * ilumi * max(0, dot(normal,uniLuz));
          
          green = obj{1}.cor(2);
          Lgreen = 0 * ilumi * max(0, dot(normal,uniLuz));
          
          blue = obj{1}.cor(3);
          Lblue = 255 * ilumi * max(0, dot(normal,uniLuz));
                    
          m1(i,j,1) = Lred;
          m1(i,j,2) = Lgreen;
          m1(i,j,3) = Lblue;  
          
        end   
    end
end

for i=1:nx 
    for j=1:ny 
        u_ = l + (r-l)*(0.5+i)/nx;
        v_ = b + (t-b)*(0.5+j)/ny;
        
        origem = e;
        direcao = (d*w) + (u_ * u) + (v_ * v);
        
        A = dot(direcao, direcao);
        B = dot(2*direcao, (origem - obj{2}.centro));
        C = (dot(origem-obj{2}.centro, origem-obj{2}.centro) - obj{2}.raio^2);
        
        delta = B^2 - 4*A*C;
              
        %Raio intercepta esfera
        if(delta >= 0)
        
          %SHADING
          #posluz = [200/10;100/10;-60/10];
          #posluz = [20/10;80/10;80/10];
          posluz = [20;80;80];
          
          T1 = (-B + sqrt(delta))/A;
          T2 = (-B - sqrt(delta))/A;

          T = min(T1,T2);          
          
          P = origem + T*direcao;   
          
          normal = (P - obj{2}.centro) / obj{2}.raio;  
          
          luz = posluz - P; 
          ilumi = -10;
          
          uniLuz = luz/norm(luz);
          uniVis = w;
          
          red = obj{2}.cor(1);
          Lred = 100 * ilumi * max(0, dot(normal,uniLuz));
          
          green = obj{2}.cor(2);
          Lgreen = 255 * ilumi * max(0, dot(normal,uniLuz));
          
          blue = obj{2}.cor(3);
          Lblue = 0 * ilumi * max(0, dot(normal,uniLuz));
                    
          m2(i,j,1) = Lred; #- m1(i,j,1);
          m2(i,j,2) = Lgreen; #- m1(i,j,2);
          m2(i,j,3) = Lblue;  #- m1(i,j,3);  
          
        end
    end
end

m = m1 + m2;

imshow(uint8(m));