function [] = ejercicio_4(A,B,T)

disp("Ejercicio 4:");
disp("Concatena la imagen A transformada segun la matriz de transformacion T con la imagen B.");

A_trans = imwarp(A,T);
[rowB, colB, ~] = size(B);
[rowA, colA, ~] = size(A_trans);

if (colA/rowA < colB/rowB) %mas vertical A que B
    disp("Modo 1");
    AR = imresize(A_trans, [rowB NaN]);
    [~, colAR, ~] = size(AR);
    AR(1,end+(colB-colAR),1) = 0;
    AR = imtranslate(AR, [((colB-colAR)/2) 0 0]);
else
    disp("Modo 2");
    AR = imresize(A_trans, [NaN colB]);
    [rowAR, ~, ~] = size(AR);
    AR(end+(rowB-rowAR),1,1) = 0;
    AR = imtranslate(AR, [0 ((rowB-rowAR)/2) 0]);
end

C = B + 0.5*AR;
imshow(C);
end

