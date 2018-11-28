  %% Images

clear all
close all
clc

%Chargement des images
A = imread('cb1.jpg');
imshow(A);
[point1 point2] = ginput(2);

%imtool(A)


[I,mat] = rayon(point1, point2,A);
seuil = otsu_method(I);

signature = bin_signature(I,seuil);

