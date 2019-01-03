function [BWTime] = flightTime(FDBW)
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
pps=200;
FDBWdata=uniformData(FDBW,pps);
BWTime=sum(FDBWdata==1)/pps;

%{
simTime=max(FDBW.Time);
timeVector=0:1/pps:simTime;
figure();
plot(timeVector,FDBWdata);
%}
end

