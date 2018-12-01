clear; close all; clc; dbstop if error;
    
%% Images

 %Chargement des images
A = imread('cb1.jpg');
imshow(A);

% Prise du segment
[x, y] = ginput(2); 

p1 =[x(1); y(1)]; % Premier point tracé
p2 =[x(2); y(2)]; % Dernier point tracé

%% Extraction de la signature le long du rayon

% Matrice contenant les coordonnées de chaque point
coord_rayon = coord_rayon(p1, p2, A);

% Matrice d'intensité binéarisée 
I=intensite(A, coord_rayon);
I_bin=binarisation(I); 

% Récupération de la partie utile 
noirs = find(I_bin==1);
extremites = [noirs(1);noirs(end)]; % On récupère le premier et dernier pixel noir 
%coord_rayon = coord_rayon(:,extremites(1):extremites(2));








