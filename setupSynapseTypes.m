% Produces a list of synapse types, specifying the reversal potential and
% rise/decay constants. This is a "database" that is used for creating
% the actual synapses in our network.

% 1: RS to RS
% 2: RS to FS
% 3: RS to LTS
% 4: FS to RS
% 5: FS self-synapse
% 6: FS to LTS
% 7: LTS to RS
% 8: LTS to FS
% 9: LTS self-synapse


% 12: LTS to IB
% 13: IB to FS
% 14: IB to LTS

% 19: IB axon to IB basal

% 51: Input to RS

numSynapseTypes=51; % Not all numbers used

rsRsRise=0.125;% This is half of the value specified in the model description (because of the difference in the formula used in the code, see file synapse.m)
rsRsDecay=1;
rsBasketRise=0.125;% This is half of the value specified in the model.
rsBasketDecay=1;
rsLtsRise=1.25;% This is half of the value specified in the model.
rsLtsDecay=1;

basketRsRise=0.25;
basketRsDecay=5;
basketBasketRise=0.25;
basketBasketDecay=5;
basketLtsRise=0.25;
basketLtsDecay=6;

ltsRsRise=0.25;
ltsRsDecay=20;
ltsLtsRise=0.25;
ltsLtsDecay=20;
ltsIbApicalRise=0.25;
ltsIbApicalDecay=20;

ibAxonBasketRise=0.125;
ibAxonBasketDecay=1;
ibAxonLtsRise=1.25;
ibAxonLtsDecay=50;
ibAxonIbBasalRise=0.25;
ibAxonIbBasalDecay=100;

typeVrev=zeros(numSynapseTypes,1);
typeRise=zeros(numSynapseTypes,1);
typeDecay=zeros(numSynapseTypes,1);

% 1: RS to RS
synType=1; % the variable is only used temporarily

typeVrev(synType)=0;
typeRise(synType)=rsRsRise;
typeDecay(synType)=rsRsDecay;

% 2: RS to FS
synType=2;
typeVrev(synType)=0;
typeRise(synType)=rsBasketRise;
typeDecay(synType)=rsBasketDecay;

% 3: RS to LTS
synType=3;
typeVrev(synType)=0;
typeRise(synType)=rsLtsRise;
typeDecay(synType)=rsLtsDecay;

% 4: FS to RS
synType=4;
typeVrev(synType)=-80;
typeRise(synType)=basketRsRise;
typeDecay(synType)=basketRsDecay;

% 5: FS self-synapse
synType=5;
typeVrev(synType)=-75;
typeRise(synType)=basketBasketRise;
typeDecay(synType)=basketBasketDecay;

% 6: FS to LTS
synType=6;
typeVrev(synType)=-80;
typeRise(synType)=basketLtsRise;
typeDecay(synType)=basketLtsDecay;

% 7: LTS to RS
synType=7;
typeVrev(synType)=-80;
typeRise(synType)=ltsRsRise;
typeDecay(synType)=ltsRsDecay;

% 8: LTS to FS
synType=8;
typeVrev(synType)=-80;
typeRise(synType)=ltsRsRise; % use same rise and decay constants as for LTS->RS cell
typeDecay(synType)=ltsRsDecay;

% 9: LTS self-synapse
synType=9;
typeVrev(synType)=-80;
typeRise(synType)=ltsLtsRise;
typeDecay(synType)=ltsLtsDecay;





% 12: LTS to IB
synType=12;
typeVrev(synType)=-80;
typeRise(synType)=ltsIbApicalRise;
typeDecay(synType)=ltsIbApicalDecay;

% 13: IB to FS
synType=13;
typeVrev(synType)=0;
typeRise(synType)=ibAxonBasketRise;
typeDecay(synType)=ibAxonBasketDecay;

% 14: IB to LTS
synType=14;
typeVrev(synType)=0;
typeRise(synType)=ibAxonLtsRise;
typeDecay(synType)=ibAxonLtsDecay;



% 19: IB axon to IB basal
synType=19;
typeVrev(synType)=0;
typeRise(synType)=ibAxonIbBasalRise;
typeDecay(synType)=ibAxonIbBasalDecay;




% 51: Input - Excitatory rhythmic
synType=51;
typeVrev(synType)=0;
typeRise(synType)=0.1;
typeDecay(synType)=0.5;
