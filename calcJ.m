function J=calcJ(V,synToPost,gSyn,s,Vrev,postSyn,gapToPost,gGap,preGap,postGap,inputToPost,gInput,sInput,inputVrev,inputTarget,noiseIntensity,Itonic,dt)

Isyn=synToPost*(gSyn.*s.*(V(postSyn)-Vrev));
Igap=gapToPost*(gGap.*(V(postGap)-V(preGap)));
Iinput=inputToPost*(gInput.*sInput.*(V(inputTarget)-inputVrev));
Inoise=0.01*noiseIntensity.*randn(length(noiseIntensity),1)*dt^(1/2); % unused

J=Iinput+Isyn+Igap+Inoise+Itonic;