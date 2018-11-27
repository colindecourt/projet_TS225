function [ I,mat_rayon] = rayon( p1, p2,A )
% Trouver les points du segment rayon 

% Calcul du nombre de points 
N=floor(sqrt( (p1(1)-p2(1))^2 + (p1(2)-p2(2))^2 ));

% Matrice contenant les coordonnées entières de chaque point
mat_rayon = [];

for i=0:N-1
    mat_rayon= [mat_rayon; round(p1+i/(N-1)*(p2-p1))];
   
end

% Intensité de chaque pointB
B=255-rgb2gray(A);
I=[];
for k=1:length(mat_rayon)
    I=[I B(mat_rayon(k,1), mat_rayon(k,2))];
end



end

