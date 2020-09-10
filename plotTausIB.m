
widthConst=2;

V=-100:0.1:50;
h=figure(1);
clf
hold on

tau=tauHCalc(V,1);
plot(V,tau,'LineWidth',widthConst)

tau=tauMCalc(V,1);
plot(V,tau,'LineWidth',widthConst)

tau=tauMARCalc(V); 
mARInf=mARInfCalc(V,75); % for dendrites
[a,b]=tauToAlpha(tau,mARInf);
[tau dummy]=alphaToTau(2.75*a,3*b); % The actual rates for dendrites -  multiply the forward and backward rates by constants.
plot(V,tau,'LineWidth',widthConst)

alphaKM=0.02./(1+exp((-V-20)/5));
betaKM=0.01*exp((-V-43)/18);
[tau dummy]=alphaToTau(alphaKM,betaKM); % The actual rate of the axon is different, due to the multiplication of the 'alpha' and 'beta' rates by constants.plot(V,tau,'LineWidth',widthConst)
plot(V,tau,'LineWidth',widthConst)

alphaCaH=1.6./(1+exp(-0.072*(V-5)));
betaCaH=0.02*(V+8.9)./(exp((V+8.9)/5)-1);
tauCaH=0.33;
alphaCaH=alphaCaH/tauCaH;
betaCaH=betaCaH/tauCaH;
[tau dummy]=alphaToTau(alphaCaH,betaCaH);
plot(V,tau,'LineWidth',widthConst)
ax=gca;
ax.FontWeight='bold';
ax.FontSize=20;
ax.XLabel.String='V (mV)';
ax.YLabel.String='\tau (ms)';
set(gca,'YScale','log')
ax.YLim=[0.03 1000];

legend(...
    {'h',...
    'm',...
    'mAR (h-current)',...
    'mKM (M-current)',...
    'mCaH'},...
    'FontSize',14,'FontWeight','bold','Location','eastoutside'...
    )


%title('Time constants of IB currents.','FontSize',14,'FontWeight','bold')

h.PaperUnits = 'inches';
h.PaperPosition = [0 0 8 6];

fullPath=strcat(folder,'/tausIB');
saveas(h,fullPath,'fig')
saveas(h,fullPath,'png')
set(h,'PaperSize',[h.PaperPosition(3), h.PaperPosition(4)]);
print(h,fullPath,'-dpdf','-r0')