

function [ acc, err, confumat ] = kfoldCrossAccuracy(m1, m2, nfold)
if nargin < 3 nfold = 10; end;

data = [m1; m2];
if(size(data,1) <=3)
   data = [data; data;];
end

Groups = ismember(data(:,end), m1(1,end));

cvFolds = crossvalind('Kfold', Groups, nfold);
cp = classperf(Groups);
x = unique(cvFolds);

if(size(data,1) <3)
    a = 1;
end

for i=1:size(x,1)
    testidx = (cvFolds == x(i));
    trainidx = ~testidx;
    
    svmModel = svmtrain(data(trainidx, 1:end-1), Groups(trainidx), ...
        'Autoscale',true, 'Showplot',false, 'Method','QP', ...
         'BoxConstraint',2e-1, 'Kernel_Function','rbf', 'RBF_Sigma',1);

     pred = svmclassify(svmModel, data(testidx, 1:end-1), 'Showplot', false);
     
     cp = classperf(cp, pred, testidx);
end

acc = cp.CorrectRate;
err = cp.ErrorRate;
confumat = cp.CountingMatrix;

end



