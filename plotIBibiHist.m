IB_V=fullV(IBaxon,:);

skipInitial=5;

timeIBfromLastIB=timeFromLast(IB_V,IB_V,skipInitial,dt);

h=figure(17);
trimmedISI=timeIBfromLastIB(find(timeIBfromLastIB>0,1,'first'):find(timeIBfromLastIB>0,1,'last'));

len=length(trimmedISI);
timeFromTwoLast=trimmedISI(1:len-1)+trimmedISI(2:len);

if thinISI
    histogram(trimmedISI,0:0.1:max(trimmedISI));
else
    histogram(trimmedISI,0:0.4:max(trimmedISI));
end
ax=gca;
ax.XLim(1)=min(trimmedISI)-5; % arbitrary
ax.XLim(2)=max(trimmedISI)+5;
ax.FontWeight='bold';
ax.FontSize=20;
ax.XLabel.String='IB interburst interval length (ms)';
ax.YLabel.String='Number of IB bursts';

fullPath=strcat(folder,'/histIBibi');
if nameSuffix
    fullPath=strcat(fullPath,'-',nameSuffix);
end
h.PaperUnits = 'inches';
h.PaperPosition = [0 0 6 4];

saveas(h,fullPath,'fig')
%saveas(h,fullPath,'png')
set(h,'PaperSize',[h.PaperPosition(3), h.PaperPosition(4)]);
set(h,'Renderer','opengl')
print(h,fullPath,'-dpdf','-r0')