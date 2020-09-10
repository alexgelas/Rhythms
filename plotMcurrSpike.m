calcSpikes;

stepsPlot=size(fullMAR,2);

plotStart=-30; % in ms
plotEnd=100;

xaxis=(plotStart:dt:plotEnd);

numPlotSteps=length(xaxis);

numBursts=length(burstTimes);

colorCode=true;

h=figure(51);
clf
hold on
skip=5;
for bb=skip+1:numBursts-3
    startTime=floor((burstTimes(bb)+plotStart)/dt);
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
    plot(xaxis,fullMKM(IBaxon(1,1),startTime+1:startTime+numPlotSteps),'color',tempColor);
end
hold off

ax=gca;
ax.FontSize=20;
ax.FontWeight='bold';
ax.Title.String='Axon M-current';
ax.XLabel.String='Time from burst initiation (ms)';
ax.YLabel.String='Gating variable value';

if nameSuffix
    filepath=strcat('mCurrSpike-axon-',nameSuffix);
else
    filepath='mCurrSpike-axon';
end
saveFig(folder,filepath,h)

colorCode=false;

h=figure(52);
clf
hold on
for bb=skip+1:numBursts-3
    startTime=floor((burstTimes(bb)+plotStart)/dt);
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
    plot(xaxis,fullMKM(IBapical(1,1),startTime+1:startTime+numPlotSteps),'color',tempColor);
end
hold off

ax=gca;
ax.FontSize=20;
ax.FontWeight='bold';
ax.Title.String='Apical dendrite M-current';
ax.XLabel.String='Time from burst initiation (ms)';
ax.YLabel.String='Gating variable value';

if nameSuffix
    filepath=strcat('mCurrSpike-apical-',nameSuffix);
else
    filepath='mCurrSpike-apical';
end
saveFig(folder,filepath,h)

h=figure(53);
clf
hold on
for bb=skip+1:numBursts-3
    startTime=floor((burstTimes(bb)+plotStart)/dt);
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
    plot(xaxis,fullMKM(IBbasal(1,1),startTime+1:startTime+numPlotSteps),'color',tempColor);
end
hold off

ax=gca;
ax.FontSize=20;
ax.FontWeight='bold';
ax.Title.String='Basal dendrite M-current';
ax.XLabel.String='Time from burst initiation (ms)';
ax.YLabel.String='Gating variable value';

if nameSuffix
    filepath=strcat('mCurrSpike-basal-',nameSuffix);
else
    filepath='mCurrSpike-basal';
end
saveFig(folder,filepath,h)