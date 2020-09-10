inputV=expDecay(inputV,-70,1,dt);
        
if mod(i,nextInp6/dt)<1
    inputV(6)=25;
    nextInp6=nextInp6+1000/gammaFreq*(1+gammaJitter*randn());
end

if mod(i,nextInp7/dt)<1
    inputV(7)=25;
    nextInp7=nextInp7+1000/gammaFreq*(1+gammaJitter*randn());
end

if mod(i,nextInp8/dt)<1
    inputV(8)=25;
    nextInp8=nextInp8+1000/gammaFreq*(1+gammaJitter*randn());
end

if mod(i,nextInp9/dt)<1
    inputV(9)=25;
    nextInp9b=nextInp9+1000/(3*beta1Freq);
    nextInp9c=nextInp9+2*1000/(3*beta1Freq);
    nextInp9=nextInp9+1000/beta1Freq*(1+betaJitter*randn()); % Nov '18
end

if (i-nextInp9b/dt>=0) && (i-nextInp9b/dt<1)
    inputV(10)=25;
end
if (i-nextInp9c/dt>=0) && (i-nextInp9c/dt<1)
    inputV(11)=25;
end