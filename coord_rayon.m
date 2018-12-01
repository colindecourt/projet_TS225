function [mat_coordR] = coord_rayon( p1, p2,A )
% Trouver les points du segment rayon 

% Calcul du nombre de points 
N=floor(sqrt( (p1(1)-p2(1))^2 + (p1(2)-p2(2))^2 ));

% Matrice contenant les coordonnées entières de chaque point
mat_coordR = [];

for i=0:N-1
    mat_coordR= [mat_coordR round(p1+i/(N-1)*(p2-p1))];
   
end

end

