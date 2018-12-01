clear; close all; clc; dbstop if error;
    
%% Images

 %Chargement des images
A = imread('cb1.jpg');
imshow(A);

% Prise du segment
[x, y] = ginput(2); 

p1 =[x(1); y(1)]; % Premier point trac�
p2 =[x(2); y(2)]; % Dernier point trac�

%% Extraction de la signature le long du rayon

% Matrice contenant les coordonn�es de chaque point
coord_rayon = coord_rayon(p1, p2, A);

% Matrice d'intensit� bin�aris�e 
I=intensite(A, coord_rayon);
I_bin=binarisation(I); 

% R�cup�ration de la partie utile 
noirs = find(I_bin==1);
extremites = [noirs(1);noirs(end)]; % On r�cup�re le premier et dernier pixel noir 
%coord_rayon = coord_rayon(:,extremites(1):extremites(2));








