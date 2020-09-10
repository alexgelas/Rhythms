Code used in "Interactions of multiple rhythms in a biophysical network of neurons" (Submitted to J Math Neuroscience)

Runs in Matlab 2016a.

A folder whose name is specified as a variable (folder='...') must be present in the same directory (figures and some simulation data will be saved there). Default name is "figures" (specified in defaultParams.m, defaultParamsIF.m, defaultParamsAbstract.m).

To produce the figures in the paper, run the code below (in MATLAB).

Notes:
- Most of the code has been adapted from a different project, so some conventions and names of variables might not make sense. It has been mostly cleaned up, but there might still be some parts of the code that are not used at all for this paper.
- The following code will produce the figures used in the paper, but some extra figures might be produced as well in the process. They will all be saved both as .pdf and .fig files.
- The majority of the figures are produced in a few minutes or less. Progress of most simulations is shown by printing out the simulation step every 10000 steps. Certain code lines that involve many simulations will take hours to complete (on an average 2017 laptop); I've added the word slow in parenthesis to mark those.

Figure 1: -

Figure 2:
defaultParams
realIB=1;
realRS=1;
gammaInput=0;
plotAll=1;
nameSuffix='4cells-noInput'
networkSim
plotV

Figure 3:
defaultParams
realIB=1;
realRS=1;
gammaJitter=0.025;
steps=100000;
plotAll=1;
nameSuffix='4cells-40Hz-jitter0025'
networkSim
plotV
phaseHistIBfromGamma

Figure 4:
defaultParams
realIB=1;
gammaJitter=0.025;
steps=100000;
nameSuffix='3cells-40Hz-jitter0025'
networkSim
plotV
phaseHistIBfromGamma

Figure 5:
defaultParams
nameSuffix='2cells-40Hz-16357Hz'
networkSim
plotV

Figure 6:
Generate and plot data:
statsSetting=1;
statsSIvsInput2 (slow)

If data has already been generated:
folder='...'; (set folder path)
nameSuffix='SIvsInput2-40Hz';
plotSIvsInput2


Figure 7:
defaultParams
steps=100000;
nameSuffix='2cells-40Hz-16357Hz'
networkSim
probaSpikeVSinputPhase

Figure 8:
defaultParams
gammaJitter=0.05;
steps=100000;
nameSuffix='2cells-40Hz-16357Hz-jitter005'
networkSim
probaSpikeVSinputPhase
plotV

Generate and plot data:
statsSIvsInput2noise
If data has already been generated:
folder='...'; (set folder path)
nameSuffix='SIvsInput2-jitter005';
plotSIvsInput2; 

Figure 9:
defaultParams
steps=100000;
oneCell=1;
nameSuffix='1cell-40Hz-16357Hz'
networkSim
plotV
probaSpikeVSinputPhase

Generate and plot data:
statsSetting=4;
statsSIvsInput2 (slow)
If data has already been generated:
folder='...'; (set folder path)
nameSuffix='SIvsInput2-oneCell';
plotSIvsInput2;

Figure 10:
defaultParamsAbstract
nameSuffix='abstract-40Hz-16357Hz';
abstract
plotAbstract
probaSpikeVSinputPhaseSimple
statsSIvsInput2abstract

Figure 11: -

Figure 12:
Generate and plot data:
statsSetting=1;
statsSIvsInput2 (slow) (If this was executed for Fig. 6, we can skip)
statsSetting=2;
statsSIvsInput2 (slow)
statsSetting=3; 
statsSIvsInput2 (slow)
plotSIvsInput2multiple
If data has already been generated:
folder='...'; (set folder path)
plotSIvsInput2multiple

Generate and plot data:
statsSetting=1;
statsSIvsInput1 (slow)
statsSetting=2;
statsSIvsInput1 (slow)
statsSetting=3;
statsSIvsInput1 (slow)
plotSIvsInput1multiple

If data has already been generated:
folder='...'; (set folder path)
plotSIvsInput1multiple

Figure 13:
Generate and plot data:
statsSIvsInput1fastSI (slow)

If data has already been generated:
folder='...'; (set folder path)
nameSuffix='SIvsInput1fastSI-gammaToSI10';
plotSIvsInput1multiple

Figure 14:
defaultParams
realIB=1;
gammaJitter=0.025;
steps=100000;
nameSuffix='3cells-40Hz-jitter0025'
networkSim
plotIBibiHist
phaseHistSIfromIB

Figure 15:
Generate and plot data:
freqRatioGammaIB (slow)
If data has already been generated:
plotFreqRatioVSinput1

defaultParams
realIB=1;
gammaFreq=42.5;
nameSuffix='3cells-425Hz-dt005'
largeDt=0.05;
steps=100000;
networkSim
plotVperiodic

Figure 16:
defaultParams
realIB=1;
gammaFreq=51;
gammaJitter=0.05;
nameSuffix='3cells-51Hz-jitter005';
steps=100000;
networkSim
plotTRC
gammaFreq=62;
moreApicalH=1;
nameSuffix='3cells-62Hz-jitter005-moreApicalH';
networkSim
plotTRC (produces Figures 20 and 21 as well)

Figure 17:
defaultParams
realIB=1;
gammaFreq=62.1;
moreApicalH=1;
nameSuffix='3cells-621Hz-moreApicalH';
steps=100000;
thinISI=1;
networkSim
plotIBibiHist
phaseHistIBfromGamma
largeDt=0.05;
nameSuffix='3cells-621Hz-moreApicalH-dt005';
networkSim
numGammaPeriods=7;
plotVperiodic

Figure 18:
tausIB

Figure 19:
defaultParams
steps=100000;
realIB=1;
gammaFreq=62;
gammaJitter=0.05;
moreApicalH=1;
nameSuffix='3cells-62Hz-jitter005-moreApicalH'
networkSim
plotMcurrSpike
plotHcurrSpike
plotIBsynSpike
plotSItoIBsynSpike

Figures 20 & 21: See Fig. 16

Figure 22: -

Figure 23: -

Figure 24:
defaultParams;
multiplex=1;
gammaFreq=70;
beta1Freq=22;
gammaJitter=0.1;
networkSim;
nameSuffix='70Hz-22Hz-gJitter01'
plotVmultiplex

Figure 25:
defaultParamsIF
nameSuffix='IF-40Hz-16357Hz'
leakyIF
plotIF
probaSpikeVSinputPhaseSimple
statsSIvsInput2IF
