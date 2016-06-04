function [Acc, Err] = dataPatches(data)


[Acc, Err] = kfoldCrossAccuracies(data, 10);

end