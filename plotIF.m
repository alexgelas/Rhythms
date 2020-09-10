inputColor=[1 0 0];
inputBetaColor=[0 1 0];

stepsPlot=length(fullV);

xaxis=(1:stepsPlot)*dt;

xMin=0;
xMax=500;

ySeparation=280;

figNum=6;
h=figure(figNum);
clf
ax=gca;
ax.XLabel.String='Time (ms)';
ax.FontWeight='bold';
ax.FontSize=20;
hold on
plot(xaxis,fullV,'Color','blue','LineWidth',2,'LineStyle','-','Marker','None')
yMax=320;
inputHeight=70;

plot(xaxis,fullInput1*dt*inputHeight/input1strength+200,'lineWidth',2,'Color',inputColor,'LineStyle','-','Marker','None');
plot(xaxis,-fullInput2*inputHeight/abs(input2reset)+75,'lineWidth',2,'Color',inputBetaColor,'LineStyle','-','Marker','None');

color1='\color[rgb]{1.00,0.00,0.00}';
color2='\color[rgb]{0.00,1.00,0.00}';
color0='\color[rgb]{0.00,0.00,0.00}';

yyaxis right
yMin=-110;
ax.YTick=[-10 130 240];
ax.YTickLabel=[['\color{black}' 'cell   '];['\color{green}' 'input-2'];['\color{red}' 'input-1  ']];

yyaxis left

if showUnits
    y1=[-50 0 50];
    y1Label=['\fontsize{12} -50'; '\fontsize{12}   0'; '\fontsize{12}  50'];
    ax.YTick=y1;
    ax.YTickLabel=y1Label;
    ax.YLabel.String='\fontsize{18} Membrane\newline potential (mV)';
end

ax.XLim=[xMin xMax];
ax.YAxis(1).Limits=[yMin yMax];
ax.YAxis(2).Limits=[yMin yMax];

ax.YAxis(2).Color='black';
ax.YAxis(2).FontSize=20;
ax.XAxis.FontSize=20;

ax.YAxis(2).TickLength=[0 0];

h.PaperUnits = 'inches';
h.PaperPosition = [0 0 12 2.5];

set(h,'PaperSize',[h.PaperPosition(3), h.PaperPosition(4)]);

if nameSuffix
    fullPath=strcat(folder,'/membraneV-',nameSuffix);
else
    fullPath=strcat(folder,'/membraneV');
end

saveas(h,fullPath,'fig')
%saveas(h,fullPath,'png')
print(h,fullPath,'-dpdf','-r0')