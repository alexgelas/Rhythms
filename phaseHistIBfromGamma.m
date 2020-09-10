IB_V=fullV(IBaxon,:);
input1=fullInputV(displayInputVgamma,:);

skipInitial=5;
timeIBfromLastGamma=timeFromLast(IB_V,input1,skipInitial,largeDt); % Feb '20


h=figure(2);

histMax=1000/gammaFreq*1/(1-4*gammaJitter);

if thinISI
    histogram(timeIBfromLastGamma(find(timeIBfromLastGamma>0,1,'first'):find(timeIBfromLastGamma>0,1,'last')),[0:0.2:histMax])
else
    histogram(timeIBfromLastGamma(find(timeIBfromLastGamma>0,1,'first'):find(timeIBfromLastGamma>0,1,'last')),[0:0.5:histMax])
end

ax=gca;
ax.XLim(1)=0;
ax.XLim(2)=histMax;
ax.FontWeight='bold';
ax.FontSize=20;
ax.XLabel.String='Time from last input pulse (ms)';
ax.YLabel.String='Number of IB bursts';

fullPath=strcat(folder,'/histIBfromGamma');
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
set(h,'Renderer','opengl')
print(h,fullPath,'-dpdf','-r0');