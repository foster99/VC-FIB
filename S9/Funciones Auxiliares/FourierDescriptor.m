function FD = FourierDescriptor(I)
    
    BW = I;
    
    % convertir a escala de grises si no lo esta
    if size(size(BW)) == 3
        BW = rgb2gray(BW);
    end
    
    % convertir a imagen logica si no lo esta
    if ~islogical(BW)
        BW = BW < 40;
    end
    
    % centrar objeto en la imagen
    BW = centerobject(BW);
    
    m = 2;
    n = 2;
    FD = gfd(BW,m,n);

end
