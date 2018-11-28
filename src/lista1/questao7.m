%Considerando o ponto de visão (camera frame) e localizado em (2, 2, 3) em relação ao
%sistema de coordenadas global, quais as expressões da direção e origem dos raios utilizando uma visão
%ortográfica com plano da imagem na origem do sistema de coordenadas? Considere uma imagem raster
%de tamanho 640 × 480 e que o plano da imagem é formado pelo retângulo cujos limites são: l = 2, r = 10,
%b = −3 e t = 20.

%Entrada
Nx = 640;
Ny = 480;

l = 2;
r = 10;
b = -3;
t = 20;

e = [2 2 3];
d = 4;

obj = {};
obj{1} = struct();
obj{1}.centro = [2 2 1];
obj{1}.raio = 3;
obj{1}.cor = [1,2,3];
obj{1}.tipo = 'esfera';

m = zeros(Nx,Ny,3);

%Construção das bases dos objetos
w = e / norm(e);
tmp = w;
[value,index] = min(tmp(:));
tmp(index) = 1;
u = cross(tmp, w) / norm(cross(tmp, w));
v = cross(u,w);

%Calculo do Raio
for i=1:Nx
  for j=1:Ny
    
    u_ = (l + (r - l)*(0.5 + i)) / Nx;
    v_ = (b + (t - b)*(0.5 + j)) / Ny;
        
    %Caso Obliquo
    
    origem = e;
    direcao = (-d*w) + (u_*u) + (v_*v);
  
    %Caso Ortografico 
    
%    origem = e + (u_*u) + (v_*v);
%    direcao = -w;
    
    delta = (dot((2*direcao),(origem - obj{1}.centro))^2 - 4*dot(direcao, direcao)*(dot(origem-obj{1}.centro, origem-obj{1}.centro) - obj{1}.raio^2));
   %delta = (dot((2*direcao),(origem - obj{1}.centro))^2 - 4*dot(direcao, direcao)*(dot(origem-obj{1}.centro, origem-obj{1}.centro) - obj{1}.raio^2));
        
    if (i == 3 && j == 4) 
      origem 
      direcao
      delta
    end
        
    if(delta >= 0)
      m(i,j,1) = obj{1}.cor(1);
      m(i,j,2) = obj{1}.cor(2);
      m(i,j,3) = obj{1}.cor(3);
    end

  end
end

imshow(uint8(m));