function [seg,p_centre] = trouve_code_barre(Dbin_bw, num)
%UNTITLED3 Summary of this function goes here
%   Detailed explanation goes here

sub = find(Dbin_bw==1);
[y_max,x_max] = ind2sub(size(Dbin_bw),sub);
taille_max = length(y_max)*length(x_max);
for i=2:num
    sub = find(Dbin_bw==i);
    [y,x] = ind2sub(size(Dbin_bw),sub);
    taille = length(y)*length(x);
    if(taille > taille_max)
        x_max = x;
        y_max = y;
    end
    
end

x_centre = (x_max(1)+x_max(end))/2;
y_centre = (y_max(1)+y_max(end))/2;

p_centre = [x_centre y_centre];

seg = lancer_aleatoire(Dbin_bw,p_centre);

end

