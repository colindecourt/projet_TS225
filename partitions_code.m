function [ garde_norm1 sp_part1 garde_ctr sp_part2 garde_norm2 ] = partitions_code( s_CB, u )
% Identification des différentes parties du code 

% Garde normale de gauche 
garde_norm1=s_CB(1 : 3*u);

% Partie chiffres de gauche, chaque ligne représentant un chiffre 
sp_part1=s_CB(3*u+1 : 3*u + 7*u*6);
sp_part1=reshape(sp_part1,[7 6*u]);

% Garde centrale
garde_ctr=s_CB(3*u+7*u*6+1 : 3*u + 7*u*6 + 5*u);

% Partie chiffres de droite, chaque ligne représentant un chiffre 
sp_part2= s_CB(3*u+7*u*6+5*u + 1 : 3*u+7*u*6+5*u + 7*u*6);
sp_part2=reshape(sp_part2,[7 6*u]);

% Garde normale de droite 
garde_norm2=s_CB(3*u+7*u*6+5*u+7*u*6 + 1 : 3*u+7*u*6+5*u+7*u*6 + 3*u);

end

