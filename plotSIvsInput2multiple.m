h=figure(8);
clf;
hold on
load(strcat(folder,'/','SIvsInput2-40Hz','.mat')); % 40 Hz c=17ms
plot(input2freqs,SIfreqs,'LineWidth',2);
load(strcat(folder,'/','SIvsInput2-45Hz','.mat')); % 40 Hz c=17ms
plot(input2freqs,SIfreqs,'LineWidth',2,'LineStyle','-.');
load(strcat(folder,'/','SIvsInput2-40Hz-c135','.mat')); % This is used for weak FS->SI (ignore name)
plot(input2freqs,SIfreqs,'LineWidth',2,'LineStyle','--','Color',[0.7 0.7 0]);

plot([input2freqs(1) input2freqs(end)],[input2freqs(1) input2freqs(end)],'LineStyle','--','LineWidth',1.5,'Color',[0.5 0.5 0.5]);

ax=gca;
ax.FontWeight='bold';
ax.FontSize=20;
ax.XTick;
ax.XLabel.String='input-2 frequency';
ax.YLabel.String='SI firing rate';
ax.XLim=[input2freqs(1) input2freqs(end)];
ax.YLim=[input2freqs(1) input2freqs(end)];
legend('f_1=40Hz','f_1=45Hz','f_1=40Hz weak FS->SI','Location','northwest')

h.PaperUnits = 'inches';
h.PaperPosition = [0 0 6 6];

filepath=strcat(folder,'/SIvsInput2multiple');

saveas(h,filepath,'fig')
%saveas(h,filepath,'png')
set(h,'PaperSize',[h.PaperPosition(3), h.PaperPosition(4)]);
print(h,filepath,'-dpdf','-r0')