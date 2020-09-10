filepath=strcat(folder,'/',nameSuffix);
%load(strcat(filepath,'.mat'))

h=figure(1);
clf;
hold on
plot(input2freqs,SIfreqs,'LineWidth',2,'Color','black');
plot([input2freqs(1) input2freqs(end)],[input2freqs(1) input2freqs(end)],'LineStyle','--','LineWidth',1.5,'Color','black');
hold off

ax=gca;
ax.FontWeight='bold';
ax.FontSize=20;
ax.XTick;
ax.XLim=[min(input2freqs) max(input2freqs)];
ax.YLim=[min(input2freqs) max(input2freqs)];
ax.XLabel.String='input-2 frequency';
if oneCell
    ax.YLabel.String='cell frequency';
else
    ax.YLabel.String='SI firing rate';
end
h.PaperUnits = 'inches';
h.PaperPosition = [0 0 6 6];

saveas(h,filepath,'fig')
%saveas(h,filepath,'png')
set(h,'PaperSize',[h.PaperPosition(3), h.PaperPosition(4)]);
print(h,filepath,'-dpdf','-r0')