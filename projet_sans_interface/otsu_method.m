function [argmax] = otsu_method(data)
% Seuil de binarisation calculée avec la méthode de Otsu

%% Données 
N = 256;

%% Calcul de l'histogramme 
for k = 0:255
    hist(k+1)=sum(data==k);
end

%% Calcul de w  bh y  
 
num_w = 0;
for k=0:N-1
   for i=1:k+1
       num_w = num_w + hist(i);
   end
   w(k+1)=num_w/sum(hist);
end

%% Calcul de mu
num_mu = 0;
for k=0:N-1
   for i=1:k+1
       num_mu = num_mu + i*hist(i);
   end
   mu(k+1)=num_mu/sum(hist);
end

%% Calcul du critère de Otsu
crit = w.*(mu(N-1)-mu).^2 + (1-w).*(mu).^2;

%% Calcul du seuil (qui est l'argmax de crit)
[max_crit argmax] = max(crit);


end




