function [ I_ech ] = surechantillonage( u, I )
% Suréchantillonage en dupliquant u fois les lignes
    % I est un vecteur colonne 

I_ech=[];
[m n] = size(I);
for i=1:m
    for j=1:u    
        I_ech=[I_ech; I(i,:)];
    end
end

end

