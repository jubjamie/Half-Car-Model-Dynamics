% Run all the sims to generate the basic graphs for the different road
% profiles
speeds=[5,10,15];
for pt=1:5
   for sp=1:numel(speeds)
    disp(['Running Sim ' num2str(pt) ' @ ' num2str(speeds(sp)) ' m/s']);
    set_param('halfmodel/Forcing Selector/Road Profile Control Signal','Value',num2str(pt));
    v_speed=speeds(sp);
    sim('halfmodel');
    simStatus=get_param('halfmodel','SimulationStatus');
    waitfor(simStatus,'Value','stopped');
    graphsMaker;
   end
end
disp('Sims Complete');