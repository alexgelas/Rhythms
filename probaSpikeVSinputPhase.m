input1=fullInputV(displayInputVgamma,:);
input2=fullInputV(displayInputVbeta,:);
SI_V=fullV(LTS,:);
FS_V=fullV(FS,:);

skipInitial=5; % Exclude transients
input2phasesAtInput1Pulse=timeFromLast(input1,input2,skipInitial,dt); % Input-2 phase (in ms) at input-1 pulse
input1phasesAtInput2Pulse=timeFromLast(input2,input1,skipInitial,dt); % Input-2 phase at input-1 pulse

input1toNextSI=trimNaN(timeToNext(input1,SI_V,skipInitial,dt));
input2toNextSI=trimNaN(timeToNext(input2,SI_V,skipInitial,dt));

SIfiredAfterInput1=input1toNextSI<3 & input1toNextSI>0; % Did SI fire within 3ms from input-1 pulse?
SIfiredAfterInput2=input2toNextSI<3 & input2toNextSI>0; % We need the >0 to avoid situations where the cell fires in response to the other input (but with a synaptic delay, so it fires after this input's pulse has arrived). The >0 effectively means >=dt. The value used was dt=0.2 ms.

if ~oneCell
    input1toNextFS=trimNaN(timeToNext(input1,FS_V,skipInitial,dt));
    input2toNextFS=trimNaN(timeToNext(input2,FS_V,skipInitial,dt));
    FSfiredAfterInput1=input1toNextFS<3 & input1toNextFS>0;
    FSfiredAfterInput2=input2toNextFS<3 & input2toNextFS>0;
end

h1=figure(1); clf;
ax=gca;
hold on
if ~oneCell
    plotFireProba(input2phasesAtInput1Pulse(1:length(FSfiredAfterInput1)),FSfiredAfterInput1,1000/beta1Freq) % We trim the first vector to match the size of the second, because we have removed the NaN values from the end of the second. This is because some input pulses might be too close to the end of the simulation for the cell to have time to fire (in which case there is no "next" cell spike, a NaN is produced in the timeToNext file and it is removed earlier in this file).
end
plotFireProba(input2phasesAtInput1Pulse(1:length(SIfiredAfterInput1)),SIfiredAfterInput1,1000/beta1Freq)
hold off
ax.XLabel.String='Time of input-1 arrival (ms)';
if ~oneCell
    legend('FS','SI')
end

if ~oneCell
    h2=figure(2); clf;
    ax=gca;
    hold on
    plotFireProba(input1phasesAtInput2Pulse(1:length(FSfiredAfterInput2)),FSfiredAfterInput2,1000/gammaFreq)
    plotFireProba(input1phasesAtInput2Pulse(1:length(SIfiredAfterInput2)),SIfiredAfterInput2,1000/gammaFreq)
    hold off
    ax.XLabel.String='Time of input-2 arrival (ms)';
    legend('FS','SI')
end

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

if ~oneCell
    if nameSuffix
        fullPath=strcat(folder,'\probaSpikeVsInput1-',nameSuffix);
    else
        fullPath=strcat(folder,'\probaSpikeVsInput1');
    end
    saveas(h2,fullPath,'fig')
    %saveas(h2,fullPath,'png')
    set(h2,'PaperSize',[h2.PaperPosition(3), h2.PaperPosition(4)]);
    print(h2,fullPath,'-dpdf','-r0')
end