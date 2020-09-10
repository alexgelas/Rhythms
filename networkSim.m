tic

% Parameters for simulation and saving results
smallDt=0.005;

dt=largeDt;

numSmallSteps=largeDt/smallDt;

quickRun=true; % quickRun means using Euler method (instead of trapezoid) and a larger time step whenever there is no spike and no large changes in the state variables. This was used for all simulations

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

initialize;

for i=1:steps
    
    % Print out the simulation step
    if (mod(i,200/largeDt)==0 && i<=1000/largeDt) || (mod(i,500/largeDt)==0  && i>1000/largeDt)
        i
    end
    
    updateInputV;
    
    % Main update in loop
    if quickRun
        update;
    else
        update2; % unused
    end

    % Save results at each step
    saveState;
    
end

elapsedTime=toc