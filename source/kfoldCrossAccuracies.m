
function [Acc, Err] = kfoldCrossAccuracies(m, nfold) 

if nargin < 2 nfold = 10; end;
k = unique(m(:, end));

Acc = zeros(size(k,1), size(k,1));
Err = Acc;
for i = 1:size(k,1)
   for j= 1:size(k,1)
       
       if i==j Acc(i,j) = 1;
       else if i > j
           m1idx = (m(:,end) == k(i));
           m2idx = (m(:,end) == k(j));
           m1 = m(m1idx, :);
           m2 = m(m2idx, :);
          
           %print out
           disp(['class '   num2str(i)  ' : '  num2str(j)]);

           [Acc(i,j), Err(i,j), ~] = kfoldCrossAccuracy(m1, m2, nfold);
           Acc(j,i) = Acc(i,j);
           Err(j,i) = Err(i,j);
       end
   end
end

%create prim data structure
% acc_data = zeros(3, size(k,1) * size(k,1));
% running = 1;
% for i=1:size(k,1)
%     for j=1:size(k,1)
%         acc_data(:, running) = [i; j; Acc(i,j)];
%         running = running+1;
%     end
% end
% 
% [~,~,p] = prim(acc_data);
% cmatrix = zeros(size(k,1), size(k,1));
% for i=1:2
%     for j=1:size(cmatrix,2)
%         
%     end
% end


end

