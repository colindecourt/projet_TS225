function [img_bin] = binarisation(img,seuil)
% Binarise une matrice 
    % Utile pour bianariser la matrice d'intensit�

% Binarisation
img_bin = img>seuil;

end

