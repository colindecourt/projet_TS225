function [ Dbin ] = zone_interet( Img, sigma_g, sigma_t)
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here

[X, Y] = meshgrid(-3*sigma_g:3*sigma_g);

%% ----- Filtre de Canny pour calculer les vecteurs gradient -----

% D�riv�e horizontale de la gaussienne
canny_x = -X.*exp(-(X.^2+Y.^2)/(2*sigma_g^2))/(2*pi*sigma_g^4); % Quand on �chantillone continu -> pb coeff donc normaliser

% D�riv�e verticale de la gaussienne
canny_y = -Y.*exp(-(X.^2+Y.^2)/(2*sigma_g^2))/(2*pi*sigma_g^4);




% Gradients de I
gradIx = conv2(Img,canny_x, 'same');
gradIy = conv2(Img,canny_y, 'same');

% Normalisation du gradient 
gradIx_norm=gradIx./sum(sum(sqrt(gradIx.^2 + gradIy.^2)));
gradIy_norm=gradIy./sum(sum(sqrt(gradIx.^2 + gradIy.^2)));


%% ----- Filtre passe-bas gaussien pour calcul fonction de pond�ration ---- 

[X, Y] = meshgrid(-3*sigma_t:3*sigma_t);

% Fonction de pond�ration (fonction gaussienne 2D)
W_passe_bas = exp((-X.^2-Y.^2)/(2*sigma_t^2))/(2*pi*sigma_t^2); 
W_passe_bas = W_passe_bas/(sum(sum(W_passe_bas))); % Normailsation OK pour passe bas MAIS pas pour d�riv�e!

%% ----- Mesure de coh�rence -----

% Composantes du tenseur de structure 
Txx=conv2(gradIx_norm.^2, W_passe_bas, 'same');
Tyy=conv2(gradIy_norm.^2, W_passe_bas,'same');
Txy=conv2(gradIy_norm.*gradIx_norm, W_passe_bas, 'same');

% Mesure de coh�rence
D=sqrt((Txx-Tyy).^2 + 4*Txy.^2)./(Txx+Tyy);
 
% Mesure de coh�rence binaris�e 
seuil = max(max(D))*0.99;
Dbin= binarisation(D,seuil);


end

