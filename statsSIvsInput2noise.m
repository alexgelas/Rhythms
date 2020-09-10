defaultParams;

nameSuffix='SIvsInput2-jitter005';

filepath=strcat(folder,'/',nameSuffix);

gammaJitter=0.05;
betaJitter=0.05;

input2freqs=12:0.2:24;

numFreqs=length(input2freqs);
SIfreqs=zeros(1,numFreqs);

steps=100000;
for jj=1:numFreqs
    beta1Freq=input2freqs(jj)
    networkSim;
    oldDt=largeDt*saveStep;
    newDt=oldDt;
    spikes=findSpikes(fullV,oldDt,newDt);
    numLTSspikes=sum(spikes(LTS,:));
    SIfreqs(jj)=numLTSspikes/(steps*largeDt/1000); % count spikes
    if mod(jj,3)==0
        plotV;
        h2=figure(1);
        clf
        plot(input2freqs(1:jj),SIfreqs(1:jj),'LineWidth',3);
        hold on
        plot([input2freqs(1) input2freqs(end)],[input2freqs(1) input2freqs(end)],'LineWidth',1.5,'Color','red');
        hold off
        drawnow
    end
end

save(filepath,'input2freqs','SIfreqs')
plotSIvsInput2;
