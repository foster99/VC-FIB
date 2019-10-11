function ejercicio_3(path)
I=imread(path);
I=rgb2gray(I);

I=imgaussfilt(I,0.6);

B=edge(I,'sobel');

[Gmag, Gdir] = imgradient(I,'sobel');

for i= 1:size(I,1)
    for j=1:size(I,2)
        if Gmag(i,j) > 100
            I(i,j)=255;
        else
            I(i,j)=0;
        end
    end
end
imshow(I);
end