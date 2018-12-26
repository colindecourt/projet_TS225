clear; close all; clc; dbstop if error;

%% Images

 %Chargement des images
B = imread('cb3.jpg');
imshow(B);


% Image en nuances de gris
A=double(rgb2gray(B));

%Prise du segment
[x, y] = ginput(2);

p1 =[x(1); y(1)]; % Premier point tracé
p2 =[x(2); y(2)]; % Dernier point tracé

%% Segmentation en régions d'intéret
% 
% % Paramètres d'échelle et d'espace
% 
% sigma_g=3;  
% sigma_t= 15 ;
% 
% % Zones d'intéret
% Dbin = zone_interet(A, sigma_g, sigma_t);
% [D_bin_bw, num] = bwlabel(Dbin);
% [seg,p_centre] = trouve_code_barre(D_bin_bw,num);
% figure
% imshow(B);
% hold on 
% plot(p_centre(1),p_centre(2),'yo');
% plot(seg(1,:),seg(2,:),'r');


%% Extraction de la signature le long du rayon

% ---------------- Première signature ---------------------- %

% Calcul du nombre de points  (norme)
N=floor(sqrt( (p1(1)-p2(1))^2 + (p1(2)-p2(2))^2 ));

% Matrice contenant les coordonnées de chaque point
[mat_rayon]  = coord_rayon(p1, p2, N);

% Intensité binarisée
I=intensite(A, mat_rayon);

figure,
plot(I);
title('Intensité de la première signature');
xlabel('Echantillons');
ylabel('Intensité');

% Determination du seuil avec la méthode de Otsu
seuil = otsu_method(I);
I_bin=binarisation(I,seuil);  % ATTENTION DONNE PAS BON PREMIER CHIFFRE --> que des 1


figure,
plot(I_bin);
title('Intensité binarisée de la première signature');
xlabel('Echantillons');
ylabel('Intensité binarisée');

% -------------------- Signature utile ---------------------- %

% Récupération du premier et dernier point
noirs = find(I_bin==0);

new_p1=mat_rayon(:,noirs(1));
new_p2=mat_rayon(:,noirs(end));

plot(new_p1(1),new_p1(2),'yo');
plot(new_p2(1),new_p2(2),'yo');

% Calcul du nombre de points  (norme)
N1=floor(sqrt( (new_p1(1)-new_p2(1))^2 + (new_p1(2)-new_p2(2))^2 ));

%Calcul de u
u=0;
while u*95<N1
    u=u+1;
end

% Récupération du rayon utile dont la taille est multiple de 95
N1=u*95;
mat_rayon = coord_rayon( new_p1, new_p2, N1); % enlever les points qui ont exactement les mï¿½mes coordonnï¿½es


% Nouvelle intensité utile
I=intensite(A, mat_rayon);

figure,
subplot(1,2,1);
plot(I);
title('Signature utile');
xlabel('Echantillons');
ylabel('Intensité');

% Binarisation de la nouvelle signature
s_CB= binarisation(I,seuil);

subplot(1,2,2);
plot(s_CB);
title('Signature utile binarisée');
xlabel('Echantillons');
ylabel('Intensité binarisée');

%% Identification des chiffres codés dans la signature

% Identification des diffï¿½rentes parties du code
[garde_norm1, sp_part1, garde_ctr, sp_part2, garde_norm2]=partitions_code(s_CB, u);
sp=[sp_part1 ; sp_part2];

% Construction des signatures thï¿½oriques dilatï¿½es en fonction de u
[s_th, premier_chiffre]=data_th(u);

% Identification de l'ï¿½lï¿½ment et des chiffres 2 ï¿½ 12
chiffres=identification_chiffres(sp, s_th, premier_chiffre,u);
if(chiffres == 0)
    disp('Ceci n est pas un code barre');
else
    disp(chiffres);
end





