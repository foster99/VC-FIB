function [DATA, BLOCK_MAP, widthAdjusted, heigthAdjusted] = extractFeatures(I, n, m)

width = size(I,2);
heigth = size(I,1);

hsvI = rgb2hsv(I);
BN = rgb2gray(I);

%%%%%%%%%%%%%%%%%%%%%%%%%%%% BLOCK SEPARATION %%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    
%%% PREPARACION %%%

    % Parametros deducidos
    heigthAdjusted = heigth - mod(heigth, n);    % altura alineada al tamano del bloque
    widthAdjusted = width - mod(width, m);       % anchura alineada al tamano del bloque
    NumBlocks = heigthAdjusted/n * widthAdjusted/m;
    
    % Matrices auxiliares
    BLOCK_MAP = zeros(heigth,width);       % Mapeo de pixeles a bloques

%%% CALCULOS %%%

    % Calculo del mapping pixel - bloque
    colBlocks = heigthAdjusted/n;
    for j = 1:widthAdjusted
        for i = 1:heigthAdjusted
            BLOCK_MAP(i,j) = ceil(i/n) + colBlocks * (ceil(j/m) - 1);
        end
    end
    

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% HOG %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
qtt = 3;    % qtt of descriptors per window
[HOG, ~] = extractHOGFeatures(BN,'CellSize',[n m],'BlockSize',[1 1], ...
                                'NumBins',qtt,'BlockOverlap',[0 0]);
HOG_FULL = im2col(HOG, [1 qtt], 'distinct')';
DATA = HOG_FULL;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% LBP %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

LBP = extractLBPFeatures(BN,'CellSize',[n m]);
Q = size(LBP,2)/NumBlocks;
LBP_FULL = im2col(LBP, [1 Q], 'distinct')';
LBP_FULL = LBP_FULL(:,Q-0:Q);
DATA = [DATA LBP_FULL];

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% VALUE %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
val = hsvI(:,:,3);
val = im2col(val, [n m], 'distinct');
val = val(:,1:NumBlocks);

valMean = mean(val)';
DATA = [DATA valMean];

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% SATURACION %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
hsvI = rgb2hsv(I);
sat = hsvI(:,:,2);
sat = im2col(sat, [n m], 'distinct');
sat = sat(:,1:NumBlocks);

satMean = mean(sat)';
DATA = [DATA satMean];

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% HUE %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
hue = hsvI(:,:,1);
hue = im2col(hue, [n m], 'distinct');
hue = hue(:,1:NumBlocks);

hueMean = mean(hue)';
hueSin = sin(hueMean);
hueCos = cos(hueMean);
DATA = [DATA hueSin hueCos];

%%%%%%%%%%%%%%%%%%%%%%%%%%%% HSV HISTOGRAM %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% hsvHist = zeros(NumBlocks,16,4,4);
% for col = 1 : widthAdjusted
%     for row = 1 : heigthAdjusted
%         hBin = floor(hsvI(row, col, 1) * 15.9999)+ 1;
%         sBin = floor(hsvI(row, col, 2) * 3.9999)+ 1;
%         vBin = floor(hsvI(row, col, 3) * 3.9999)+ 1;
%         hsvHist(BLOCK_MAP(i, j), hBin, sBin, vBin) = ...
%                    hsvHist(BLOCK_MAP(i, j), hBin, sBin, vBin) + 1;
%     end
% end
% 
% HH = [];
% for block = 1 : NumBlocks
%     HH = [HH; hsvHist(block, :)];
% end
% 
% DATA = [DATA HH];

end





































