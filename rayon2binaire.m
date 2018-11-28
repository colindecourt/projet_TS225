function [extremite] = rayon2binaire(mat_intensite,seuil)
%UNTITLED2 Summary of this function goes here
%   Fonction permettant d'extraire la signature du signal une fois le rayon
%   trouvé

%Binarisation d'une première signature

mat_bin1 = mat_intensite>seuil;

%On récupère le premier et dernier pixel noir correspondant au début et à
%la fin du code barre

index_utiles = find(mat_bin1==1);
extremite= [index_utiles(1);index_utiles(end)];



end

