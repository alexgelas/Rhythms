calcSpikes;

amps=100;
stepsPlot=size(fullMAR,2);

plotStart=-30; % in ms
plotEnd=100;

xaxis=(plotStart:dt:plotEnd);

numPlotSteps=length(xaxis);

numBursts=length(burstTimes);

colorCode=true;

synIndex=find(preSyn==IBaxon & postSyn==IBbasal);

h=figure(41);
clf
hold on
skip=5;
for bb=skip+1:numBursts-3
    if colorCode
        switch burstsAxon(round(burstTimes(bb)/dt+0.01))
            case 2
                tempColor='blue';
            case 3
                tempColor='red';
            case 4
                tempColor='black';
            otherwise
                tempColor='green';
        end
    else
        tempColor='black';
    end
    startTime=floor((burstTimes(bb)+plotStart)/dt);
    plot(xaxis,fullSynapses(synIndex,startTime+1:startTime+numPlotSteps),'color',tempColor);
end
hold off

ax=gca;
ax.FontSize=20;
ax.FontWeight='bold';
ax.Title.String='IB axon -> basal dendrite synapse';
ax.XLabel.String='Time from burst initiation (ms)';
ax.YLabel.String='Synapse variable value';

if nameSuffix
    filepath=strcat('IBsyn-',nameSuffix);
else
    filepath=strcat('IBsyn');
end
saveFig(folder,filepath,h)