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

% ---------------- Premi�re signature ---------------------- %

% Matrice contenant les coordonn�es de chaque point
mat_rayon = coord_rayon(p1, p2, A);

% Matrice d'intensit� bin�aris�e 
I=intensite(A, mat_rayon);
I_bin=binarisation(I); 

% -------------------- Signature utile ---------------------- % 

% R�cup�ration du rayon utile 
noirs = find(I_bin==1);

new_p1=mat_rayon(:,noirs(1));
new_p2=mat_rayon(:,noirs(end));

mat_rayon = coord_rayon(new_p1, new_p2, A);

% Nouvelle matrice intensit� utile
signature=intensite(A, mat_rayon);

% Unit� de base u et �chantillonage
u=unite_base(signature); % Peut �tre � optimiser car u=95 tr�s souvent
signature_surech=surechantillonage(u, signature); 

% Binarisation de la nouvelle signature
s_CB= binarisation(signature_surech);

%% Identification des chiffres cod�s dans la signature

% Identification des diff�rentes parties du code 
[garde_norm1, sp_part1, garde_ctr, sp_part2, garde_norm2]=partitions_code(s_CB, u);

% Construction des signatures th�oriques dilat�es en fonction de u
[element_A, element_B, element_C]=signature_th(u);




%% Affichage 
figure

% Affichage de l'intensit� des pixels traversant tout le rayon
subplot(2,1,1), plot(I_bin);
title('Signature 1 bin�aris�e');

% Affichage de l'intensit� des pixels utiles
subplot(2,1,2), plot(s_CB);
title('Signature 2 bin�aris�e');









