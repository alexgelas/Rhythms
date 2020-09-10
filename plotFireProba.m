function out=plotFireProba(phases,fired,maxPhase)
% Creates a plot with the probability of firing as a function of "phase".
% The inputs 'phases' and 'fired' must have same length. phases(i) is the phase of some
% oscillator at event i and fired(i) is 1 if the cell fired immediately
% after event i (and 0 otherwise). The plot shows the proportion of times
% that the cell fired for a given phase.

graphStep=0.5;
midPoints=graphStep/2:graphStep:maxPhase;
numGraphPoints=length(midPoints);
probaSpike=zeros(numGraphPoints,1);

beg=find(phases>0,1,'first');
stop=find(phases>0,1,'last');

for i=1:numGraphPoints
    denom=sum(phases(beg:stop)>midPoints(i)-graphStep/2 & phases(beg:stop)<=midPoints(i)+graphStep/2);
    numer=sum(phases(beg:stop)>midPoints(i)-graphStep/2 & phases(beg:stop)<=midPoints(i)+graphStep/2 & fired(beg:stop));
    probaSpike(i)=numer/denom;
end
ax=gca;
plot(midPoints(~isnan(probaSpike)),probaSpike(~isnan(probaSpike)),'LineWidth',2)
ax.FontWeight='bold';
ax.FontSize=20;
ax.YLabel.String='Probability of firing';