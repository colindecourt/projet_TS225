  %% Images


close all
clc

%Chargement des images
A = imread('cb2.png');

%imtool(A)


[I,mzt] = rayon(point1, point2,A);

figure
plot(mzt(:,1),mzt(:,2))

