function [chiffres,seg,new_p1,new_p2,x_centre,y_centre] = detection_manuel(img)
%Fonction utile pour la détection manuelle de l'interface 

 %Chargement des images
B = imread(img);


% Image en nuances de gris
A=double(rgb2gray(B));

%Prise du segment


%% Segmentation en rï¿½gions d'intï¿½ret

% Paramï¿½tres d'ï¿½chelle et d'espace

sigma_g=1;  
sigma_t= 15 ;

% Zones d'intï¿½ret
Dbin = zone_interet(A, sigma_g, sigma_t);
[D_bin_bw, num] = bwlabel(Dbin);
chiffres =0;
while(chiffres ==0)
[seg, x_centre, y_centre] = trouve_code_barre(D_bin_bw,num);


p2 = [seg(1,1); seg(2,1)];

p1 = [seg(1,round(length(seg/2))); seg(2,round(length(seg/2)))];

% Extraction de la signature le long du rayon

% ---------------- Premiï¿½re signature ---------------------- %

% Matrice contenant les coordonnï¿½es de chaque point

% Calcul du nombre de points  (norme)
N=floor(sqrt( (p1(1)-p2(1))^2 + (p1(2)-p2(2))^2 ));
[mat_rayon]  = coord_rayon(p1, p2, N);



% Intensitï¿½ binï¿½arisï¿½e
I=intensite(A, mat_rayon);
% Determination du seuil avec la mï¿½thode de Otsu
seuil = otsu_method(I);
I_bin=binarisation(I,seuil);  % ATTENTION DONNE PAS BON PREMIER CHIFFRE --> que des 1

% -------------------- Signature utile ---------------------- %

% Rï¿½cupï¿½ration du premier et dernier point
noirs = find(I_bin==0);

new_p1=mat_rayon(:,noirs(end));
new_p2=mat_rayon(:,noirs(1));


% Calcul du nombre de points  (norme)
N1=floor(sqrt( (new_p1(1)-new_p2(1))^2 + (new_p1(2)-new_p2(2))^2 ));

%Calcul de u
u=0;
while u*95<N1
    u=u+1;
end

% Rï¿½cupï¿½ration du rayon utile dont la taille est multiple de 95
N1=u*95;
mat_rayon = coord_rayon( new_p1, new_p2, N1); % enlever les points qui ont exactement les mï¿½mes coordonnï¿½es


% Nouvelle intensitï¿½ utile
I=intensite(A, mat_rayon);

% Binarisation de la nouvelle signature
s_CB= binarisation(I,seuil);

%% Identification des chiffres codï¿½s dans la signature

% Identification des diffï¿½rentes parties du code
[~, sp_part1, ~, sp_part2, ~]=partitions_code(s_CB, u);
sp=[sp_part1 ; sp_part2];

% Construction des signatures thï¿½oriques dilatï¿½es en fonction de u
[s_th, premier_chiffre]=data_th(u);

% Identification de l'ï¿½lï¿½ment et des chiffres 2 ï¿½ 12
chiffres=identification_chiffres(sp, s_th, premier_chiffre,u);

end

end