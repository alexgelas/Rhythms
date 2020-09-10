function timeToNextB=timeToNextB(spikeTimes,refTimes,skipInitial)

% For each entry in spikeTimes, find the time until the immediately next spike in
% refTimes.

% Contrasted to timeToNext, here the input is spike times, instead of
% voltage traces.

numSpikes=length(spikeTimes);

timeToNextB=zeros(1,numSpikes);

for j=skipInitial+1:numSpikes
    nextRef=refTimes(find(refTimes>=spikeTimes(j),1,'first'));
    if isempty(nextRef) % No more reference times, implies end of simulation.
        timeToNextB(j:end)=NaN;
        break
    else
        timeToNextB(j)=nextRef-spikeTimes(j);
    end
end