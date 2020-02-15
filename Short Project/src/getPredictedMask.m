function [OBJECT, contorno] = getPredictedMask(Model, model, DATA, BLOCK_MAP, w, h, bordear, sx, wx, sy, wy)

% Informacion de los parametros de entrada
%
% Model:        Modelo entrenado.
% model:        Identficador del tipo de modelo.
% DATA:         Datos recopilados de la imagen.
% BLOCK_MAP:    Mapping pixel-bloque.
% w:            Anchura del bloque inspeccionado.
% h:            Altura del bloque inspeccionado.
%
% bordear:      Booleno que indica si quieres el borde perfilado (true) o
%               solo el rectangulo que lo contiene (false).
% sx:           cordenada x donde empieza el rectangulo del usuario
% wx:           anchura del rectangulo del usuario
% sy:           cordenada y donde empieza el rectangulo del usuario
% wy:           altura del rectangulo del usuario
%
% Informacion de los parametros de salida
%
% OBJECT:       Imagen binaria que contiene
% contorno:     Contorno o rectangulo que lo contiene (segun "bordear")

%% Preparacion %%

if bordear
    startX = sx;
    endX = sx + wx;
    startY = sy;
    endY = sy + wy;
else
    startX = 1;
    endX = w;
    startY = 1;
    endY = h;
end

%% Prediction %%

% TreeBagger
if model == 1
    prediction = cell2mat(predict(Model, DATA));
    RESULT = false(size(BLOCK_MAP,1), size(BLOCK_MAP,2));
    for j = startX:endX
        for i = startY:endY
            RESULT(i,j) = prediction(BLOCK_MAP(i,j)) == '1';
        end
    end
    
% SVM
else
    prediction = predict(Model, DATA);
    RESULT = false(size(BLOCK_MAP,1), size(BLOCK_MAP,2));
    for j = startX:endX
        for i = startY:endY
            RESULT(i,j) = prediction(BLOCK_MAP(i,j));
        end
    end
end


% Buscamos la componente mas grande
    CC = bwconncomp(RESULT);
    numOfPixels = cellfun(@numel,CC.PixelIdxList);
    [~, indexOfMax] = max(numOfPixels);
    
    OBJECT = zeros(size(RESULT));
    OBJECT(CC.PixelIdxList{indexOfMax}) = 1; 

%% Contorno
    
    
% Dependiendiendo del parametro, calcularemos un tipo de borde u otro
    
    if ~ bordear 
        
        % Marcamos la caja que contiene el objeto
        PP = regionprops(OBJECT, 'BoundingBox');
        contorno = PP.BoundingBox;
    else
    
        % Opening
        RESULT = imopen(OBJECT, strel('disk', 4));
        OBJECT = zeros(size(RESULT));
        OBJECT(CC.PixelIdxList{indexOfMax}) = 1;
        
        % Filling
        F = zeros(size(OBJECT, 1), size(OBJECT, 2));
        F(1,1) = 1;
        F = (F == 1);
        
        OBJECT = not(imreconstruct(F, not(OBJECT), 4));
        contorno = xor(OBJECT, imdilate(OBJECT, strel('disk', 3)));
    end

end
