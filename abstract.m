theta0=0; % initial phase difference of two inputs
m=2; % input-1 cycles to skip (can fire on the m-th)
%f1=40; % input-1 frequency, specified in defaultParamsAbstract
%f2=16.357; % input-2 frequency
T1=1000/f1; 
T2=1000/f2;
input1times=T1:T1:totalTime;
input2times=T2:T2:totalTime;
spikeTimes=[];
lastSpikeTime=-inf;
for i=1:length(input1times)
    t=input1times(i);
    if mod(t,T2)>tmin && (t-lastSpikeTime)>(m-0.5)*T1 % cell fires
        spikeTimes=[spikeTimes t];
        lastSpikeTime=t;
    end
end