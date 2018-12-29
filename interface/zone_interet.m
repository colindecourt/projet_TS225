function [ Dbin ] = zone_interet( Img, sigma_g, sigma_t)
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here

[X, Y] = meshgrid(-3*sigma_g:3*sigma_g);

%% ----- Filtre de Canny pour calculer les vecteurs gradient -----

% Dérivée horizontale de la gaussienne
canny_x = -X.*exp(-(X.^2+Y.^2)/(2*sigma_g^2))/(2*pi*sigma_g^4); % Quand on échantillone continu -> pb coeff donc normaliser

figure, subplot(1,2,1), surf(canny_x), title('Dérivée horizontale de la gaussienne');

<<<<<<< Updated upstream:zone_interet.m
=======
%figure, surf(canny_x)
>>>>>>> Stashed changes:interface/zone_interet.m
% Dérivée verticale de la gaussienne
canny_y = -Y.*exp(-(X.^2+Y.^2)/(2*sigma_g^2))/(2*pi*sigma_g^4);

subplot(1,2,2), surf(canny_y), title('Dérivée verticale de la gaussienne');

<<<<<<< Updated upstream:zone_interet.m
=======
%figure, surf(canny_y)
>>>>>>> Stashed changes:interface/zone_interet.m
% Gradients de I
gradIx = conv2(Img,canny_x, 'same');
gradIy = conv2(Img,canny_y, 'same');

% Normalisation du gradient 
gradIx_norm=gradIx./sum(sum(sqrt(gradIx.^2 + gradIy.^2)));
gradIy_norm=gradIy./sum(sum(sqrt(gradIx.^2 + gradIy.^2)));

figure, % RAPPORT
Img_grad=sqrt(gradIx.^2+gradIy.^2);
imshow(uint8(Img_grad))
title('Gradient');

%% ----- Filtre passe-bas gaussien pour calcul fonction de pondération ---- 

[X, Y] = meshgrid(-3*sigma_t:3*sigma_t);

% Fonction de pondération (fonction gaussienne 2D)
W_passe_bas = exp((-X.^2-Y.^2)/(2*sigma_t^2))/(2*pi*sigma_t^2); 
W_passe_bas = W_passe_bas/(sum(sum(W_passe_bas))); % Normailsation OK pour passe bas MAIS pas pour dérivée!

<<<<<<< Updated upstream:zone_interet.m
figure, surf(W_passe_bas), title('Filtre passe-bas gaussien');

=======
%figure, surf(W_passe_bas)
>>>>>>> Stashed changes:interface/zone_interet.m
%% ----- Mesure de cohérence -----

% Composantes du tenseur de structure 
Txx=conv2(gradIx_norm.^2, W_passe_bas, 'same');
Tyy=conv2(gradIy_norm.^2, W_passe_bas,'same');
Txy=conv2(gradIy_norm.*gradIx_norm, W_passe_bas, 'same');

% Mesure de cohérence
D=sqrt((Txx-Tyy).^2 + 4*Txy.^2)./(Txx+Tyy);
 
% Mesure de cohérence binarisée 
seuil = max(max(D))*0.99;
Dbin= binarisation(D,seuil);

<<<<<<< Updated upstream:zone_interet.m
figure, subplot(1,2,1), imshow(uint8(Img)), title('Image  en nuances de gris');
subplot(1,2,2),imshow(Dbin), title('Zones d intêret');

=======
% figure,
% imshow(Dbin)
>>>>>>> Stashed changes:interface/zone_interet.m


end

