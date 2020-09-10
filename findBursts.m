function bursts=findBursts(spikes,dt)

% Takes a binary time series that represents the existence of spikes with
% time step dt and gives the time series that represents the existence
% (beginning) of bursts, with a positive number in the corresponding bin of
% time. The number itself is the number of spikes for that burst.
% A series of spikes is considered a single burst
% if the interval between two subsequent spikes is less than a threshold
% value (burstThreshold).

burstThreshold=7; % in ms

numRows=size(spikes,1); % Functionality for multiple cells simultaneously
len=size(spikes,2);

separationSteps=floor(burstThreshold/dt);

burstsTemp=spikes;

for i=1:separationSteps-1
    shiftedSpikes=[false(numRows,i) spikes(:,1:len-i)];
    burstsTemp=burstsTemp & (~shiftedSpikes); % Not a new burst if there was a spike recently.
end
bursts=zeros(numRows,len);

for r=1:numRows % For the rest we work with each cell separately
    burstTimesRow=find(burstsTemp(r,:));
    for i=1:length(burstTimesRow)-1
        bursts(r,burstTimesRow(i))=sum(spikes(r,burstTimesRow(i):burstTimesRow(i+1)-1)); % Add all spikes from this burst until before the next one, in order to count how many spikes in this burst.
    end
    bursts(r,burstTimesRow(end))=sum(spikes(r,burstTimesRow(end):end));
end