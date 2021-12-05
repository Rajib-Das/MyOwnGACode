clc;
clear;
close all;
%Binary GA
%problem definition
CostFunction=@(x) MinProblemSumOfOne(x);
nVar=100;

%Params
MaxIt=100;
nPop=100;
%crossOver Parameter
pC = 1;% percentage of Children (by default it is 1 but one can increase or decrease this percentage)
%round(.75*70)=53 this example odd number come so for this divide by 2and multiply by 2 method used 
%round(.75*70/2)=52
%round(.75*70/2)*2=52
%nC=round(pC*nPop); % number of Offsprings should be even number
nC=round(pC*nPop/2)*2;% nC=number of Offspring


mu = 0.02; %mu=mutation rate or probability ....here it is 20%
beta = 1;

%Template for empty individual
empty_individual.Position=[];
empty_individual.Cost=[];

%Best Solutions Ever Found
bestsol.Cost=inf;
%Initialization population and cost estimation
   pop=repmat(empty_individual,nPop,1);
   for i=1:nPop
       % Generate Random Solution or Individual
      pop(i).Position=randi([0,1],1,nVar); 
      %Evaluate Cost Function
      pop(i).Cost=CostFunction(pop(i).Position);
      % Compare Best Solua=tion Ever Found
      if pop(i).Cost<bestsol.Cost
          bestsol=pop(i);
      end
   end

   
%Best Cost of Iterations
bestcost=nan(MaxIt,1);

%Main Evolution loop of iteration(CrossOver, Mutation, Marge Main pop and Offspring,sort, selection of new pop )
for it=1:MaxIt
    
    % selection probability use Boltzman distribution
    % this selection probability use for RouletteWheelSelection
    c=[pop.Cost];
    avgc=mean(c);% avgc=avergage cost
    if avgc ~=0
          c=c/avgc;
    end
    probs=exp(-beta*c);
    
    
    %Initialize Offsprings population
    popc=repmat(empty_individual,nC/2,2); %popc=population of children
    
    %Crossover
    for k=1:nC/2
        
        %select Parents % this is selection process here we use random
        %permutation selection process where we select rendomly permuted
        %two parents % this selection process is not fair process
        %q=randperm(nPop);
        %p1=pop(q(1));
        %p2=pop(q(2)); 
        
        %Here we use RouletteWheel Selection process
        p1=pop(RouletteWheelSelection(probs));
        p2=pop(RouletteWheelSelection(probs));
        
        % perform crossover here
       %[popc(k,1).Position,popc(k,2).Position]=...
          % SinglePointCrossover(p1.Position,p2.Position);
       %[popc(k,1).Position,popc(k,2).Position]=...
         %  DoublePointCrossover(p1.Position,p2.Position);
       [popc(k,1).Position,popc(k,2).Position]=...
           CombineThreeCrossover(p1.Position,p2.Position);
       % here u can evaluate costfunction by newly offspring before
       % mutation or u can evaluate costfunction after mutation
       %here I do not evaluate
    end
    
    % Convert popc to Single column Matrix
    popc=popc(:);
        
    %Mutation
    % In mutation probability should be given that is depen on problem specification 
   for w=1:nC
       %perform mutation
       popc(w).Position=Mutate(popc(w).Position,mu);
       
       %Evaluate Cost Function
       popc(w).Cost=CostFunction(popc(w).Position);
       
       % Compare Best Solua=tion Ever Found
      if popc(w).Cost<bestsol.Cost
          bestsol=popc(w);
      end
   end
      
 
   %Merge Populations
   pop =[pop; popc];
   
   %Sort Populations
   [~,so]=sort([pop.Cost]);
   % here so=sort order which say about individual position and
   %first parameter give sorted cost but here we do not need cost so we use
   % ~ sign for example if minimum cost come from 7th individual then (so)
   % give first rank 7 
   pop=pop(so);
   
   %Remove Extra Populations that is we take only top/upper first nPop
   % that is select population for next generation
   % selection is two type one is parent selection for crossover and
   % mutation and another is populatio selection for next generation 
   pop=pop(1:nPop);
   
   
   %Update best Cost of Iteration
   bestcost(it)=bestsol.Cost;
   
   %Display Iteration Informations
   disp(['Iterations' num2str(it) ':Best Cost=' num2str(bestcost(it))]);

% Here we plot every iterations best value
figure(1);
plot(bestcost,'r*', 'MarkerSize', 8);
xlabel('Iterations');
ylabel('BestCost');
pause(0.01);
grid on;

   
end

%Results
%figure;
%plot(bestcost);
%xlabel('Iterations');
%ylabel('BestCost');
%grid on;


