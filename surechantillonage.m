function [ I_ech ] = surechantillonage( u, I )
% Suréchantillonage en dupliquant u fois les lignes

I_ech=[];
[m n] = size(I);
for i=1:m
    c=0;
    for j=1:u
        I_ech=[I_ech; I(i)];
        c=c+1;
    end
end

end

