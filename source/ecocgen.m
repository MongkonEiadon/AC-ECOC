function [Ecoc] = ecocgen(data, k)
d = data;
Ecoc = [];

rem = d;


   
   [sel dt] = select(d);
   n = [1:k];
    %remove selector
   rem = buildecoc(rem, transpose(n));
   
    
%got left


function [dt] = buildecoc(dt, node)
    if length(node) > 1
        
        ix = (ismember(dt(:, 1), node) | ismember(dt(:,2),node));

        [s dt] = select(dt(ix,:));

        if size(dt,1) > 0
            l = transpose( takechild(dt, s(:,1)));
            r = transpose( takechild(dt, s(:,2)));
        else
            l = s(:,1);
            r = s(:,2);
        end
        
        i = zeros(k,1);

        i(l,:) = 1;
        i(r,:) = -1;

        Ecoc = [Ecoc, i]

        buildecoc(dt, r);
        buildecoc(dt, l);
  
    end
end

function [select dt] = select(dt)

    if(size(dt,1) > 1)
        [v x] = max(dt);
        x = x(:,3);
    
    
        %remove selector
        select = dt(x, :);
        dt(x, :) = [];
    else
        select = dt;
        dt = [];
    end
    
end



function [dt] = takechild(rem, dt)
        ix = (ismember(rem(:, 1), dt) | ismember(rem(:,2),dt));
        if(size(rem,1) > 0 & sum(ix,1) > 0)
            dt = [dt, transpose(rem(ix, 1)), transpose(rem(ix,2))];
            
            rem(ix,:) = [];
            dt = takechild(rem, unique(dt));
        else
            dt = dt;
        end
end
end
