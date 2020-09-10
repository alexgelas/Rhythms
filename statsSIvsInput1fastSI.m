defaultParams;

gGammaToSI=10;

nameSuffix='SIvsInput1fastSI-gammaToSI10';

beta1Freq=16.357;
filepath=strcat(folder,'/',nameSuffix,'.mat');

input1freqs=25:1:60;

numFreqs=length(input1freqs);
SIfreqs1=zeros(1,numFreqs);

steps=100000;

h=figure(1);
clf;

for jj=1:numFreqs
    gammaFreq=input1freqs(jj)
    networkSim;
    oldDt=largeDt*saveStep;
    newDt=oldDt;
    spikes=findSpikes(fullV,oldDt,newDt);
    numLTSspikes=sum(spikes(LTS,:));
    SIfreqs1(jj)=numLTSspikes/(steps*largeDt/1000); % count spikes
    
    plot(input1freqs(1:jj),SIfreqs1(1:jj),'LineWidth',3);

    drawnow;
end

save(filepath,'input1freqs','SIfreqs1')
plotSIvsInput1;
