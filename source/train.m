
m =segment;

% acc = kfoldCrossAccuracies(m, 10);
% 
% p = prim(acc);

d = prim(segmentResult);

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

