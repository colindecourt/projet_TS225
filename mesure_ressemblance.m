function [ c ] = mesure_ressemblance( s_th, sp )
% Mesure la ressemblance entre la signature partielle observée et la
% signature théorique 

c=norm(s_th-sp);


end

