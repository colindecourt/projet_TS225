  %% Images

clear all
close all
clc

%Chargement des images
A = imread('cb1.jpg');
imshow(A);
[x y] = ginput(2); %x contient les x1 et x2 et y les y1 et y2

p1 =[x(1); y(1)]; %Poijt de gauche (premier point)
p2 =[x(2); y(2)];%Point de droite


[I1,mat] = rayon(p1, p2,A); %Récupération de la matrice d'intensité et 
                           %de la matrice contenant les positions du rayons

seuil = otsu_method(I1); %Seuil de binarisation pour binariser les signatures

extremite = rayon2binaire(I1,seuil); %Récupération des points de début 
                                    %et fin de la première signature

mat = mat(:,extremite(1):extremite(2)); %Nouvelle matrice contenant uniquement
                                        %les points utiles
                                        
%On récupère la matrice et on en re extrait la matrice d'intensité.
new_p1=[mat(1,1);mat(2,1)]; 
new_p2=[mat(1,end);mat(2,end)];

[I2, mat_2] = rayon(new_p1,new_p2,A); % Récupération de la nouvelle matrice
                                      %intensité à échantilloner

signature = bin_signature(I2,seuil); %Ne sert à rien



                                        



