
function Ejercicio_4(path, alpha,size)
    H = zeros(size);
    
    H(int32(floor(size)/2),1:size) = 1;
   
    H = H/ceil(size/2);
    
    H = imrotate(H,alpha);
    
    I=imread(path);
    B = imfilter(I,H);
    
    imshow(B);
end