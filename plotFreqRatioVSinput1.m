
filepath=strcat(folder,'/',nameSuffix,'.mat');
%load(filepath)

%numCvalues=freqData.Count;

%gs=keys(freqData);

freqRatios=input1freqs./IBfreqs;

h=figure(1);
clf;
hold on
plot(input1freqs,freqRatios,'LineWidth',2,'Color','black');
%plot([input1freqs(1) input1freqs(end)],[input1freqs(1) input2freqs(end)],'LineWidth',1.5,'Color','black');
%hold off
%legend(cs)
% h=figure(1);
% clf;
% plot(input2freqs,SIfreqs,'LineWidth',3);
% hold on
% plot([input2freqs(1) input2freqs(end)],[input2freqs(1) input2freqs(end)],'LineWidth',1.5,'Color','red');
% hold off

ax=gca;
ax.FontWeight='bold';
ax.FontSize=20;
ax.XTick;
%ax.XLabel.FontWeight='bold';
%ax.YLabel.FontWeight='bold';
%ax.XTickLabel.Fontweight='bold';
%ax.XLabel.FontSize=26;
%ax.YLabel.FontSize=26;
ax.XLabel.String='Input frequency';
ax.YLabel.String='Input / IB frequency ratio';
ax.YTick=[1,1.5,2, 7/3,2.5,3,3.5,11/3,4,5];
%ax.YTickLabel=[' 1 ';'1.5';' 2 ';'7/3';'2.5';' 3 ';'3.5';' 4 '];
ax.YTickLabel=['\fontsize{14}   1 ';'\fontsize{14}  1.5';'\fontsize{14}   2 ';'\fontsize{14}  7/3';'\fontsize{14}  2.5';'\fontsize{14}   3 ';'\fontsize{14}  3.5';'\fontsize{14} 11/3';'\fontsize{14}   4 ';'\fontsize{14}   5 '];
plot([0,30],[2 2],'Color','black','LineStyle','--')
plot([0,40],[7/3 7/3],'Color','black','LineStyle','--')
plot([0,44],[2.5 2.5],'Color','black','LineStyle','--')
plot([0,52],[3 3],'Color','black','LineStyle','--')
plot([0,58],[3.5 3.5],'Color','black','LineStyle','--')
plot([0,62],[11/3 11/3],'Color','black','LineStyle','--')
plot([0,70],[4 4],'Color','black','LineStyle','--')
%plot([0,70],[5 5],'Color','black','LineStyle','--')
ax.XLim=[input1freqs(1) input1freqs(end)];
ax.YLim=[1 freqRatios(end)+0.1];
hold off

h.PaperUnits = 'inches';
h.PaperPosition = [0 0 6 6];

filepath=strcat(folder,'/',nameSuffix);
saveas(h,filepath,'fig');
saveas(h,filepath,'png');
set(h,'PaperSize',[h.PaperPosition(3), h.PaperPosition(4)]);
print(h,filepath,'-dpdf','-r0')