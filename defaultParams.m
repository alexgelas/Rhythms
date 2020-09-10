folder='figuresTest'; % Where to save figures etc.
nameSuffix=''; % Text to append at the end of filename when saving. Useful for distinguishing saved simulations results with different parameters.

largeDt=0.2; % Simulation step; Simple Euler method is used. The step becomes finer when changes in values are large.
saveStep=1; % Every how many steps record value? (for analysis, plots etc.)

steps=5000; % Number of simulation steps. Simulation time is (steps)*(largeDt)

% Network binary parameters
oneCell=0;
realIB=0;
realRS=0;
multiplex=0;

moreApicalH=0;

% Plotting binary parameters
plotAll=0; % Show soma and dendrite membrane potentials in plot?
showUnits=1;
thinISI=0; % Used in plotIBibiHist
numGammaPeriods=5; % Used in plotVperiodic

% Some synapse parameters
gFStoSI=8; % Strength of FS->SI synapse
gGammaToSI=5; % Input-1 -> SI

% Input Parameters
gammaInput=1;
gammaFreq=40;
gammaJitter=0;

beta1Freq=16.357; % Input-2 is on whenever IB cell is not present
betaJitter=0;