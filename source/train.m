
m = abalone;
acc = kfoldCrossAccuracies(m, 10);

d = prim(acc);
ecoc = ecocgen(d, size(acc,1));


X = m(:, 1:end);
Y = m(:, end);


    
%humming distance
a = pdist(ecoc, 'hamming');
a = squareform(a);

total = sum(sum(a)) / 2


template = templateSVM('KernelFunction', 'rbf',  'KernelScale', 'auto', 'BoxConstraint', 1, 'Standardize', 1);
trainedClassifier = fitcecoc(X, Y, 'Learners', template, 'Coding', ecoc);
partModel = crossval(trainedClassifier, 'KFold', 10);
Accuracy = 1 - kfoldLoss(partModel, 'LossFun', 'ClassifError');
[validationPredictions, validationScores] = kfoldPredict(partModel);
confmat=confusionmat(Y,validationPredictions);


