function [tau, xInf]=alphaToTau(alpha,beta)
% The exponential decay equation can be written as
% x'=1/tau*(xInf-x) or x'=alpha*(1-x)-beta*x
% This function converts (alpha, beta) to (tau, xInf).
tau=1./(alpha+beta);
xInf=alpha./(alpha+beta);