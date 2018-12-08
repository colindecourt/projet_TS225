clear; close all; clc; dbstop if error;
    
%% Images

 %Chargement des images
A = imread('cb2.png');

% Image en nuances de gris
A=double(rgb2gray(A));
imshow(A);

% Prise du segment
[x, y] = ginput(2); 

p1 =[x(1); y(1)]; % Premier point tracé
p2 =[x(2); y(2)]; % Dernier point tracé

%% Extraction de la signature le long du rayon

% ---------------- Première signature ---------------------- %

% Matrice contenant les coordonnées de chaque point

% Calcul du nombre de points  (norme)
N=floor(sqrt( (p1(1)-p2(1))^2 + (p1(2)-p2(2))^2 ));
[mat_rayon]  = coord_rayon(p1, p2, N);

% Intensité binéarisée 
I=intensite(A, mat_rayon);
I_bin=binarisation(I);  % ATTENTION DONNE PAS BON PREMIER CHIFFRE --> que des 1 

% -------------------- Signature utile ---------------------- % 

% Récupération du premier et dernier point
noirs = find(I_bin==1);

new_p1=mat_rayon(:,noirs(1));
new_p2=mat_rayon(:,noirs(end));

% Calcul du nombre de points  (norme)
N1=floor(sqrt( (new_p1(1)-new_p2(1))^2 + (new_p1(2)-new_p2(2))^2 ));

%Calcul de u 
u=0;
while u*95<N1
    u=u+1;
end

% Récupération du rayon utile dont la taille est multiple de 95
N1=N1*95;
mat_rayon = coord_rayon( new_p1, new_p2, N1); % enlever les points qui ont exactement les mêmes coordonnées 


% Nouvelle intensité utile
I=intensite(A, mat_rayon);

% Unité de base u et échantillonage
%u=unite_base(I); % Peut être à optimiser? 
%I_surech=surechantillonage(u, I); 

% Binarisation de la nouvelle signature
s_CB= binarisation(I);

%% Identification des chiffres codés dans la signature

% Identification des différentes parties du code 
[garde_norm1, sp_part1, garde_ctr, sp_part2, garde_norm2]=partitions_code(s_CB, u);
sp=[sp_part1;sp_part2];

% Construction des signatures théoriques dilatées en fonction de u
[s_th, premier_chiffre]=data_th(u);

% Identification de l'élément et des chiffres 2 à 12
chiffres=identification_chiffres(sp, s_th, premier_chiffre);


%% Affichage 
% % figure
% % 
% % Affichage de l'intensité des pixels traversant tout le rayon
% % subplot(2,1,1), plot(I_bin);
% % title('Signature 1 binéarisée');
% % 
% % Affichage de l'intensité des pixels utiles
% % subplot(2,1,2), plot(s_CB);
% % title('Signature 2 binéarisée');









