function tauH=tauHCalc(V,exc)
% exc=1 if excitatory, exc=0 if inhibitory

%tauHexc=0.15+1.15./(1+exp((V+33.5)/15)); % Only for excitatory cells
%tauHinh=0.225+1.125./(1+exp((V+37)/15)); % Only for inhibitory cells

%tauH=tauHinh+exc.*(tauHexc-tauHinh); % Combine

% We do it in one line instead:
tauH=exc.*(0.15+1.15./(1+exp((V+33.5)/15)))+(1-exc).*(0.225+1.125./(1+exp((V+37)/15)));