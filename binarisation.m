function [img_bin] = binarisation(img)
% Binarise une matrice 
    % Utile pour bianariser la matrice d'intensit�

% Determination du seuil avec la m�thode de Otsu
seuil = otsu_method(img);

% Binarisation
img_bin = img<seuil;

end

