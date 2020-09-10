function timeFromLastB=timeFromLastB(spikeTimes,refTimes,skipInitial)

% For each entry in spikeTimes, find the time from the last spike in
% refTimes.

% Contrasted to timeFromLast, here the input is spike times, instead of
% voltage traces.

numSpikes=length(spikeTimes);

lastRef=zeros(1,numSpikes);
timeFromLastB=zeros(1,numSpikes);

for j=skipInitial+1:numSpikes
    lastRef(j)=refTimes(find(refTimes<spikeTimes(j),1,'last'));
    timeFromLastB(j)=spikeTimes(j)-lastRef(j);
end