function hInf=hInfCalc(V,exc)
% exc=1 if excitatory, exc=0 if inhibitory

%hInfExc=1./(1+exp((V+59.4)/10.7)); % Only for excitatory cells
%hInfInh=1./(1+exp((V+58.3)/6.7)); % Only for inhibitory cells

%hInf=hInfInh+exc.*(hInfExc-hInfInh); % Combine

% We do it in one line instead:
hInf=exc./(1+exp((V+59.4)/10.7))+(1-exc)./(1+exp((V+58.3)/6.7));
