filepath=strcat(folder,'/',nameSuffix,'.mat');
load(filepath)

h=figure(1);
clf;
hold on
plot(input1freqs,SIfreqs1,'LineWidth',2,'Color','black');
plot([input1freqs(1) input1freqs(end)],[input1freqs(1) input1freqs(end)],'LineStyle','--','LineWidth',1.5,'Color','black');
hold off

ax=gca;
ax.FontWeight='bold';
ax.FontSize=20;
ax.XTick;
ax.XLabel.FontWeight='bold';
ax.YLabel.FontWeight='bold';
ax.XLabel.FontSize=26;
ax.YLabel.FontSize=26;
ax.XLabel.String='input-1 frequency';
ax.YLabel.String='SI firing rate';
h.PaperUnits = 'inches';
h.PaperPosition = [0 0 6 6];

filepath=strcat(folder,'/',nameSuffix);
saveas(h,filepath,'fig');
%saveas(h,filepath,'png');
set(h,'PaperSize',[h.PaperPosition(3), h.PaperPosition(4)]);
print(h,filepath,'-dpdf','-r0')