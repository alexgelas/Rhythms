stepsPlot=size(fullV,2);

xaxis=(1:stepsPlot)*largeDt;

xMin=0;
xMax=500;

ySeparation=280;

plotCells=[LTS RS];

numTraces=length(plotCells);

figNum=6;
h=figure(figNum);
clf
ax=gca;
ax.XLabel.String='Time (ms)';
ax.FontWeight='bold';
ax.FontSize=20;
hold on
plotOffsets=zeros(numTraces,1);
plotOffsets(numTraces)=70;
yMin=-100+plotOffsets(numTraces);
yMax=(numTraces-1)*ySeparation+100+(displayInputVgamma>0)*70;

for j=1:numTraces
    cell=plotCells(j);
    plot(xaxis,fullV(cell,:)+(numTraces-j)*ySeparation+plotOffsets(j),'Color','blue','LineWidth',2)
end

inputHeight=100;

color1='\color[rgb]{1.00,0.00,0.00}';
color2='\color[rgb]{0.00,1.00,0.00}';
color0='\color[rgb]{0.00,0.00,0.00}';

inputColor=[1 0 0];
inputBetaColor=[0 1 0];

yyaxis left

ax.YAxis(2).Color='black';
ax.YAxis(2).FontSize=20;
ax.XAxis.FontSize=20;

ax.YAxis(2).TickLength=[0 0];

yyaxis left
if displayInputVgamma>0
    for i=1:colNumLTS
        plot(xaxis,fullInputV(displayInputVgamma+i-1,:)*0.5+70+(numTraces-i+1)*ySeparation-200,'lineWidth',2,'Color',inputColor,'LineStyle','-','Marker','None');
    end
end

if displayInputVbeta>0
    for i=1:colNumLTS
        plot(xaxis,fullInputV(displayInputVbeta+i-1,:)*0.5+70+(numTraces-i+1)*ySeparation-260,'lineWidth',2,'Color',inputBetaColor,'LineStyle','-','Marker','None');
    end
end

yyaxis left
y1=[];
y1Label=[];
if showUnits
    for tt=1:numTraces
        y1=[y1 (tt-1)*ySeparation-50+plotOffsets(numTraces+1-tt) (tt-1)*ySeparation+plotOffsets(numTraces+1-tt) (tt-1)*ySeparation+50+plotOffsets(numTraces+1-tt)];
        y1Label=[y1Label; '\fontsize{14} -50'; '\fontsize{14}   0';'\fontsize{14}  50'];        
    end
    ax.YLabel.String='Membrane potential (mV)';
end
ax.YTick=y1;
ax.YTickLabel=y1Label;

yyaxis right
ax.YTick=[-10:ySeparation:3*ySeparation-10]+flip(plotOffsets)';
ax.YTickLabel=[[color0 'RS  '];[color0 'SI 3'];[color0 'SI 2'];[color0 'SI 1']];

ax.XLim=[xMin xMax];
ax.YAxis(1).Limits=[yMin yMax];
ax.YAxis(2).Limits=[yMin yMax];

yyaxis right

h.PaperUnits = 'inches';

h.PaperPosition = [0 0 12 6];

set(h,'PaperSize',[h.PaperPosition(3), h.PaperPosition(4)]);

if nameSuffix
    fullPath=strcat(folder,'/membraneV-multiplex-',nameSuffix);
else
    fullPath=strcat(folder,'/membraneV-multiplex');
end

saveas(h,fullPath,'fig')
saveas(h,fullPath,'png')
print(h,fullPath,'-dpdf','-r0')