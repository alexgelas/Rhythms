tempNumInputSynapses=10;

r=zeros(tempNumInputSynapses,1); s=zeros(tempNumInputSynapses,1); t=zeros(tempNumInputSynapses,1); u=zeros(tempNumInputSynapses,1);

displayInputVgamma=0;
displayInputVbeta=0;

if gammaInput
    if realRS
        for i=1:colNumRS
            [r, s, t, u]=addInputSynapse(r,s,t,u,6,RS(i),51,150);
        end
    else
        if ~oneCell && ~multiplex
            for i=1:colNumFS
                [r, s, t, u]=addInputSynapse(r,s,t,u,6,FS(i),2,2.5);
            end
        end
        for i=1:colNumLTS
            [r, s, t, u]=addInputSynapse(r,s,t,u,5+i,LTS(i),3,gGammaToSI);
        end
    end
    displayInputVgamma=6;
end

if ~realIB
    if ~oneCell && ~multiplex
        for i=1:colNumFS
            [r, s, t, u]=addInputSynapse(r,s,t,u,9,FS(i),13,3);
        end
        for i=1:colNumLTS
            [r, s, t, u]=addInputSynapse(r,s,t,u,9,LTS(i),14,0.9);
        end
    else
        for i=1:colNumLTS
            [r, s, t, u]=addInputSynapse(r,s,t,u,8+i,LTS(i),6,gFStoSI);
        end
    end
    displayInputVbeta=9;
end

numInputSynapses=find(r>0,1,'last');

if isempty(numInputSynapses)
    [r, s, t, u]=addInputSynapse(r,s,t,u,1,1,1,0); % dummy, does nothing
    numInputSynapses=1;
end

inputSource=r(1:numInputSynapses);
inputTarget=s(1:numInputSynapses);
inputSynapseType=t(1:numInputSynapses);
gInput=u(1:numInputSynapses);