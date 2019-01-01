% Run all the sims to generate the basic graphs for the different road
% profiles

for pt=1:5
   disp(['Running Sim ' num2str(pt)]);
   set_param('halfmodel/Forcing Selector/Road Profile Control Signal','Value',num2str(pt))
   sim('halfmodel');
   graphsMaker;
end
disp('Sims Complete');