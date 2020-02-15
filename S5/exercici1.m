function level = exercici1(I,alpha)
    
    % calculo de histograma acumulado
    gray = imhist(I);
    for gv = 1:255
        gray(gv+1) = gray(gv) + gray(gv+1);
    end
    
    % Calculo del numero de pixeles
    total = size(I,1)*size(I,2);
    pixel = alpha*total;
    
    % Cuando el numero de pixeles sobre pase la cota, retornamos el valor
    % de gris correspondiente.
    for gv = 1:256
        if gray(gv) > total - pixel
            level = gv;
            break;
        end
    end
    
end

