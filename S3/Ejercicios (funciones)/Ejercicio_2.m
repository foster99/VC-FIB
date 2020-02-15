
function promig = Ejercicio_2(A)
    % Paso 0
    [f, c] = size(A);
    c = double(c);
    % Paso 1
    original = A(1+uint32(f)/2,:);
    % Paso 2
    zero =  zeros(1,c);
    black_pixels = xor(original,zero);
    white_pixels = xor((original-255),zero);
    % Paso 3
    noise = or(not(black_pixels), not(white_pixels));
    % Paso 4
    not_noise = not(noise);
    % Paso 5
    promig = not_noise.*original + noise.*median(A);
end

