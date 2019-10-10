
function F = Ejercicio_1(A)
    
% Vamos a realizar la media respecto a los vecinos mas proximos a cada
% pixel, y por lo tanto, en caso de aplicar un solo filtro, utilizariamos
% una matriz de 3x3.
%
% Como lo separamos en la aplicacion de dos filtros, vertical y horizontal,
% creamos dos matrices de dimension 1x3 y 3x1 respectivamente.

    ones_h = ones(1,3)/3;
    ones_v = ones_h';    
    
% Sobre la imagen original aplicamos el filtro horizontal, y posteriormente
% sobre la imagen filtrada horizontalmente, aplicamos el filtro vertical.

    F = imfilter(A, ones_h);
    F = imfilter(F, ones_v);

end

