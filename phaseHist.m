function [freqs,tfl]=phaseHist(V,refV,dt,histMax)

refSpikes=findSpikes(refV,dt,dt,0);
refPos=find(refSpikes);

spikes=findSpikes(V,dt,dt,0);

bursts=findBursts(spikes,dt);

tempLength=size(bursts,2);

burstTimes=sort(mod(find(bursts'),tempLength));

spikeTimes1=burstTimes';
spikeTimes2=refPos;

numSpikes1=size(spikeTimes1,2);

last2wrt1=zeros(1,numSpikes1);
timeFromLast2wrt1=zeros(1,numSpikes1);

skipInitial=5;

for j=skipInitial+1:numSpikes1
    last2wrt1(j)=spikeTimes2(find(spikeTimes2<spikeTimes1(j),1,'last'));
    timeFromLast2wrt1(j)=spikeTimes1(j)-last2wrt1(j);
end

temp1=skipInitial+1;
temp2=numSpikes1;

freqs=hist(dt*timeFromLast2wrt1(temp1:temp2),0.5:1:histMax);

if nargout>1
    tfl{1}=timeFromLast2wrt1;
end