function mInf=mInfCalc(V,exc)
% exc=1 if excitatory, exc=0 if inhibitory

%mInfExc=1./(1+exp((-V-29.5)/10)); % Only for excitatory cells
%mInfInh=1./(1+exp((-V-27)/11.5)); % Only for inhibitory cells

%mInf=mInfInh+exc.*(mInfExc-mInfInh); % Combine

% We do it in one line instead:
mInf=exc./(1+exp((-V-29.5)/10))+(1-exc)./(1+exp((-V-27)/11.5));
