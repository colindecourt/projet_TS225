clear; close all; clc; dbstop if error;
    
%% Images

 %Chargement des images
Img = imread('cb3.jpg');


imshow(Img);

% Image en nuances de gris
Img=double(rgb2gray(Img));

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
I=intensite(Img, mat_rayon);
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
I=intensite(Img, mat_rayon);

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

% Param�tres d'�chelle et d'espace

sigma_g=1;  
sigma_t= 15;

% Zones d'int�ret
Dbin = zone_interet(Img, sigma_g, sigma_t);

