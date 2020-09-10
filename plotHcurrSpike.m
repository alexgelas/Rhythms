calcSpikes;

amps=100;
stepsPlot=size(fullMAR,2);

plotStart=-30; % in ms
plotEnd=100;

xaxis=(plotStart:dt:plotEnd);

numPlotSteps=length(xaxis);

numBursts=length(burstTimes);

colorCode=false;

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
    plot(xaxis,fullMAR(IBapical(1,1),startTime+1:startTime+numPlotSteps),'color',tempColor);
end
hold off

ax=gca;
ax.FontSize=20;
ax.FontWeight='bold';
ax.Title.String='Apical dendrite h-current';
ax.XLabel.String='Time from burst initiation (ms)';
ax.YLabel.String='Gating variable value';

if nameSuffix
    filepath=strcat('hCurrSpike-apical-',nameSuffix);
else
    filepath='hCurrSpike-apical';
end
saveFig(folder,filepath,h)

h=figure(42);
clf
hold on
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
    plot(xaxis,fullMAR(IBbasal(1,1),startTime+1:startTime+numPlotSteps),'color',tempColor);
end
hold off

ax=gca;
ax.FontSize=20;
ax.FontWeight='bold';
ax.Title.String='Basal dendrite h-current';
ax.XLabel.String='Time from burst initiation (ms)';
ax.YLabel.String='Gating variable value';

fullFilepath=strcat(folder,'/hCurrSpike-basal-',nameSuffix);
if nameSuffix
    filepath=strcat('hCurrSpike-basal-',nameSuffix);
else
    filepath='hCurrSpike-basal';
end
saveFig(folder,filepath,h)
