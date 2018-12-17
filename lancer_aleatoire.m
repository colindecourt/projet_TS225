function [seg,p_centre,p_lim_gauche,p_lim_droite,angle_aleatoire] = lancer_aleatoire(image)
%Fonction permettant d'effectuer un tirage aléatoire d'une ligne
% traversant le code barre

% Paramètre de l'image

[y_max, x_max] = size(image);

% On tire un point aléatoire dans l'image

x_aleatoire = randi([1 x_max]);
y_aleatoire = randi([1 y_max]);




% On tire un angle aléatoire dans l'image

angle_aleatoire = randi([-40 40]);


% Longueur de segment aléatoire
longueur_aleatoire = randi([600 900]);

% On trace de part et d'autre du centre de l'image un droite avec un
% certain angle

x = longueur_aleatoire*cosd(angle_aleatoire) + x_aleatoire;
y = longueur_aleatoire*sind(angle_aleatoire) + y_aleatoire;

p_lim_droite = [x; y];
p_centre = [x_aleatoire; y_aleatoire];


x1 = -longueur_aleatoire*cosd(angle_aleatoire) + x_aleatoire;
y1 = -longueur_aleatoire*sind(angle_aleatoire) + y_aleatoire;
p_lim_gauche = [x1;y1];


seg = [];
N=floor(sqrt( (p_centre(1)-p_lim_droite(1))^2 + (p_centre(2)-p_lim_droite(2))^2 ));
for i=0:N
    seg= [seg round(p_centre+i/(N-1)*(p_lim_droite-p_centre))];
end

seg1 = [];
N=floor(sqrt( (p_centre(1)-p_lim_gauche(1))^2 + (p_centre(2)-p_lim_gauche(2))^2 ));
for i=0:N
    seg1= [seg1 round(p_centre+i/(N-1)*(p_lim_gauche-p_centre))];
end

seg = [seg1 seg];

% On verifie qu'on est dans du blanc


end

