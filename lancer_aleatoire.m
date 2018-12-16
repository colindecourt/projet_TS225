function [seg, p1, p_lim_gauche, p_lim_droite,angle_aleatoire] = lancer_aleatoire(image)
%Fonction permettant d'effectuer un tirage aléatoire d'une ligne 
% traversant le code barre

% Paramètre de l'image 

[y_max, x_max] = size(image);

% On tire un point aléatoire dans l'image

x_aleatoire = randi(x_max);
y_aleatoire = randi(y_max);

p_centre = [x_aleatoire y_aleatoire];


% On tire un angle aléatoire dans l'image

angle_aleatoire = randi([-60 60]);

% On trace de part et d'autre du centre de l'image un droite avec un
% certain angle

x = 400*cosd(angle_aleatoire) + x_aleatoire;
y = 400*sind(angle_aleatoire) + y_aleatoire;

p_lim_droite = [x; y];
p1 = [x_aleatoire; y_aleatoire];

x1 = -400*cosd(angle_aleatoire) + x_aleatoire;
y1 = -400*sind(angle_aleatoire) + y_aleatoire;
p_lim_gauche = [x1;y1];


seg = [];
N=floor(sqrt( (p1(1)-p_lim_droite(1))^2 + (p1(2)-p_lim_droite(2))^2 ));
for i=0:N
    seg= [seg round(p1+i/(N-1)*(p_lim_droite-p1))]; 
end

seg1 = [];
N=floor(sqrt( (p1(1)-p_lim_gauche(1))^2 + (p1(2)-p_lim_gauche(2))^2 ));
for i=0:N
    seg1= [seg1 round(p1+i/(N-1)*(p_lim_gauche-p1))]; 
end

seg = [seg1 seg];

% On verifie que la distance est supérieure à 95 pixels


% On verifie qu'on est dans du blanc 


end

