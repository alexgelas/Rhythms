defaultParamsAbstract;

nameSuffix='abstractVSinput2-40Hz';

filepath=strcat(folder,'/',nameSuffix);

input2freqs=12:0.2:24;

numFreqs=length(input2freqs);
SIfreqs=zeros(1,numFreqs);

totalTime=10000;
for jj=1:numFreqs
    f2=input2freqs(jj)
    abstract;
    
    numSpikes=length(spikeTimes);
    
    SIfreqs(jj)=numSpikes/totalTime*1000;
    if mod(jj,50)==0
        h2=figure(1);
        clf
        hold on
        plot(input2freqs(1:jj),SIfreqs(1:jj),'LineWidth',3);
        plot([input2freqs(1) input2freqs(end)],[input2freqs(1) input2freqs(end)],'LineWidth',1.5,'Color','red');
        hold off
        drawnow
    end
end

save(filepath,'input2freqs','SIfreqs')

plotSIvsInput2;
