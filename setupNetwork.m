% Specifies network, i.e. what cells and synapses there will be.

%%%%%%%%%%%%%%%%%%
% Cell numbering %
%%%%%%%%%%%%%%%%%%

% SI cell (here LTS) is always cell 1
% FS cell is 2 when present
% IB is cells 3-6 when present (apical dendrite, basal dendrite, soma,
% axon, in this order)
% RS is number 7 when present, except in the multiplexing network
% In the multiplexing network, the SI's are 1-3, RS is 4

colNumRS=0;
colNumLTS=1;
colNumIB=0;
if oneCell
    numCells=1;
    colNumFS=0;
elseif multiplex
    numCells=4;
    colNumFS=0;
    colNumLTS=3;
    colNumRS=1;
else
    numCells=2;
    colNumFS=1;
end

if realIB
    if multiplex
        warning('Multiplex and real IB are ON simultaneously. Please fix.')
    end
    numCells=numCells+4;
    colNumIB=1;    
end
if realRS
    if multiplex
        warning('Multiplex and real RS are ON simultaneously. Please fix.')
    end
    numCells=numCells+1;
    colNumRS=1;    
end

cellType=zeros(numCells,1);
if oneCell
    cellType(1)=3;
    LTS=1;
    FS=[];
elseif multiplex
    cellType(1:colNumLTS)=3;
    cellType(colNumLTS+1)=1;
    LTS=1:colNumLTS;
    FS=[];
else
    cellType(1)=2;
    cellType(2)=3;
    FS=1;
    LTS=2;
end

if realRS
    if realIB
        cellType(7)=1;
        RS=7;
    else % unused
        cellType(3)=1;
        RS=3;
    end
elseif multiplex
    RS=colNumLTS+1;
else
    RS=[];
end

if realIB
    cellType(3)=4;
    cellType(4)=5;
    cellType(5)=6;
    cellType(6)=7;
    FS=1;
    LTS=2;
    IBapical=3;
    IBbasal=4;
    IBsoma=5;
    IBaxon=6;
else
    IBapical=zeros(1,0);
    IBbasal=zeros(1,0);
    IBsoma=zeros(1,0);
    IBaxon=zeros(1,0);
end

%%%%%%%%%%%%
% Synapses %
%%%%%%%%%%%%

tempNumSynapses=100; % an upper bound

r=zeros(tempNumSynapses,1); s=zeros(tempNumSynapses,1); t=zeros(tempNumSynapses,1); u=zeros(tempNumSynapses,1);

for i=1:length(LTS)
    [r, s, t, u]=addSynapse(r,s,t,u,LTS(i),LTS(i),9,4); % LTS self-synapse
end
if exist('gSItoSI','var')
    warning('gSItoSI is set - check')
end
if ~oneCell && ~multiplex
    [r, s, t, u]=addSynapse(r,s,t,u,FS,FS,5,20); % FS to FS
    [r, s, t, u]=addSynapse(r,s,t,u,FS,LTS,6,gFStoSI); % FS to LTS
    [r, s, t, u]=addSynapse(r,s,t,u,LTS,FS,8,4); % LTS to FS
end

if realIB==1
    [r, s, t, u]=addSynapse(r,s,t,u,LTS,IBapical,12,4); % LTS to IB
    [r, s, t, u]=addSynapse(r,s,t,u,IBaxon,FS,13,2); % IB to FS
    [r, s, t, u]=addSynapse(r,s,t,u,IBaxon,LTS,14,0.9); % IB to LTS
    [r, s, t, u]=addSynapse(r,s,t,u,IBaxon,IBbasal,19,0.4); % IB to IB
end

if realRS==1
    [r, s, t, u]=addSynapse(r,s,t,u,RS,RS,1,0.5);
    [r, s, t, u]=addSynapse(r,s,t,u,RS,FS,2,2.5);
    [r, s, t, u]=addSynapse(r,s,t,u,RS,LTS,3,gGammaToSI);
    [r, s, t, u]=addSynapse(r,s,t,u,FS,RS,4,125);
    [r, s, t, u]=addSynapse(r,s,t,u,LTS,RS,7,2.5);
end
    
if multiplex
    for i=1:colNumLTS
        [r, s, t, u]=addSynapse(r,s,t,u,LTS(i),RS,1,0.7); % LTS to RS
    end    
end

numSynapses=find(r>0,1,'last');
preSyn=r(1:numSynapses);
postSyn=s(1:numSynapses);
synapseType=t(1:numSynapses);
gSyn=u(1:numSynapses);


%%%%%%%%%%%%%%%%%%%%%%%
% Electrical coupling %
%%%%%%%%%%%%%%%%%%%%%%%

% They are called gap junctions here, but they model electrical continuity
% within a multicompartmental cell.

tempNumGapJunctions=20; % an upper bound

r=zeros(tempNumGapJunctions,1); s=zeros(tempNumGapJunctions,1); t=zeros(tempNumGapJunctions,1);

if realIB
    gApicalToSoma=0.4;
    gBasalToSoma=0.4;
    gAxonToSoma=0.3;
    
    gSomaToApical=0.2;
    gSomaToBasal=0.2;
    gSomaToAxon=0.3;
    
    [r, s, t]=addGapJunction(r,s,t,IBapical,IBsoma,gApicalToSoma); % Apical to soma
    [r, s, t]=addGapJunction(r,s,t,IBbasal,IBsoma,gBasalToSoma); % Basal to soma
    [r, s, t]=addGapJunction(r,s,t,IBaxon,IBsoma,gAxonToSoma); % Axon to soma
    [r, s, t]=addGapJunction(r,s,t,IBsoma,IBapical,gSomaToApical); % Soma to apical
    [r, s, t]=addGapJunction(r,s,t,IBsoma,IBbasal,gSomaToBasal); % Soma to bascal
    [r, s, t]=addGapJunction(r,s,t,IBsoma,IBaxon,gSomaToAxon); % Soma to axon
    
    numGapJunctions=find(r>0,1,'last');
else
    numGapJunctions=0;
end
preGap=r(1:numGapJunctions);
postGap=s(1:numGapJunctions);
gGap=t(1:numGapJunctions);

