function [BWTime] = flightTime(FDBW)
%flightTime Calculate flight time from flight data
pps=200;
FDBWdata=uniformData(FDBW,pps);
BWTime=sum(FDBWdata==1)/pps;
end

