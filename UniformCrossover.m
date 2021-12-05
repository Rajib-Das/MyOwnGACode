function [y1,y2]=UniformCrossover(x1,x2)
   
   alpha=randi([0,1],size(x1)); % give x1 size row vector
   
   % here uniform working procedure is that if we get any index alpha value
   % is 1 then we swap that index value of x1 and x2
   y1=(1-alpha).*x1+alpha.*x2;
   y2=(1-alpha).*x2+alpha.*x1;
   
end