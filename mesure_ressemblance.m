function [ c ] = mesure_ressemblance( s_th, sp )
% Mesure la ressemblance entre la signature partielle observ�e et la
% signature th�orique 

c=0;
for i=1:length(s_th)
    if s_th(i)~=sp(i)
        c=c+1;
    end
end


end

