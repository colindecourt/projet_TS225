function [mat_coordR] = coord_rayon( p1, p2,N )
% Trouver N points du segment rayon 

% Matrice contenant les coordonnées entières de chaque point
mat_coordR = [];

for i=0:N-1
    mat_coordR= [mat_coordR round(p1+i/(N-1)*(p2-p1))];
   
end

end

