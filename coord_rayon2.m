function [mat_coordR, u] = coord_rayon2( p1, p2,A )
% Trouver les points du segment rayon 

% Calcul du nombre de points  (norme)
N=floor(sqrt( (p1(1)-p2(1))^2 + (p1(2)-p2(2))^2 ));

% Calcul de u 
u=0;
while u*95<N
    u=u+1;
end 

N=95*u; 

% Matrice contenant les coordonnées entières de chaque point
mat_coordR = [];

for i=0:N-1
    mat_coordR= [mat_coordR round(p1+i/(N-1)*(p2-p1))];
   
end

end

