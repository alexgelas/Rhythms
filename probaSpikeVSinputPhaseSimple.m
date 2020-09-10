% It takes spike times, instead of membrane potential traces.
% Works for IF and abstract models

skipInitial=5; % Exclude transients
input2phasesAtInput1Pulse=timeFromLastB(input1times,input2times,skipInitial); % Input-2 phase (in ms) at input-1 pulse

input1ToCell=trimNaN(timeToNextB(input1times,spikeTimes,skipInitial));
cellFiredAfterInput1=input1ToCell<3; % Did cell fire within 3ms from input-1 pulse?

h1=figure(1); clf;
ax=gca;
plotFireProba(input2phasesAtInput1Pulse(1:length(cellFiredAfterInput1)),cellFiredAfterInput1,1000/f2)
ax.XLabel.String='Time of input-1 arrival (ms)';

h1.PaperUnits = 'inches';
h1.PaperPosition = [0 0 6 5];
if ~oneCell
    h2.PaperUnits = 'inches';
    h2.PaperPosition = [0 0 6 5];
end

if nameSuffix
    fullPath=strcat(folder,'\probaSpikeVsInput2-',nameSuffix);
else
    fullPath=strcat(folder,'\probaSpikeVsInput2');
end
saveas(h1,fullPath,'fig')
%saveas(h1,fullPath,'png')
set(h1,'PaperSize',[h1.PaperPosition(3), h1.PaperPosition(4)]);
print(h1,fullPath,'-dpdf','-r0')