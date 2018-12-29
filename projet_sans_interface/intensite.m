function [ I ] = intensite( img, coord_rayon )
% Retourne une matrice contenant l'intensité de chaque pixel

I=[];

% Calcul de la matrice d'intensité
for k=1:length(coord_rayon)
    I = [I; img(coord_rayon(2,k), coord_rayon(1,k))]; %Taille : u*length(coord_rayon) x 1
end

end

