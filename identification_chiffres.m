function [ chiffres ] = identification_chiffres( sp, s_th, vec_chiffre1_th )
% Identifie l'élement du code et ses chiffres 

%% Identification des chiffres  
chiffres=[];
elements=[];

nb_chiffres=12;

% Parcours de toutes les signatures partielles observées 
for i=1:nb_chiffres 
    c_max=0;
    sp_part=sp(i,:);

    % Parcours de chaque chiffre théorique 
    for j=1:30 
        s_th_part=s_th(:,j);
        c=mesure_ressemblance(s_th_part,sp_part');
        if c_max<c
            c_max=c;
            nb=j;
        end           
    end 
    
    % A partir de l'indice du s_th correpondant au chiffre le plus problable, on en déduit le chiffre et l'élément
    if nb<10
        chiffre=nb; 
        element=1;
    elseif nb<20
        chiffre=nb-10; 
        element=2;
    else
        chiffre=nb-20;
        element=3;
    end 
        
    chiffres=[chiffres chiffre]; % Vecteur regroupant tous les chiffres décodés
    elements=[elements element]; % Vecteur regroupant les éléments correspondant aux chiffres décodés
end
  

% Trouver le premier chiffre à partir des 6 premiers éléments 
chiffre1_exp=elements(1:6);
% A finir !! (une fois que le reste marchera)

end


