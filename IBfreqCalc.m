a=findSpikes(fullV(IBaxon,:),dt,dt);

ibAxonBursts=find(findBursts(a,dt,5));
numBursts=length(ibAxonBursts);

freqIB=numBursts/(steps*largeDt/1000);