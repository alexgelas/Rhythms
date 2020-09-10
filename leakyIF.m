Ia=0;
I1=0;
I2=0;
V=Vrest;
fullV=zeros(steps,1);
fullInput1=zeros(steps,1);
fullInput2=zeros(steps,1);
fullAutapse=zeros(steps,1);
spikeTimes=[];
input1times=[];
input2times=[];
phi0=rand(1)*1/dt*(1000/f1);
for i=1:steps
    Ia=Ia-1/tauAutapse*Ia*dt;
    I2=I2-1/tau2*I2*dt;
    Isyn=Ia+I1+I2;
    dVdt=-1/tauV*(V-Vrest)+Isyn;
    V=V+dt*dVdt;
    fullV(i)=V;
    fullInput1(i)=I1;
    fullInput2(i)=I2;
    fullAutapse(i)=Ia;
    I1=0;
    if V>=thresh
        V=Vreset;
        fullV(i)=50; % for illustration purposes
        Ia=autapseReset;
        spikeTimes=[spikeTimes i*dt];
    end
    if mod(i+phi0,1/dt*(1000/f1))<1
        I1=input1strength/dt;
        input1times=[input1times i*dt];
    end
    if mod(i,1/dt*1000/f2)<1
        I2=input2reset;
        input2times=[input2times i*dt];
    end
end

if nameSuffix
    filepath=strcat(folder,'/IF','.mat');
else
    filepath=strcat(folder,'/IF-',nameSuffix,'.mat');
end
save(filepath,'fullV','fullInput1','fullInput2','fullAutapse',...
    'input1times','input2times','spikeTimes','dt','steps',...
    'tauV','tau2','tauAutapse','Vreset','autapseReset',...
    'input2reset','input1strength','thresh','f1','f2')