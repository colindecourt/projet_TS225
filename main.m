clear; close all; clc; dbstop if error;

%% Images

%Chargement des images
A = imread('cb8.jpg');


imshow(A);

% Image en nuances de gris
A=double(rgb2gray(A));

% [y_max, x_max] = size(A);
% i=0;
% while(i<30)
%     [seg, p, p_lim_gauche, p_lim_droite,angle_aleatoire] = lancer_aleatoire(A);
%     if(p_lim_gauche(1)<x_max && p_lim_gauche(2)<y_max && p_lim_gauche(1)>1 && p_lim_gauche(2)>1 && p_lim_droite(1)<x_max && p_lim_droite(2)<y_max && p_lim_droite(1)>1 && p_lim_droite(2)>1)
%         %if(A(round(p_lim_gauche(2)),round(p_lim_gauche(1)))>227 && A(round(p_lim_droite(2)),round(p_lim_droite(1)))>227)
%             hold on
%             plot(p(1),p(2),'or');
%             plot(seg(1,:),seg(2,:),'y')
%             p1 = p_lim_gauche;
%             p2 = p_lim_droite;
%            % break;
%         %end
%     end
%     i=i+1;
%     
% end

%Prise du segment
[x, y] = ginput(2);

p1 =[x(1); y(1)]; % Premier point trac�
p2 =[x(2); y(2)]; % Dernier point trac�

% Extraction de la signature le long du rayon

% ---------------- Premi�re signature ---------------------- %

% Matrice contenant les coordonn�es de chaque point

% Calcul du nombre de points  (norme)
N=floor(sqrt( (p1(1)-p2(1))^2 + (p1(2)-p2(2))^2 ));
[mat_rayon]  = coord_rayon(p1, p2, N);

hold on 
plot(mat_rayon(1,:),mat_rayon(2,:),'r');

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

plot(new_p1(1),new_p1(2),'yo');
plot(new_p2(1),new_p2(2),'yo');
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
if(chiffres == 0)
    disp('Ceci n est pas un code barre');
else
    disp(chiffres);
end


% %% Segmentation en r�gions d'int�ret
%
% % Param�tres d'�chelle et d'espace %  A CHANGER !!
%
% sigma_g=3;
% sigma_t= 3;
%
% [X, Y] = meshgrid(floor(-3*sigma_t):floor(3*sigma_t));
%
% % ----- Filtre de Canny pour calculer les vecteurs gradient -----
%
% s1=meshgrid((-2:2)); % Signal de r�f�rence utile pour normalisation
%
% % D�riv�e horizontale de la gaussienne
% canny_x=(-X/(2*pi*sigma_g^4)*exp(-(X.^2+Y.^2)/(2*sigma_g^2))); % Quand on �chantillone continu -> pb coeff donc normaliser
% %canny_x = canny_x/conv2(canny_x,s1,'same'); % Normalisation d'un d�rivateur
%
% % D�riv�e verticale de la gaussienne
% canny_y=(-Y/(2*pi*sigma_g^4)*exp(-(X.^2+Y.^2)/(2*sigma_g^2)));
% %canny_y=canny_y/conv2(canny_y,s1,'same');
%
% % Gradients de I
% gradI_x = conv2(A,canny_x, 'same');
% gradI_y = conv2(A,canny_y, 'same');
%
% % Normalisation du gradient
%
%
% % ----- Filtre passe-bas gaussien pour calcul fonction de pond�ration ----
%
%
% % Fonction gaussienne 2D
% passe_bas = (1/(2*pi*sigma_t^2)*exp((-X.^2-Y.^2)/(2*sigma_t^2)));
% passe_bas = passe_bas/(sum(sum(passe_bas))); % Normailsation OK pour passe bas MAIS pas pour d�riv�e!
%
% % Fonction de pond�ration
% W = conv2(A,passe_bas, 'same');
%
% % Affichage
% figure,
% plot(I)
% hold on
% plot(W)
% hold off
% title('I filtr�e par passe bas');
%
%
% % ----- Mesure de coh�rence -----
%
% Txx=conv2(W, gradI_x.^2);
% Tyy=conv2(W, gradI_y.^2);
% Txy=conv2(W, gradI_x*gradI_x);
%
%
%
%
%
%
%
%
% % %�Passe bas
% % c=0;
% % x = 1:1:10; % Changer le x
% % passe_bas = gaussmf(x,[sigma_t c]);
% %
% % % Fonction de pond�ration
% % W=conv(I, passe_bas);
% %
