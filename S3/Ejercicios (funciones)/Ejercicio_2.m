
function promig = Ejercicio_2(A)
    
    [f, c] = size(A);
    
    f = double(f);
    c = double(c);
    
    % En la variable original guardamos los pixeles centrales aleatorios
    original = A(1+uint32(f)/2,:);
    
    % Para separar los pixeles ruidosos (negros y blancos) del resto.
    % Negros:   realizamos una operacion XOR entre los originales y un
    %           vector completo de ceros. Obtenemos como resultado un
    %           vector lleno de unos excepto alli donde hay un pixel negro.
    %
    %  Blancos: Siguiendo el mismo razonamiento, a los pixeles originales
    %           les restamos el color blanco (255) poniendo a si los
    %           pixeles blancos a 0 para poder aplicar la misma operacion
    %           que para los negros.
    %
    zero =  zeros(1,c);
    black_pixels = xor(original,zero);
    white_pixels = xor((original-255),zero);
    
    % Negamos los vectores, obteiendo como resultado, vectores con 1 en las
    % posiciones donde hay pixeles que pertenecen al ruido. A su vez,
    % aplicamos una OR para unificar ambos conjuntos en un solo vector, el
    % que recibe el nombre noise (pixeles que forman parte del ruido = 1).
    
    noise = or(not(black_pixels), not(white_pixels));
    
    % De nuevo, negamos el vector de pixeles ruidosos, obteniendo asi el
    % vector de pixeles no ruidosos. 
    
    not_noise = not(noise);
    
    % Finalmente, utilizamos los anteriores vectores a modo de mascara,
    % aplicando la operacion de la media a los pixeles ruidosos y dejando
    % los pixeles originales en caso de no pertenecer al ruido.
    %
    % Una de las dos partes de la suma siempre sera 0, ya que los vectores
    % mascara son complementarios. 
    
    promig = not_noise.*original + noise.*median(A);

end

