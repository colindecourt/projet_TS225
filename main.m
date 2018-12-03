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

mat_rayon = coord_rayon( new_p1, new_p2, A);

% Nouvelle matrice intensité utile
I=intensite(A, mat_rayon);

% Unité de base u et échantillonage
u=unite_base(I); % Peut être à optimiser? 
I_surech=surechantillonage(u, I); 

% Binarisation de la nouvelle signature
s_CB= binarisation(I_surech);

%% Identification des chiffres codés dans la signature

% Identification des différentes parties du code 
[garde_norm1, sp_part1, garde_ctr, sp_part2, garde_norm2]=partitions_code(s_CB, u);
sp=[sp_part1;sp_part2];

% Construction des signatures théoriques dilatées en fonction de u
[s_th]=signature_th(u);

% Identification de l'élément et des chiffres 2 à 12
chiffres=identification_chiffres(sp, s_th);


%% Affichage 
% figure
% 
% % Affichage de l'intensité des pixels traversant tout le rayon
% subplot(2,1,1), plot(I_bin);
% title('Signature 1 binéarisée');
% 
% % Affichage de l'intensité des pixels utiles
% subplot(2,1,2), plot(s_CB);
% title('Signature 2 binéarisée');









