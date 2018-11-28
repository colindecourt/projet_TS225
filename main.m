  %% Images

clear all
close all
clc

%Chargement des images
A = imread('cb1.jpg');
imshow(A);
[point1 point2] = ginput(2);

%imtool(A)


[I,mat] = rayon(point2, point1,A);
seuil = otsu_method(I);
mat =flipud(mat);
%Dernier point = premier et inversement
extremite = rayon2binaire(I,seuil);

mat = mat(:,extremite(1):extremite(2));




