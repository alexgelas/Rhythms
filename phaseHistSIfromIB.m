IB_V=fullV(IBaxon,:);
SI_V=fullV(LTS,:);
input1=fullInputV(displayInputVgamma,:);

skipInitial=5;

timeSIfromLastIB=timeFromLast(SI_V,IB_V,skipInitial,dt);
timeGammaFromLastIB=timeFromLast(input1,IB_V,skipInitial,dt);

h=figure(2);
clf
histMax=max(timeSIfromLastIB)+1;
hold on
histogram(timeSIfromLastIB(find(timeSIfromLastIB>0,1,'first'):find(timeSIfromLastIB>0,1,'last')),[0:1:49])
hold off
ax=gca;
ax.XLim(1)=0;
ax.FontWeight='bold';
ax.FontSize=20;
ax.XLabel.String='Time from last IB burst (ms)';
ax.YLabel.String='Number of SI spikes';

fullPath=strcat(folder,'/histSIfromIB');
if nameSuffix
    fullPath=strcat(fullPath,'-',nameSuffix);
end
h.PaperUnits = 'inches';
h.PaperPosition = [0 0 6 4];

saveas(h,fullPath,'fig')
%saveas(h,fullPath,'png')
%saveas(h,fullPath,'pdf')
set(h,'PaperSize',[h.PaperPosition(3), h.PaperPosition(4)]);
set(h,'Renderer','opengl')
print(h,fullPath,'-dpdf','-r0');