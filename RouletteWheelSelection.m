function i=RouletteWheelSelection(p)
    
% following code is for if p is fractional probability and less than 1
    %r=rand;
    %c=cumsum(p);
   % i=find(r<=c,1,'first');


% following code for if p is a integer value
    r=rand*sum(p);
    c=cumsum(p);
    i=find(r<=c,1,'first');
    
end