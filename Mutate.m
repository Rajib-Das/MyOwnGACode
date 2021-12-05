function y=Mutate(x,mu)
  flag=(rand(size(x))<mu); % size(x)=[1,10] so equivalent flag=rand(1,10)<mu that is give row matices of 0 and 1
  y=x;
  
  %flipping mutation is used here
  %x(flag) give those x value where flag value is 1
  % flipping mutation technique is that where flag is one corresponding x
  % vlue will be flipped that is 0 to 1 or 1 to 0
  y(flag)=1-x(flag);
end