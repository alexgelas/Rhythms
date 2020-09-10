function freqs=absTimeHist(V,dt)

spikes=findSpikes(V,dt,dt,0);

bursts=findBursts(spikes,dt);

tempLength=size(bursts,2);

burstTimes=sort(mod(find(bursts'),tempLength));

spikeTimes1=burstTimes';

histMax=size(V,2)*dt;
hist(spikeTimes1*dt,0.5:10:histMax)
freqs=hist(spikeTimes1*dt,0.5:10:histMax);