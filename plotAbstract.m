inputColor=[1 0 0];
inputBetaColor=[0 1 0];

xMin=0;
xMax=1000;

ySeparation=2;

figNum=6;
h=figure(figNum);
clf
ax=gca;
ax.XLabel.String='Time (ms)';
ax.FontWeight='bold';
ax.FontSize=20;
hold on
for i=1:length(spikeTimes)
    t=spikeTimes(i);
    plot([t t],[0 1],'Color','blue','LineWidth',2,'LineStyle','-','Marker','None');
end
for i=1:length(input1times)
    t=input1times(i);
    plot([t t],[4 5],'Color',inputColor,'LineWidth',2,'LineStyle','-','Marker','None');
end
for i=1:length(input2times)
    t=input2times(i);
    plot([t t],[2 3],'Color',inputBetaColor,'LineWidth',2,'LineStyle','-','Marker','None');
end
yMax=6;

yyaxis right
yMin=-1;
ax.YTick=[0.5 2.5 4.5];
ax.YTickLabel=[['\color{black}' 'cell   '];['\color{green}' 'input-2'];['\color{red}' 'input-1  ']];

yyaxis left
ax.YTick=[];
ax.YTickLabel=[];

ax.XLim=[xMin xMax];
ax.YAxis(1).Limits=[yMin yMax];
ax.YAxis(2).Limits=[yMin yMax];

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
