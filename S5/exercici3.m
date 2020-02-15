function RGB = exercici3(I)  
    rows = size(I,1);
    cols = size(I,2);
    total = rows*cols;
    
    % Aplicaremos kmeans segun el color (HUE) de cada pixel.
    
    HSV = rgb2hsv(I);
    Hue = HSV(:,:,1);
    
    % Transformamos el color a cordenadas espaciales para que haya similut
    % entre valores del HUE cercanos a 0 y 360 grados (ya que es ciclico) y
    % que de este modo kmeans los interprete como colores parecidos.
    
    F = zeros(total, 2);
    pos=1;
    for i = 1:rows
        for j= 1:cols
            F(pos,1)= cos(Hue(i,j));
            F(pos,2)= sin(Hue(i,j));
            pos= pos + 1;
        end
    end

    ret = kmeans(F,4);
    
    % Binarizamos cada cluster en una imagen distinta.
    
    Res1 = zeros(rows,cols);
    Res2 = zeros(rows,cols);
    Res3 = zeros(rows,cols);
    Res4 = zeros(rows,cols);
    
    pos = 1;
    for i = 1:rows
        for j= 1:cols
            switch ret(pos)
                case 1
                    Res1(i,j) = 255;
                case 2
                    Res2(i,j) = 255;
                case 3
                    Res3(i,j) = 255;
                case 4
                    Res4(i,j) = 255;
            end
            pos= pos + 1;
        end
    end

    % Obtenemos la CC de cada cluster

    CC1 = bwconncomp(Res1,4);
    CC2 = bwconncomp(Res2,4);
    CC3 = bwconncomp(Res3,4);
    CC4 = bwconncomp(Res4,4);

    % Obtener la CC mas grande de cada cluster.

    pixel1 = CC1.PixelIdxList;
    max1 = 0;
    for i = 1:size(pixel1,2)
        AUX = cell2mat(pixel1(1,i));
        aux = size(AUX,1);
        if aux > max1
            max1 = aux;
            MAX1 = AUX;
        end
    end
    
    pixel2 = CC2.PixelIdxList;
    max2 = 0;
    for i = 1:size(pixel2,2)
        AUX = cell2mat(pixel2(1,i));
        aux = size(AUX,1);
        if aux > max2
            max2 = aux;
            MAX2 = AUX;
        end
    end
    pixel3 = CC3.PixelIdxList;
    max3 = 0;
    for i = 1:size(pixel3,2)
        AUX = cell2mat(pixel3(1,i));
        aux = size(AUX,1);
        if aux > max3
            max3 = aux;
            MAX3 = AUX;
        end
    end
    pixel4 = CC4.PixelIdxList;
    max4 = 0;
    for i = 1:size(pixel4,2)
        AUX = cell2mat(pixel4(1,i));
        aux = size(AUX,1);
        if aux > max4
            max4 = aux;
            MAX4 = AUX;
        end
    end

    % Pintar cada CC de un color distinto.

    RGB = zeros(rows,cols,3);
    for k = 1:size(MAX1)
        i = uint32(mod(MAX1(k),rows));
        if i == 0
            i = rows;
        end
        j = uint32(MAX1(k)/rows) + 1;
        RGB(i,j,1) = 255;
        RGB(i,j,2) = 0;
        RGB(i,j,3) = 0;
    end
    for k = 1:size(MAX2)
        i = uint32(mod(MAX2(k),rows));
        if i == 0
            i = rows;
        end
        j = uint32(MAX2(k)/rows) + 1;
        RGB(i,j,1) = 255;
        RGB(i,j,2) = 0;
        RGB(i,j,3) = 255;
    end
    for k = 1:size(MAX3)
        i = uint32(mod(MAX3(k),rows));
        if i == 0
            i = rows;
        end
        j = uint32(MAX3(k)/rows) + 1;
        RGB(i,j,1) = 0;
        RGB(i,j,2) = 255;
        RGB(i,j,3) = 255;
    end
    for k = 1:size(MAX4)
        i = uint32(mod(MAX4(k),rows));
        if i == 0
            i = rows;
        end
        j = uint32(MAX4(k)/rows) + 1;
        RGB(i,j,1) = 255;
        RGB(i,j,2) = 255;
        RGB(i,j,3) = 0;
    end
    
end
