function [ chiffres ] = identification_chiffres( sp, s_th )
% Identifie l'élement du code et ses chiffres 

%% Identification des chiffres  
chiffres=[];
 
% Parcours de toutes les signatures partielles observées 
for i=1:12 
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
    chiffres=[chiffres nb];
end 


end

