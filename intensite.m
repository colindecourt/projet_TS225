function [ I ] = intensite( img, coord_rayon )
% Retourne une matrice contenant l'intensité de chaque pixel

% Image en nuances de gris
img_gris=double(255-rgb2gray(img));
I=[];

% Calcul de la matrice d'intensité
for k=1:length(coord_rayon)
    I = [I; img_gris(coord_rayon(2,k), coord_rayon(1,k))]; % Taille: x*y
end

end

