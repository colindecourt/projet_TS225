function [ u ] = unite_base( I)
% Renvoie l'unité de base de la signature 
 % on veut que length(signature)*u soit divisible par 95
 
 [m n]=size(I);
 u=1;
 
 while (round(m*u/95)~=(m*u/95))
     u=u+1;
 end 

end

