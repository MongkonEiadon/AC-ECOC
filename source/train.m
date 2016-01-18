
m = isolet5;
[Acc, Err] = kfoldCrossAccuracies(m, 10);


ecoc_acc = ecocgen(prim(Acc), size(Acc,1));
ecoc_err = ecocgen(prim(Err), size(Err,1));


X = m(:, 1:end-1);
Y = m(:, end);

%humming distance
% a = pdist(ecoc, 'hamming');
% a = squareform(a);
% 
% total = sum(sum(a)) / 2

%------------------acc_ecoc----------------------
template = templateSVM('KernelFunction', 'rbf',  'KernelScale', 'auto', 'BoxConstraint', 1, 'Standardize', 1);
Mdl = fitcecoc(X, Y, 'Learners', template, 'Coding', ecoc_acc);
partModel = crossval(Mdl, 'KFold', 10);
kfLoss = kfoldLoss(partModel, 'lossfun', 'ClassifError');
Accuracy = 1 - kfLoss;
[validationPredictions, validationScores] = kfoldPredict(partModel);
confmat=confusionmat(Y,validationPredictions);

kfLossdesignEcocAcc = kfLoss
codingMatdesignEcocAcc = size(Mdl.CodingMatrix)

%------------------err_ecoc----------------------
template = templateSVM('KernelFunction', 'rbf',  'KernelScale', 'auto', 'BoxConstraint', 1, 'Standardize', 1);
Mdl = fitcecoc(X, Y, 'Learners', template, 'Coding', ecoc_err);
partModel = crossval(Mdl, 'KFold', 10);
kfLoss = kfoldLoss(partModel, 'lossfun', 'ClassifError');
Accuracy = 1 - kfLoss;
[validationPredictions, validationScores] = kfoldPredict(partModel);
confmat=confusionmat(Y,validationPredictions);

kfLossdesignEcocErr = kfLoss
codingMatdesignEcocErr = size(Mdl.CodingMatrix)


%------------------ovo----------------------
template = templateSVM('KernelFunction', 'rbf',  'KernelScale', 'auto', 'BoxConstraint', 1, 'Standardize', 1);
Mdl = fitcecoc(X, Y, 'Learners', template, 'Coding', 'onevsone');
partModel = crossval(Mdl, 'KFold', 10);
kfLoss = kfoldLoss(partModel, 'lossfun', 'ClassifError');
Accuracy = 1 - kfLoss;
[validationPredictions, validationScores] = kfoldPredict(partModel);
confmat=confusionmat(Y,validationPredictions);

kfLossOVO = kfLoss
codingMatOVO = size(Mdl.CodingMatrix)


%------------------ova----------------------
template = templateSVM('KernelFunction', 'rbf',  'KernelScale', 'auto', 'BoxConstraint', 1, 'Standardize', 1);
Mdl = fitcecoc(X, Y, 'Learners', template, 'Coding', 'onevsall');
partModel = crossval(Mdl, 'KFold', 10);
kfLoss = kfoldLoss(partModel, 'lossfun', 'ClassifError');
Accuracy = 1 - kfLoss;
[validationPredictions, validationScores] = kfoldPredict(partModel);
confmat=confusionmat(Y,validationPredictions);


kfLossOVA = kfLoss
codingMatOVA = size(Mdl.CodingMatrix)

%------------------sparse----------------------
template = templateSVM('KernelFunction', 'rbf',  'KernelScale', 'auto', 'BoxConstraint', 1, 'Standardize', 1);
Mdl = fitcecoc(X, Y, 'Learners', template, 'Coding', 'sparse');
partModel = crossval(Mdl, 'KFold', 10);
kfLoss = kfoldLoss(partModel, 'lossfun', 'ClassifError');
Accuracy = 1 - kfLoss;
[validationPredictions, validationScores] = kfoldPredict(partModel);
confmat=confusionmat(Y,validationPredictions);


kfLossSparse = kfLoss
codingMatSparse = size(Mdl.CodingMatrix)


%------------------dense----------------------
template = templateSVM('KernelFunction', 'rbf',  'KernelScale', 'auto', 'BoxConstraint', 1, 'Standardize', 1);
Mdl = fitcecoc(X, Y, 'Learners', template, 'Coding', 'dense');
partModel = crossval(Mdl, 'KFold', 10);
kfLoss = kfoldLoss(partModel, 'lossfun', 'ClassifError');
Accuracy = 1 - kfLoss;
[validationPredictions, validationScores] = kfoldPredict(partModel);
confmat=confusionmat(Y,validationPredictions);


kfLossDense = kfLoss
codingMatDense = size(Mdl.CodingMatrix)



