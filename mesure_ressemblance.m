function [ c ] = mesure_ressemblance( s_th, sp )
% Mesure la ressemblance entre la signature partielle observ�e et la
% signature th�orique 

c=norm(s_th-sp);


end

