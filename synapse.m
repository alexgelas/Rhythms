function newS=synapse(oldS,tauRise,tauDecay,Vpre,dt)
newS=oldS+dt*( ...
    -oldS./tauDecay ...
    +(1-oldS)./tauRise.*(1+tanh(Vpre/10))/2 ...
    );