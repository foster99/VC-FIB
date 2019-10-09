function [] = ejercicio_1(I)

disp("Ejercicio 1:");
disp("Marca la posicion de la fila i la columna con mas intensidad.");

BN = rgb2gray(I);
Rows = zeros(1,size(BN,1),'uint32');
Cols = zeros(1,size(BN,2),'uint32');

for i = 1 : size(BN,1)
    for j = 1 : size(BN,2)
        Rows(1,i) = Rows(1,i) + uint32(BN(i,j));
        Cols(1,j) = Cols(1,j) + uint32(BN(i,j));
    end
end

[~, posR] = max(Rows);
[~, posC] = max(Cols);
position = [posC posR];

M = insertMarker(I, position, 'o');
imshow(M);
end

