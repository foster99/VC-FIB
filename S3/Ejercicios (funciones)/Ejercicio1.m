
function promig = Ejercicio_1(A)
    
    [f, c] = size(A);
    
    f = double(f);
    c = double(c);
    
    pixels = A(1+uint32(f)/2,:);
    zero =  zeros(1,c);
    
    black_pixels = xor(pixels,zero);
    white_pixels = xor((pixels-255),zero);
    
    
    pixel = or(not(black_pixels), not(white_pixels));
    not_pixel = not(pixel);
    
    noise = pixel .* (sum(A)/f);
    promig = pixels .* not_pixel + noise;

end

