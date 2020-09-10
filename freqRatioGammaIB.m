defaultParams;
realIB=1;
gammaJitter=0;
nameSuffix='freqRatio-noNoise';

filepath=strcat(folder,'/',nameSuffix,'.mat');

input1freqs=25:0.5:80;

numFreqs=length(input1freqs);
IBfreqs=zeros(1,numFreqs);
freqRatios=zeros(1,numFreqs);

steps=100000;
for jj=1:numFreqs
    gammaFreq=input1freqs(jj)
    networkSim;
    oldDt=largeDt*saveStep;
    newDt=oldDt;
    spikes=findSpikes(fullV(IBaxon,:),oldDt,newDt);
    ibAxonBursts=find(findBursts(spikes,dt,5));
    numBursts=length(ibAxonBursts);
    IBfreqs(jj)=numBursts/(steps*largeDt/1000); % count bursts
    freqRatios(jj)=input1freqs(jj)/IBfreqs(jj);

    if mod(jj,3)==0
        plotV;
        h=figure(1); clf;
        plot(input1freqs(1:jj),freqRatios(1:jj),'LineWidth',3);
        drawnow;
    end
end

save(filepath,'IBfreqs','input1freqs')

plotFreqRatioVSinput1;