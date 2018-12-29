function [seg] = lancer_aleatoire(image,p_centre,long_max,diagonale)
%Fonction permettant d'effectuer un tirage aléatoire d'une ligne
% traversant le code barre

% Paramètre de l'image

[y_max, x_max] = size(image);

% On tire un point aléatoire dans l'image

x_aleatoire = p_centre(1);
y_aleatoire = p_centre(2);


% On tire un angle aléatoire dans l'image

angle_aleatoire = randi([-20 20]);


% Longueur de segment aléatoire
longueur_aleatoire = randi([round(long_max*cosd(angle_aleatoire)/2) round(long_max/2)
    ]);

% On trace de part et d'autre du centre de l'image un droite avec un
% certain angle

x = longueur_aleatoire*cosd(angle_aleatoire) + x_aleatoire;
y = longueur_aleatoire*sind(angle_aleatoire) + y_aleatoire;
 
p_lim_droite = [x; y];
p_centre = [x_aleatoire; y_aleatoire];


x1 = -longueur_aleatoire*cosd(angle_aleatoire) + x_aleatoire;
y1 = -longueur_aleatoire*sind(angle_aleatoire) + y_aleatoire;
p_lim_gauche = [x1;y1];

if(x<x_max && y<y_max && x(1)>1 && y>1 && x1<x_max && y1<y_max && x1>1 && y1>1)

seg2 = [];
N=floor(sqrt( (p_centre(1)-p_lim_droite(1))^2 + (p_centre(2)-p_lim_droite(2))^2 ));
for i=0:N
    seg2= [seg2 round(p_centre+i/(N-1)*(p_lim_droite-p_centre))];
end

seg1 = [];
N=floor(sqrt( (p_centre(1)-p_lim_gauche(1))^2 + (p_centre(2)-p_lim_gauche(2))^2 ));
for i=0:N
    seg1= [seg1 round(p_centre+i/(N-1)*(p_lim_gauche-p_centre))];
end

seg = [fliplr(seg1) seg2];
else
    seg = [ 1 2 3; 1 2 3];
end

end

