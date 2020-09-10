stepsPlot=size(fullV,2);

xaxis=(1:stepsPlot)*largeDt;

xMin=0;
xMax=500;

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
    plot(xaxis,fullV(cell,:)+(numTraces-j)*ySeparation,'Color','blue','LineWidth',2,'LineStyle','-')
end

yMax=(numTraces-1)*ySeparation+100+(realRS && displayInputVgamma)*70+oneCell*60;

inputHeight=100;
yMin=-100;

color1='\color[rgb]{1.00,0.00,0.00}';
color2='\color[rgb]{0.00,1.00,0.00}';
color0='\color[rgb]{0.00,0.00,0.00}';

inputColor=[1 0 0];
inputBetaColor=[0 1 0];

yyaxis left

ax.YAxis(2).Color='black';
ax.XAxis.FontSize=20;
ax.YAxis(2).TickLength=[0 0];

yyaxis right

if numTraces==1
    ax.YTick=[-10 75 135];
    ax.YTickLabel=[[color0 'SI     '];[color2 'input-2'];[color1 'input-1']];
elseif numTraces==2
    ax.YTick=[-10 (numTraces-1)*ySeparation-200 (numTraces-1)*ySeparation-140 (numTraces-1)*ySeparation-10];
    ax.YTickLabel=[[color0 'SI     '];[color2 'input-2'];[color1 'input-1'];[color0 'FS     ']];
elseif numTraces==3
    set(gca,'YTick',[-10 ySeparation-10 (numTraces-1)*ySeparation-95-inputHeight/2 2*ySeparation-10])
    set(gca,'YTickLabel',[[color0 'IB   '];[color0 'SI   '];[color1 'input'];[color0 'FS   ']])
elseif numTraces==4 && displayInputVgamma
    ax.YTick=[-10 ySeparation-10 2*ySeparation-10 3*ySeparation-10 4*ySeparation-95-inputHeight/2+90];
    ax.YTickLabel=[[color0 'IB   '];[color0 'SI   '];[color0 'FS   '];[color0 'RS   '];[color1 'input']];
elseif numTraces==4 && ~displayInputVgamma
    ax.YTick=[-10 ySeparation-10 2*ySeparation-10 3*ySeparation-10];
    set(gca,'YTickLabel',[[color0 'IB   '];[color0 'SI   '];[color0 'FS   '];[color0 'RS   ']])
elseif numTraces==7
    ax.YTick=-10:ySeparation:6*ySeparation-10;
    ax.YTickLabel=[[color0 'IB axon  '];[color0 'IB soma  '];[color0 'IB basal '];[color0 'IB apical'];[color0 'SI       '];[color0 'FS       '];[color0 'RS       ']];
    if displayInputVgamma>0
        ax.YTick=[ax.YTick 7*ySeparation-60];
        ax.YTickLabel=[ax.YTickLabel;[color1 'input    ']];
    end
end

yyaxis left
if displayInputVgamma>0
    tempOffset=70+(numTraces-(~oneCell)+1.5*(realRS>0))*ySeparation-200;
    plot(xaxis,fullInputV(displayInputVgamma,:)*0.5+tempOffset,'lineWidth',2,'Color',inputColor);
end

if displayInputVbeta>0
    plot(xaxis,fullInputV(displayInputVbeta,:)*0.5+70+(numTraces-(~oneCell))*ySeparation-260,'lineWidth',2,'Color',inputBetaColor,'LineStyle','-');
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

ax.XLim=[xMin xMax];
ax.YAxis(1).Limits=[yMin yMax];
ax.YAxis(2).Limits=[yMin yMax];

h.PaperUnits = 'inches';

if plotAll
    ax.XLim=[0 1000];
    h.PaperPosition = [0 0 18 6];
elseif oneCell
    h.PaperPosition = [0 0 12 2.5];
else
    h.PaperPosition = [0 0 12 4.2];
end

set(h,'PaperSize',[h.PaperPosition(3), h.PaperPosition(4)]);

if nameSuffix
    fullPath=strcat(folder,'/membraneV-',nameSuffix);
else
    fullPath=strcat(folder,'/membraneV');
end

saveas(h,fullPath,'fig')
%saveas(h,fullPath,'png')
print(h,fullPath,'-dpdf','-r0')

if ~plotAll % A longer plot (from 0 to 1000 ms)
    ax.XLim=[0 1000];
    h.PaperUnits = 'inches';
    if oneCell
        h.PaperPosition = [0 0 15 2];
    else
        h.PaperPosition = [0 0 15 3];
    end
    if nameSuffix
        fullPath=strcat(folder,'/membraneV-',nameSuffix,'-long');
    else
        fullPath=strcat(folder,'/membraneV','-long');
    end
    
    saveas(h,fullPath,'fig')
    %saveas(h,fullPath,'png')
    set(h,'PaperSize',[h.PaperPosition(3), h.PaperPosition(4)]);
    print(h,fullPath,'-dpdf','-r0')
end