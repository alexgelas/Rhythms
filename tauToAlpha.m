function [alpha, beta]=tauToAlpha(tau,xInf)
% The exponential decay equation can be written as
% x'=1/tau*(xInf-x) or x'=alpha*(1-x)-beta*x
% This function converts (tau, xInf) to (alpha, beta).
alpha=xInf./tau;
beta=(1-xInf)./tau;