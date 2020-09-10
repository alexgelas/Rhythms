defaultParams;

if statsSetting==1 % Regular, FS-SI, 40Hz
    nameSuffix='SIvsInput2-40Hz';
    % gammaFreq=40;
    % gFStoSI=8;
elseif statsSetting==2
    nameSuffix='SIvsInput2-45Hz';
    gammaFreq=45;
    % gFStoSI=8;
elseif statsSetting==3
    nameSuffix='SIvsInput2-40Hz-c135';
    % gammaFreq=40;    
    gFStoSI=5;
elseif statsSetting==4
    nameSuffix='SIvsInput2-oneCell';
    oneCell=1;
else
    Error('statsSetting not valid')
end

filepath=strcat(folder,'/',nameSuffix);

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
