function saveFig(folder,filepath,fig)

fullFilepath=strcat(folder,'/',filepath);
fig.PaperUnits = 'inches';
fig.PaperPosition = [0 0 6 4];
saveas(fig,fullFilepath,'fig');
%saveas(fig,fullFilepath,'png');
%saveas(fig,fullFilepath,'pdf');
set(fig,'PaperSize',[fig.PaperPosition(3), fig.PaperPosition(4)]);
print(fig,fullFilepath,'-dpdf','-r0')
end

