calcSpikes;

interBurst=([burstTimes 0]-[0 burstTimes]);
interBurst=interBurst(2:length(interBurst)-1);

ltsSpikeTimes=find(spikes(LTS,:))*dt;
IBfromLTS=zeros(length(burstTimes),1);

LTSfromPreviousIB=zeros(length(burstTimes),1);
IBfromPreviousIB=zeros(length(burstTimes),1);

IBfromLTS(1)=-1;

plotNoise=0.1; % Add gaussian noise to make data visible (the actual analysis is limited by the time step largeDt)

for i=2:length(burstTimes)
    lastLTS=ltsSpikeTimes(find(ltsSpikeTimes<burstTimes(i),1,'last'));
    if isempty(lastLTS)
        IBfromLTS(i)=-1;
    else
        IBfromLTS(i)=burstTimes(i)-lastLTS+plotNoise*randn();
        LTSfromPreviousIB(i)=lastLTS-burstTimes(i-1)+plotNoise*randn();
        IBfromPreviousIB(i)=burstTimes(i)-burstTimes(i-1)+plotNoise*randn();
        if IBfromPreviousIB(i)<10
            i
        end
    end
end

%skip=max(10,find(IBfromLTS<0,1,'last'));
skip=5;  % mention
IBfromLTS(1:skip)=[];
IBfromPreviousIB(1:skip)=[];
LTSfromPreviousIB(1:skip)=[];

doublets=doublets-skip;
triplets=triplets-skip;
quadruplets=quadruplets-skip;

newLen=length(IBfromLTS);

color1='black';
color2='red';
color3=[0.3 0.3 1];

for ahead=0:1
    figure(8+ahead)
    clf
    hold on
    scatter(LTSfromPreviousIB(triplets(triplets>0 & triplets<=newLen-ahead)+ahead),IBfromPreviousIB(triplets(triplets>0 & triplets<=newLen-ahead)+ahead),30,'filled','MarkerFaceColor',color2)
    scatter(LTSfromPreviousIB(quadruplets(quadruplets>0 & quadruplets<=newLen-ahead)+ahead),IBfromPreviousIB(quadruplets(quadruplets>0 & quadruplets<=newLen-ahead)+ahead),30,'filled','MarkerFaceColor',color1)
    scatter(LTSfromPreviousIB(doublets(doublets>0 & doublets<=newLen-ahead)+ahead),IBfromPreviousIB(doublets(doublets>0 & doublets<=newLen-ahead)+ahead),30,'filled','MarkerFaceColor',color3)
    hold off
end

h=figure(7);
clf
hold on
scatter(LTSfromPreviousIB,IBfromPreviousIB,'filled','MarkerFaceColor','black')
hold off

for fig=7:9
    h=figure(fig);
    ax=gca;
    ax.FontSize=18;
    ax.FontWeight='bold';
    ax.XLabel.String='IB-SI (ms)';
    ax.YLabel.String='IB-IB (ms)';
    ax.XLim(1)=0;
    ax.XLim(2)=ceil(max(LTSfromPreviousIB)/5)*5;
    
    Ydiff=max(IBfromPreviousIB)-min(IBfromPreviousIB);
    Ymedium=(max(IBfromPreviousIB)+min(IBfromPreviousIB))/2;
    
    ax.YLim(2)=Inf;
    ax.YLim(1)=floor(min(Ymedium-7,min(IBfromPreviousIB))/5)*5;
    ax.YLim(2)=ceil(max(Ymedium+7,max(IBfromPreviousIB))/5)*5;
    
    h.PaperUnits = 'inches';
    h.PaperPosition = [0 0 6 4];

    if fig==7
        fullPath=strcat(folder,'/TRC-',nameSuffix);
    elseif fig==8
        fullPath=strcat(folder,'/TRC-',nameSuffix,'-coloredNextBurst');
    elseif fig==9
        fullPath=strcat(folder,'/TRC-',nameSuffix,'-coloredLastBurst');
    end

    saveas(h,fullPath,'fig')
    saveas(h,fullPath,'png')
    set(h,'PaperSize',[h.PaperPosition(3), h.PaperPosition(4)]);
    print(h,fullPath,'-dpdf','-r0')
end




    