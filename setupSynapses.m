function [Vrev, rise, decay]=setupSynapses(synapseType,typeVrev,typeRise,typeDecay)

% Produces a list of synapses in the network, specifying the strength, the reversal potential and the rise
% and decay constants. Looks up the characteristics in the database (created
% by setupSynapseTypes.m), according to the synapse type in synapseType
% (created by setupNetwork.m). Conductance, pre- and post-synaptic cells
% are not specified here.

numSynapses=length(synapseType);

Vrev=zeros(numSynapses,1); % Reversal potential
rise=ones(numSynapses,1); % Rise time constant
decay=ones(numSynapses,1); % Decay time constant

for i=1:numSynapses
    Vrev(i)=typeVrev(synapseType(i));
    rise(i)=typeRise(synapseType(i));
    decay(i)=typeDecay(synapseType(i));
end