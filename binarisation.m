function [img_bin] = binarisation(img)
% Binarise une matrice 
    % Utile pour bianariser la matrice d'intensité

% Determination du seuil avec la méthode de Otsu
seuil = otsu_method(img);

% Binarisation
img_bin = img<seuil;

end

