J=calcJ(V,synToPost,gSyn,s,Vrev,postSyn,gapToPost,...
            gGap,preGap,postGap,inputToPost,gInput,sInput,...
            inputVrev,inputTarget,noiseIntensity,...
            Itonic,largeDt);

dVdt=Vstep(V,h,m,mAR,mKM,mCaH,J,...
    VRest,VNaF,VKDR,VAR,VKM,VCaH,...
    gLeak,gNaF,gKDR,gAR,gKM,gCaH,...
    capacitance,exc,1);

dsdt=synapse(s,rise,decay,V(preSyn),1)-s;%-s./decay +(1-s)./rise.*(1+tanh(V(preSyn)/10))/2;
dsInputdt=synapse(sInput,inputSynRise,inputSynDecay,inputV(inputSource),1)-sInput;%-sInput./inputSynDecay +(1-sInput)./inputSynRise.*(1+tanh(inputV(inputSource)/10))/2;

if max(abs(dVdt))<5 && max(abs(dsdt))<1 && max(abs(dsInputdt))<1 % Dynamic step size
    V=V+largeDt*dVdt;
    
    [dh,dm,dMAR,dMKM,dMCaH]=...
        internalCurrentsStep(V,h,m,mAR,mKM,mCaH,V0,...
        alphaMARFactor,betaMARFactor,alphaKMFactor,betaKMFactor,...
        alphaCaHFactor,betaCaHFactor,exc,largeDt);
    
    h=h+dh;
    m=m+dm;
    mAR=mAR+dMAR;
    mKM=mKM+dMKM;
    mCaH=mCaH+dMCaH;
    
    s=s+dsdt*largeDt;
    sInput=sInput+dsInputdt*largeDt;
else
    movedSlow(i)=1;
    
    for smallStep=1:numSmallSteps
        
        J=calcJ(V,synToPost,gSyn,s,Vrev,postSyn,gapToPost,...
            gGap,preGap,postGap,inputToPost,gInput,sInput,...
            inputVrev,inputTarget,noiseIntensity,...
            Itonic,smallDt);
        
        V=V+Vstep(V,h,m,mAR,mKM,mCaH,J,...
            VRest,VNaF,VKDR,VAR,VKM,VCaH,...
            gLeak,gNaF,gKDR,gAR,gKM,gCaH,...
            capacitance,exc,smallDt);
        
        [dh,dm,dMAR,dMKM,dMCaH]=...
            internalCurrentsStep(V,h,m,mAR,mKM,mCaH,V0,...
            alphaMARFactor,betaMARFactor,alphaKMFactor,betaKMFactor,...
            alphaCaHFactor,betaCaHFactor,exc,smallDt);
        
        h=h+dh;
        m=m+dm;
        mAR=mAR+dMAR;
        mKM=mKM+dMKM;
        mCaH=mCaH+dMCaH;
        
        s=synapse(s,rise,decay,V(preSyn),smallDt);
        sInput=synapse(sInput,inputSynRise,inputSynDecay,inputV(inputSource),smallDt);
    end
end

    
