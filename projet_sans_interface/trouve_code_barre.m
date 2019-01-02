function [seg,x_centre,y_centre] = trouve_code_barre(Dbin_bw, num)
%UNTITLED3 Summary of this function goes here
%   Detailed explanation goes here

taille_max = 0;
for i=1:num
    sub = find(Dbin_bw==i);
    [y,x] = ind2sub(size(Dbin_bw),sub);
    longueur_temp = max(x)-min(x);
    largeur_temp = max(y)-min(y);
    taille = longueur_temp*largeur_temp;
    if (longueur_temp > 95 && taille >taille_max)
        
            longueur = x(end)-x(1);
            largeur = y(end)-y(1);
            taille_max = taille;
            diagonale = sqrt(longueur^2+largeur^2);
            x_centre = (x(1)+x(end))/2;
            y_centre = (y(1)+y(end))/2;
            p_centre = [x_centre; y_centre];
        
    end
    
end

seg = lancer_aleatoire(Dbin_bw,p_centre,longueur, diagonale);

end

