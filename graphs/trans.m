%transmissibility bits

BD=Displacements.Body_Displacement.Data;
RP=reshape(Forcing.Data(1,1,:),numel(BD),1)+bodySettle;
BD=BD(2:end);
RP=RP(2:end);
diffs=RP-BD;
transVals=100.*diffs./RP;
f50=figure(50);
plot(Forcing.Time(2:end),transVals);
disp(mean(transVals))