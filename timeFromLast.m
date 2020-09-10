function timeFromLast=timeFromLast(V,refV,skipInitial,dt)

% For each spike in V, find the time from the last spike in refV. To
% exclude transients, skip the first "skipInitial" spikes in V.

refSpikes=findSpikes(refV,dt,dt,0);
refBursts=findBursts(refSpikes,dt);
refPos=find(refBursts);

spikes=findSpikes(V,dt,dt,0);
bursts=findBursts(spikes,dt);

tempLength=size(bursts,2);
burstTimes=sort(mod(find(bursts'),tempLength));

spikeTimes1=dt*burstTimes';
spikeTimes2=dt*refPos;

timeFromLast=timeFromLastB(spikeTimes1,spikeTimes2,skipInitial);