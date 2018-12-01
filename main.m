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

% ---------------- Première signature ---------------------- %

% Matrice contenant les coordonnées de chaque point
mat_rayon = coord_rayon(p1, p2, A);

% Matrice d'intensité binéarisée 
I=intensite(A, mat_rayon);
I_bin=binarisation(I); 

% -------------------- Signature utile ---------------------- % 

% Récupération du rayon utile 
noirs = find(I_bin==1);

new_p1=mat_rayon(:,noirs(1));
new_p2=mat_rayon(:,noirs(end));

mat_rayon = coord_rayon(new_p1, new_p2, A);

% Nouvelle matrice intensité utile
signature=intensite(A, mat_rayon);

% Unité de base u et échantillonage
u=unite_base(signature); % Peut être à optimiser car u=95 trés souvent
signature_surech=surechantillonage(u, signature); 

% Binarisation de la nouvelle signature
signature_bin= binarisation(signature_surech);


%% Affichage 
figure

% Affichage de l'intensité des pixels traversant tout le rayon
subplot(2,1,1), plot(I_bin);
title('Signature 1 binéarisée');

% Affichage de l'intensité des pixels utiles
subplot(2,1,2), plot(signature_bin);
title('Signature 2 binéarisée');









