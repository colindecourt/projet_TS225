function [ chiffres ] = identification_chiffres( sp, s_th, vec_chiffre1_th,u )
% Identifie l'élement du code et ses chiffres 

%% Identification des chiffres de 1 à 12
chiffres=[];
elements=[];

nb_chiffres=12;

% Parcours de toutes les signatures partielles observées 
for i=0:nb_chiffres-1 
    pas = 7;
    sp_part=sp(i*pas*u+1:(i+1)*pas*u);
    c_min=100; %initilisation haute
    
    % Parcours de chaque chiffre théorique 
    for j=1:30 
        s_th_part=s_th(:,j);
        c=mesure_ressemblance(s_th_part,sp_part);
        if c<c_min
            c_min=c;
            nb=j-1;
        end           
    end 
    
    % A partir de l'indice du s_th correpondant au chiffre le plus problable, on en déduit le chiffre et l'élément
    if nb<10
        chiffre=nb; 
        element=1;
    elseif nb>=10 && nb<20
        chiffre=nb-10; 
        element=2;
    else
        chiffre=nb-20;
        element=3;
    end 
        
    chiffres=[chiffres chiffre]; % Vecteur regroupant tous les chiffres décodés
    elements=[elements element]; % Vecteur regroupant les éléments correspondant aux chiffres décodés
end
  
%% Premier chiffre 

% Suite d'éléments exp
chiffre1_exp=elements(1:6);


% Parcours des différentes séquences d'éléments 
c_min =100;
for j=1:10 
    chiffre1_th=vec_chiffre1_th(:,j);
    c=mesure_ressemblance(chiffre1_exp,chiffre1_th);
    if c<c_min
        c_min=c;
        chiffre1=j-1;
    end           
end  

chiffres=[chiffre1 chiffres];

%% Test du dernier chiffre
somme_impaire=0;
for i=1:2:length(chiffres)-2
    somme_impaire = somme_impaire + chiffres(i);
end


somme_pair=0;
for i=2:2:length(chiffres)
    somme_pair = somme_pair + chiffres(i);
end

complement_10 = 10 - chiffres(end);

test_val = 3*somme_pair + somme_impaire;

if(mod(test_val,10) ~= complement_10)
    chiffres = 0;
end
    
end


