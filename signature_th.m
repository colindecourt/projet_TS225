function [ Element_A Element_B  Element_C ] = signature_th(  )
% Retourne 3 matrices contenant les 10 signatures de chaque élément

B=1; 
N=0; 

% Element A
c_0=[B B B N N B N];
c_1=[B B N N B B N];
c_2=[B B N B B N N];
c_3=[B N N N N B N];
c_4=[B N B B B N N]; 
c_5=[B N N B B B N];
c_6=[B N B N N N N];
c_7=[B N N N B N N];
c_8=[B N N B N N N];
c_9=[B B B N B N N];
    
Element_A=[c_0; c_1; c_2; c_3; c_4; c_5; c_6; c_7; c_8; c_9];

% Element B
c_0=[B N B B N N N];
c_1=[B N N B B N N];
c_2=[B B N N B N N];
c_3=[B N B B B B N];
c_4=[B B N N N B N];
c_5=[B N N N B B N];
c_6=[B B B B N B N];
c_7=[B B N B B B N];
c_8=[B B B N B B N];
c_9=[B B N B N N N];
 
Element_B=[c_0; c_1; c_2; c_3; c_4; c_5; c_6; c_7; c_8; c_9];

% Element C
c_0=[N N N B B N B];
c_1=[N N B B N N B];
c_2=[N N B N N B B];
c_3=[N B B B B N B];
c_4=[N B N N N B B];
c_5=[N B B N N N B];
c_6=[N B N B B B B];
c_7=[N B B B N B B];
c_8=[N B B N B B B];
c_9=[N N N B N B B];

Element_C=[c_0; c_1; c_2; c_3; c_4; c_5; c_6; c_7; c_8; c_9];

end

