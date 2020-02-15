function [OUT, CM] = testResult(OBJECT,MASK)

    MASK = rgb2gray(MASK);
    MASK = MASK > 100;
    OUT = [OBJECT MASK];
    
    MASK = im2col(MASK, [1 1], 'distinct')';
    OBJECT = im2col(OBJECT, [1 1], 'distinct')';
    
    CM = confusionmat(MASK, OBJECT);
end

