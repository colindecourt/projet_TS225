function [argmax] = otsu_method(data)
%MY_HISTOGRAM Summary of this function goes here
%   Detailed explanation goes here

% Calcul de l'histogramme 
N = 256;
for k = 0:255
    hist(k+1)=sum(data==k);
end


% Calcul du seuil d'Otsu
temp1 = 0;
for k=0:N-1
   for i=1:k+1
       temp1 = temp1 + hist(i);
   end
   w(k+1)=temp1/sum(hist);
end
temp2 = 0;
for k=0:N-1
   for i=1:k+1
       temp2 = temp2 + i*hist(i);
   end
   mu(k+1)=temp2/sum(hist);
end

crit = w.*(mu(N-1)-mu).^2 + (1-w).*(mu).^2;

%Calcul du seuil 

[max_crit argmax] = max(crit);


end




