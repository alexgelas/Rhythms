h=figure(8);
clf;
hold on
load(strcat(folder,'/','SIvsInput1','.mat')); % 16.357Hz c=17ms
plot(input1freqs,SIfreqs1,'LineWidth',2);
load(strcat(folder,'/','SIvsInput1-18357Hz','.mat')); % 18.357 Hz c=17ms
plot(input1freqs,SIfreqs1,'LineWidth',2,'LineStyle','-.');
load(strcat(folder,'/','SIvsInput1-c135','.mat')); % 16.357 Hz c=13.5ms
plot(input1freqs,SIfreqs1,'LineWidth',2,'LineStyle','--','Color',[0.7 0.7 0]);

ax=gca;
ax.FontWeight='bold';
ax.FontSize=20;
ax.XTick;
ax.XLabel.String='input-1 frequency';
ax.YLabel.String='SI firing rate';
ax.XLim=[input1freqs(1) input1freqs(end)];
legend('f_2=16.357Hz','f_2=18.357Hz','f_2=16.357Hz, weak FS->SI','Location','southwest')

h.PaperUnits = 'inches';
h.PaperPosition = [0 0 6 6];

filepath=strcat(folder,'/SIvsInput1multiple');

saveas(h,filepath,'fig')
%saveas(h,filepath,'png')
set(h,'PaperSize',[h.PaperPosition(3), h.PaperPosition(4)]);
print(h,filepath,'-dpdf','-r0')