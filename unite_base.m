function [ u ] = unite_base( I)
% Renvoie l'unité de base de la signature 
 % on veut que length(signature)*fac_surech soit divisible par 95, et u
 % sera le résultat de cette division
 
 [m n]=size(I);
 fac_surech=1;
 
 while (round(m*fac_surech/95)~=(m*fac_surech/95))
     fac_surech=fac_surech+1;
 end 
 
 u=m*fac_surech/95;

end

