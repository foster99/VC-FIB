function [] = ejercicio_2(im)
im2= rgb2gray(im);
grey= zeros(1,256);

for row = 1:size(im2,1)
    for col = 1:size(im2,2)
        grey(im2(row,col)+1) = grey(im2(row,col) +1)+ 1;
    end
end

bar(grey);
end

