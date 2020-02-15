I = double(zeros(101));

for i=50:101
    I(i,:) = 255;
end

result = zeros(1,901);

kernelH = [ 2  2  4  2  2; 1  1  2  1  1; 0  0  0  0  0; -1 -1 -2 -1 -1; -2 -2 -4 -2 -2];
kernelV = kernelH';

index = 1;
for theta = 0:0.1:90
    
    A = imrotate(I, theta,'bicubic','crop');
    A = imfilter(A,fspecial('gaussian',10,2));
    
    Ax = imfilter(A, kernelH);
    Ay = imfilter(A, kernelV);
    
    alpha = mod((atan2(Ay(50,50),Ax(50,50)))*180/pi+180, 360);
    result(1,index) = abs(theta - alpha);

    index = index + 1;
end

MaxError = max(result)
plot(result);
