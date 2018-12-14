clear; close all; clc; dbstop if error;
    
%% Images

 %Chargement des images
A = imread('cb1.jpg');


imshow(A);

% Image en nuances de gris
A=double(rgb2gray(A));

% Prise du segment
[x, y] = ginput(2); 

p1 =[x(1); y(1)]; % Premier point trac�
p2 =[x(2); y(2)]; % Dernier point trac�

%% Extraction de la signature le long du rayon

% ---------------- Premi�re signature ---------------------- %

% Matrice contenant les coordonn�es de chaque point

% Calcul du nombre de points  (norme)
N=floor(sqrt( (p1(1)-p2(1))^2 + (p1(2)-p2(2))^2 ));
[mat_rayon]  = coord_rayon(p1, p2, N);

% Intensit� bin�aris�e 
I=intensite(A, mat_rayon);
% Determination du seuil avec la m�thode de Otsu
seuil = otsu_method(I);
I_bin=binarisation(I,seuil);  % ATTENTION DONNE PAS BON PREMIER CHIFFRE --> que des 1 

% -------------------- Signature utile ---------------------- % 

% R�cup�ration du premier et dernier point
noirs = find(I_bin==0);

new_p1=mat_rayon(:,noirs(1));
new_p2=mat_rayon(:,noirs(end));

% Calcul du nombre de points  (norme)
N1=floor(sqrt( (new_p1(1)-new_p2(1))^2 + (new_p1(2)-new_p2(2))^2 ));

%Calcul de u 
u=0;
while u*95<N1
    u=u+1;
end

% R�cup�ration du rayon utile dont la taille est multiple de 95
N1=u*95;
mat_rayon = coord_rayon( new_p1, new_p2, N1); % enlever les points qui ont exactement les m�mes coordonn�es 


% Nouvelle intensit� utile
I=intensite(A, mat_rayon);

% Binarisation de la nouvelle signature
s_CB= binarisation(I,seuil);

%% Identification des chiffres cod�s dans la signature

% Identification des diff�rentes parties du code 
[garde_norm1, sp_part1, garde_ctr, sp_part2, garde_norm2]=partitions_code(s_CB, u);
sp=[sp_part1 ; sp_part2];

% Construction des signatures th�oriques dilat�es en fonction de u
[s_th, premier_chiffre]=data_th(u);

% Identification de l'�l�ment et des chiffres 2 � 12
chiffres=identification_chiffres(sp, s_th, premier_chiffre,u);



%% Segmentation en r�gions d'int�ret

% Param�tres d'�chelle et d'espace %  A CHANGER !!

sigma_g=3;  
sigma_t= 3;

% ----- Filtre passe-bas gaussien pour calcul fonction de pond�ration ---- 
      
%Matrice du filtre r�duite aux valeurs probables de la gaussienne
[X, Y] = meshgrid(floor(-length(I)/2*sigma_t):floor(length(I)/2*sigma_t), floor(-length(I)/2*sigma_t):floor(length(I)/2*sigma_t)); 

%Fonction gaussienne 2D
passe_bas = (1/(2*pi*sigma_t^2)*exp((-X.^2-Y.^2)/(2*sigma_t^2))); 
passe_bas = passe_bas/(sum(sum(passe_bas)));

% Fonction de pond�ration
W = conv2(I,passe_bas, 'same');

% Affichage
figure,
plot(I)
hold on
plot(W)
hold off
title('I filtr�e par passe bas');


% ----- Filtre de Canny pour calculer les vecteurs gradient -----

















% %�Passe bas
% c=0;
% x = 1:1:10; % Changer le x
% passe_bas = gaussmf(x,[sigma_t c]);
% 
% % Fonction de pond�ration
% W=conv(I, passe_bas);
% 
