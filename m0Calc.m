function m0=m0Calc(V,exc)
% exc=1 if excitatory, exc=0 if inhibitory

%m0exc=1./(1+exp((-V-34.5)/10)); % Only for excitatory cells
%m0inh=1./(1+exp((-V-38)/10)); % Only for inhibitory cells

%m0=m0inh+exc.*(m0exc-m0inh); % Combine

% We do it in one line instead
m0=exc./(1+exp((-V-34.5)/10))+(1-exc)./(1+exp((-V-38)/10));