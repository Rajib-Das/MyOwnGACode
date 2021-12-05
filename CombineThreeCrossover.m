function [y1, y2]=CombineThreeCrossover(x1,x2)
  

   % this is randomized and stochastic combination process
    m=randi([1,3]);
    switch m
        case 1
            [y1,y2]=SinglePointCrossover(x1,x2); % here it is look like that selecting
                                                  %of case 1 probability is 33.33 percent
            
        case 2
            [y1,y2]=DoublePointCrossover(x1,x2);% here it is look like that selecting
                                                  %of case 2 probability is 33.33 percent
            
        otherwise
             [y1,y2]=UniformCrossover(x1,x2);% here it is look like that selecting
                                               %of  this case  probability is 33.33 percent
    end        
    
end