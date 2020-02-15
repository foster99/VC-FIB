function ret = calc_caract(I)
% Separamos la imagen original entre las diferentes componentes connexas
% (caracteres).
CC = bwconncomp(I);

% Obtenemos imagenes binarias separadas de los caracteres
caracter = regionprops(CC, 'Image');

% Calculo de los descriptores de Fourier para cada caracter (Todas las
% matriculas tienen 7 caracteres

FD_0 = FourierDescriptor(caracter(1).Image);
FD_1 = FourierDescriptor(caracter(2).Image);
FD_2 = FourierDescriptor(caracter(3).Image);
FD_3 = FourierDescriptor(caracter(4).Image);
FD_4 = FourierDescriptor(caracter(5).Image);
FD_5 = FourierDescriptor(caracter(6).Image);
FD_6 = FourierDescriptor(caracter(7).Image);


FD_0 = FD_0';
FD_1 = FD_1';
FD_2 = FD_2';
FD_3 = FD_3';
FD_4 = FD_4';
FD_5 = FD_5';
FD_6 = FD_6';

Fourier = [FD_0;FD_1;FD_2;FD_3;FD_4;FD_5;FD_6];


% Calculo de los descriptores basados en la excentricidad.
exc = regionprops(CC,'Eccentricity');
EXC = cell2mat(struct2cell(exc))';

% Calculo del numero de agujeros de las imagenes
eulerNum= regionprops(CC,'EulerNumber');
holes= struct2cell(eulerNum);
holes= cell2mat(holes);

for it= 1:size(holes,2)
    holes(1,it)= abs(holes(1,it) - 1);
end
HOL = holes';
% Calculo de la longitud del mayor eje respecto al perimetro

majorAxis= regionprops(CC,'MajoraxisLength');
perimeter= regionprops(CC, 'Perimeter');

MA = cell2mat(struct2cell(majorAxis));
PE = cell2mat(struct2cell(perimeter));

DIV = MA./PE;
DIVO = DIV';

ret = [DIVO,HOL,EXC,Fourier];
end

