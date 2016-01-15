function [ecoc] = ecocgen(data, k)
d = data;
ecoc = zeros(k, k-1);

l = [];
r = [];
rem = d;


while (size(rem,1)) ~= 0
   
    [val idx] = max(rem);
    
    l =[ rem(idx(:,3),1) ];
    r = [ rem(idx(:,3),2) ];
    
    %remove selector
    rem(idx(:,3), :) = [];
    
    l = takechild(rem, l);
    r = takechild(rem,r);
    
    
end




%got left


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
