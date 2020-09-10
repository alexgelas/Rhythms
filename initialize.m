setupNetwork;
setupInput;
setupCellTypes;
setupSynapseTypes;
[exc, VRest, VNaF, VKDR, VAR, VKM, VCaH, V0, gLeak, gNaF,...
    gKDR, gAR, gKM, gCaH, gRan, alphaMARFactor, betaMARFactor,...
    alphaCaHFactor, betaCaHFactor, alphaKMFactor, betaKMFactor,...
    Itonic, noiseIntensity, capacitance]=...
    setupCells(cellType,typeExc, typeVRest,typeVNaF,typeVKDR,...
    typeVAR,typeVKM,typeVCaH,typeV0,typeGLeak,typeGNaF,typeGKDR,...
    typeGAR,typeGKM,typeGCaH,typeGRan,typeAlphaMARFactor,...
    typeBetaMARFactor,typeAlphaKMFactor,typeBetaKMFactor,...
    typeAlphaCaHFactor,typeBetaCaHFactor,typeItonic,...
    typeNoiseIntensity,typeCapacitance);

[Vrev, rise, decay]=setupSynapses(synapseType,...
    typeVrev,typeRise,typeDecay);
[inputVrev, inputSynRise, inputSynDecay]=...
    setupSynapses(inputSynapseType,typeVrev,typeRise,typeDecay);

s=zeros(numSynapses,1); % The dynamic variables of the synapses
synToPost=zeros(numCells,numSynapses); % Indicator matrix of post-synaptic cells of the synapses. A(i,j)=1 if the post-synaptic cell of the j-th synapse is the i-th cell.
    
gapToPost=zeros(numCells,numGapJunctions); % Indicator matrix of target compartments of electrical connections. A(i,j)=1 if the target compartment of the j-th connection is the i-th cell.

sInput=zeros(numInputSynapses,1);
inputToPost=zeros(numCells,numInputSynapses);

if numSynapses>0
    for j=1:numSynapses
        synToPost(postSyn(j),j)=1;
    end
end
    
if numGapJunctions>0
    for j=1:numGapJunctions
        gapToPost(postGap(j),j)=1;
    end
end

if numInputSynapses>0
    for j=1:numInputSynapses
        inputToPost(inputTarget(j),j)=1;
    end
end

movedSlow=zeros(1,steps);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Initial State

V=(-100+10*rand(numCells,1)).*ones(numCells,1);

h=0.05*abs(rand(numCells,1)); % h is the usual Na deactivating 'gate'
m=0.05*abs(rand(numCells,1)); % m is the usual K activating 'gate'
mAR=0.0+0.001*abs(rand(numCells,1)); % mAR is h-current
mKM=0.0*abs(rand(numCells,1)); % mKM is M-current
mCaH=0.01*abs(rand(numCells,1)); % mCaH is high-threshold calcium current

if colNumRS>0
    for i=1:colNumRS
        cell=RS(i);
        mAR(cell)=0.035+0.025*rand(1);
        V(cell)=-70+10*rand(1);
    end
end
if colNumFS>0
    for i=1:colNumFS
        cell=FS(i);
        V(cell)=-110+10*rand(1);
    end
end
if colNumLTS>0
    for i=1:colNumLTS
        cell=LTS(i);
        mAR(cell)=0.02+0.04*rand(1);
    end
end

I=zeros(numCells,1);        % Periodic input current
Isyn=zeros(numCells,1);     % Synaptic currents
Igap=zeros(numCells,1);     % Gap junction currents, including intercompartmental currents within a cell

newV=zeros(numCells,1);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Initialize inputV

numInputs=11; % Most unused
inputV=-70*ones(numInputs,1);

nextInp6=dt+1000/gammaFreq*rand();
nextInp7=dt+1000/gammaFreq*rand();
nextInp8=dt+1000/gammaFreq*rand();

nextInp9=dt+1000/beta1Freq*rand();
if multiplex
    nextInp9=5; % Start early, otherwise the delayed versions start too late.
end
nextInp9b=nextInp9+1; % Irrelevant, as long as it is >nextInp9
nextInp9c=nextInp9+1; % Same

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Record full history (for analyzing later)

fullV=zeros(numCells,steps/saveStep);
% fullH=zeros(numCells,steps/saveStep);
% fullM=zeros(numCells,steps/saveStep);
fullMAR=zeros(numCells,steps/saveStep);
fullMKM=zeros(numCells,steps/saveStep);
% fullMCaH=zeros(numCells,steps/saveStep);
% fullI=zeros(numCells,steps/saveStep);
% fullJ=zeros(numCells,steps/saveStep);
% fullIsyn=zeros(numCells,steps/saveStep);
% fullIgap=zeros(numCells,steps/saveStep);
fullInputV=zeros(numInputs,steps/saveStep);
%fullSInput=zeros(numInputSynapses,steps/saveStep);

%VsumRS=zeros(steps,1);
%VsumFS=zeros(steps,1);
%Isum=zeros(steps,1);

% fullSynCurrents=zeros(numSynapses,steps/saveStep);

fullSynapses=zeros(numSynapses,steps/saveStep);