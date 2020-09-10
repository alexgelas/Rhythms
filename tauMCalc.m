function tauM=tauMCalc(V,exc)
% exc=1 if excitatory, exc=0 if inhibitory

%tauMexc=0.25+4.35*exp(-abs(V+10)/10); % Only for excitatory cells
%tauMinh=0.25+4.35*exp(-abs(V+10)/10); % Only for inhibitory cells

%tauM=tauMinh+exc.*(tauMexc-tauMinh); % Combine

% We do it in one line instead:
tauM=0.25+4.35*exp(-abs(V+10)/10);
