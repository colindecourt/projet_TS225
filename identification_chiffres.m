function [ chiffres ] = identification_chiffres( sp, s_th )
% Identifie l'�lement du code et ses chiffres 

%% Identification de l'�l�ment 
tot_ressemblance=[];

% Parcours des �l�ments 
for h=1:3 
    ressemblance=0;
    
    % Parcours de toutes les signatures partielles observ�es 
    for i=1:12 
        c_max=0;
        sp_part=sp(i,:);
        
        % Parcours de chaque chiffre th�orique dans un �l�ment 
        for j=1:10 
            s_th_part=s_th(:,h*j);
            c=mesure_ressemblance(s_th_part,sp_part');
            if c_max<c
                c_max=c;
            end 
        end 
        ressemblance=ressemblance+c_max;
    end 
    tot_ressemblance=[tot_ressemblance ressemblance];
end 
            
% Element    
[maximun argmax]=max(tot_ressemblance);
element=s_th(:,(argmax-1)*10+1:argmax*10);

%% Identification des chiffres 

chiffres=[];

% Parcours de toutes les signatures partielles observ�es 
for i=1:12 
    c_max=0;
    sp_part=sp(i,:);
        
    % Parcours de chaque chiffre th�orique dans l'�l�ment 
    for j=1:10 
        s_th_part=element(:,j);
        c=mesure_ressemblance(s_th_part,sp_part');
        if c_max<c
            c_max=c;
            chiffre=j;
        end 
    end 
    
    chiffres=[chiffres chiffre];

end


end

