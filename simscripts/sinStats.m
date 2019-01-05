function [aveAmp] = sinStats(BD,cutInTime)
%SINSTATS Give rough average amplitude of cyclic data

% Uniform the data into 200 points/second.
pps=200; % Points per second
simTime=max(BD.Time);
timeVector=0:1/pps:simTime;
BDdata=uniformData(BD,pps);

%Cut out settling time
BDdata=BDdata(pps*cutInTime:end);
timeVector=timeVector(pps*cutInTime:end);

% Split into time strips
stripSteps=1*pps;
stripCount=fix(numel(BDdata)/stripSteps);
BDdataShort=BDdata(1:stripCount*stripSteps);
BDdataMatrix=reshape(BDdataShort,[stripSteps,stripCount]);

% Find min/max and calculate difference
maxValues=max(BDdataMatrix);
minValues=min(BDdataMatrix);
aveAmp=mean(maxValues-minValues)/2;
end

