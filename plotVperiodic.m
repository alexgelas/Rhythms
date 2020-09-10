calcSpikes;

period=numGammaPeriods*1000/gammaFreq;
plotStart=0; % in ms
plotEnd=period;

startingIndices=floor((1000:period:steps*largeDt-period)/largeDt);

numPeriods=length(startingIndices);

xaxis=(plotStart:largeDt:plotEnd);

numPlotSteps=length(xaxis);

xMin=500;
if ~realIB;
    ySeparation=280;
elseif realIB && ~realRS;
    ySeparation=250;
else
    ySeparation=180;
end

plotCells=[FS LTS];

if realIB
    if plotAll
        plotCells=[plotCells IBapical IBbasal IBsoma IBaxon];
    else
        plotCells=[plotCells IBaxon];
    end
end
if realRS
    plotCells=[RS plotCells];
end

numTraces=length(plotCells);

figNum=6;
h=figure(figNum);
clf
ax=gca;
ax.XLabel.String='Time (ms)';
ax.FontWeight='bold';
ax.FontSize=20;
hold on
for j=1:numTraces
    cell=plotCells(j);
    for bb=1:numPeriods
        start=startingIndices(bb);
        plot(xaxis,fullV(cell,start:start+numPlotSteps-1)+(numTraces-j)*ySeparation,'Color','blue','LineWidth',0.2);
    end
end

yMax=(numTraces-1)*ySeparation+100+(realRS && displayInputGamma)*70+oneCell*60;

inputHeight=100;
yMin=-100;

yyaxis left

ax.YAxis(2).Color='black';
ax.XAxis.FontSize=20;
ax.YAxis(2).TickLength=[0 0];

yyaxis right

if numTraces==1
    set(gca,'YTick',[-10 75 135])
    set(gca,'YTickLabel',[['\color{black}  ' '  cell '];['\color{green}  ' 'input-2'];['\color{red}    ' 'input-1']],'FontWeight','b','FontSize',14)
elseif numTraces==2
    set(gca,'YTick',[-10 (numTraces-1)*ySeparation-200 (numTraces-1)*ySeparation-140 (numTraces-1)*ySeparation-10])
    set(gca,'YTickLabel',[['\color{black}' '   SI  '];['\color{green}' 'input-2'];['\color{red}  ' 'input-1'];['\color{black}' '   FS  ']],'FontWeight','b','FontSize',14)
elseif numTraces==3
    set(gca,'YTick',[-10 ySeparation-10 (numTraces-1)*ySeparation-95-inputHeight/2 2*ySeparation-10])
    set(gca,'YTickLabel',[['\color{black}' '  IB '];['\color{black}' '  SI '];['\color{red}  ' 'input'];['\color{black}' '  FS ']],'FontWeight','b','FontSize',14)
elseif numTraces==4 && displayInputGamma
    set(gca,'YTick',[-10 ySeparation-10 2*ySeparation-10 3*ySeparation-10 4*ySeparation-95-inputHeight/2])
    set(gca,'YTickLabel',[['\color{black}' '  IB '];['\color{black}' '  SI '];['\color{black}' '  FS '];['\color{black}' '  RS '];['\color{red}  ' 'input']],'FontWeight','b','FontSize',14)
elseif numTraces==4 && ~displayInputGamma
    set(gca,'YTick',[-10 ySeparation-10 2*ySeparation-10 3*ySeparation-10])
    set(gca,'YTickLabel',[['\color{black}' '  IB '];['\color{black}' '  SI '];['\color{black}' '  FS '];['\color{black}' '  RS ']],'FontWeight','b','FontSize',14)
elseif numTraces==7
    set(gca,'YTick',[-10:ySeparation:6*ySeparation-10])
    set(gca,'YTickLabel',[['\color{black}' ' IB axon '];['\color{black}' ' IB soma '];['\color{black}' ' IB basal'];['\color{black}' 'IB apical'];['\color{black}' '    SI   '];['\color{black}' '    FS   '];['\color{black}' '    RS   ']],'FontWeight','b','FontSize',14)
end

yyaxis left
y1=[];
y1Label=[];
if showUnits
    for tt=1:numTraces
        y1=[y1 (tt-1)*ySeparation-50 (tt-1)*ySeparation (tt-1)*ySeparation+50];
        if plotAll
            y1Label=[y1Label; '\fontsize{10} -50'; '\fontsize{10}   0';'\fontsize{10}  50'];
        else
            y1Label=[y1Label; '\fontsize{14} -50'; '\fontsize{14}   0';'\fontsize{14}  50'];
        end
    end
    ax.YLabel.String='Membrane potential (mV)';
    if oneCell
        ax.YLabel.String='\fontsize{18} Membrane\newline potential (mV)';
    end
end
ax.YTick=y1;
ax.YTickLabel=y1Label;

inputColor=[1 0 0];
inputBetaColor=[0 1 0];

yyaxis left
if displayInputVgamma>0
    for bb=1:numPeriods
        start=startingIndices(bb);
        plot(xaxis,fullInputV(displayInputVgamma,start:start+numPlotSteps-1)*0.5+70+(numTraces-(~oneCell)+1.5*(realRS>0))*ySeparation-200,'LineWidth',2,'Color',inputColor,'LineStyle','-','Marker','None');
    end
end

if displayInputVbeta>0
    for bb=1:numPeriods
        start=startingIndices(bb);
        plot(xaxis,fullInputV(displayInputVbeta,start:start+numPlotSteps-1)*0.5+70+(numTraces-(~oneCell))*ySeparation-260,'lineWidth',2,'Color',inputBetaColor);
    end
end

h.PaperUnits = 'inches';

if plotAll
    h.PaperPosition = [0 0 18 6];
elseif oneCell
    h.PaperPosition = [0 0 12 2.5];
else
    h.PaperPosition = [0 0 12 4];
end

set(h,'PaperSize',[h.PaperPosition(3), h.PaperPosition(4)]);

if nameSuffix
    fullPath=strcat(folder,'/membraneV-periodic-',nameSuffix);
else
    fullPath=strcat(folder,'/membraneV-periodic');
end

saveas(h,fullPath,'fig')
%saveas(h,fullPath,'png')
print(h,fullPath,'-dpdf','-r0')