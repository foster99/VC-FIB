function [] = ejercicio_3(im)

im2= imresize(im,3);
im3= imresize(im,3,"nearest");

im2= imresize(im2,1/7);
im3= imresize(im3,1/7,"nearest");

im2= imresize(im2,7);
im3= imresize(im3,7,"nearest");

im2= imresize(im2,1/3);
im3= imresize(im3,1/3,"nearest");

im2= imresize(im2,[size(im,1),size(im,2)]);
im3= imresize(im3,[size(im,1),size(im,2)],"nearest");

im=rgb2gray(im);
im2=rgb2gray(im2);
im3=rgb2gray(im3);

u1 = 0;
u2 = 0;
u3 = 0;

for row= 1:size(im,1)
    for col=1:size(im,2)
        u1=u1+double(im(row,col));
        u2=u2+double(im2(row,col));
        u3=u3+double(im3(row,col));
    end
end

u1 = u1/(size(im,1)*size(im,2))
u2 = u2/(size(im,1)*size(im,2))
u3 = u3/(size(im,1)*size(im,2))

s1=0;
s2=0;
s3=0;

for row= 1:size(im,1)
    for col=1:size(im,2)
        s1= s1 + (double(im(row,col))-u1)^2;
        s2= s2 + (double(im2(row,col))-u2)^2;
        s3= s3 + (double(im3(row,col))-u3)^2;
    end
end

s1=s1/((size(im,1)*size(im,2))-1);
s2=s2/((size(im,1)*size(im,2))-1);
s3=s3/((size(im,1)*size(im,2))-1);

s1 = sqrt(s1);
s2 = sqrt(s2);
s3 = sqrt(s3);

s1
s2
s3
end


