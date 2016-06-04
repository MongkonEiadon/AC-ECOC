function kNor = kNormalize(d)

dmin = min(d);
dmax = max(d);

for i=1 : size(d,2)
    d(i) = (d(i) - dmin) / (dmax - dmin);
    
    if d(i) <= 0.382
         d(i) = -1;
    elseif d(i) > 0.382 && d(i) <= 0.618
         d(i) = 0;
        else d(i) = 1;
    end;
    
end

kNor = d;


end