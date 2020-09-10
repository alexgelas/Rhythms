defaultParams;

if statsSetting==1 % Regular
    nameSuffix='SIvsInput1'; % 16.357 Hz
    % beta1Freq=16.357;
    % gFStoSI=8;
elseif statsSetting==2
    nameSuffix='SIvsInput1-18357Hz';
    beta1Freq=18.357;
    % gFStoSI=8;
elseif statsSetting==3
    nameSuffix='SIvsInput1-c135'; % Weak FS->SI (ignore name)
    % beta1Freq=16.357;
    gFStoSI=5;
else
    Error('statsSetting not valid')
end

filepath=strcat(folder,'/',nameSuffix,'.mat');

input1freqs=30:1:100;

numFreqs=length(input1freqs);
SIfreqs1=zeros(1,numFreqs);

steps=100000;
for jj=1:numFreqs
    gammaFreq=input1freqs(jj)
    networkSim;
    oldDt=largeDt*saveStep;
    newDt=oldDt;
    spikes=findSpikes(fullV,oldDt,newDt);
    numLTSspikes=sum(spikes(LTS,:));
    SIfreqs1(jj)=numLTSspikes/(steps*largeDt/1000); % count spikes
    if mod(jj,5)==0
        h=figure(1);
        clf;
        plot(input1freqs(1:jj),SIfreqs1(1:jj),'LineWidth',3);
        drawnow;
    end
    
end

save(filepath,'input1freqs','SIfreqs1')
plotSIvsInput1;
