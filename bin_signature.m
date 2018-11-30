function [signature] = bin_signature(mat_intensite,seuil)
%UNTITLED2 Summary of this function goes here
%   Fonction permettant d'extraire la signature du signal une fois le rayon
%   trouv�

%D�finition d'un sueil 

mat_bin1 = mat_intensite>seuil;

%On r�cup�re le premier et dernier pixel noir correspondant au d�but et �
%la fin du code barre

extremite = find(mat_bin1==1);
signature = mat_bin1(extremite(1):extremite(end));
plot(signature);


end

