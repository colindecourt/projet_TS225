function [ I_ech ] = surechantillonage( u, I )
% Suréchantillonage la signature en ajoutant chaque pixel u fois

I_ech=[];
for i=1:length(I)
    c=0;
    for j=1:u
        I_ech=[I_ech; I(i)];
        c=c+1;
    end
end

end

