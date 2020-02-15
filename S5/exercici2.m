function ret = exercici2(A)  
    
    k = 9;
    [f, c] = size(A);
    ret = zeros(1,c);
    
    for col = 1:c
        if A(uint32(f)/2 + 1, col) >= (mean(A(:,col)) - k)
            ret(col) = 255;
        else
            ret(col) = 0;
        end
    end
end

