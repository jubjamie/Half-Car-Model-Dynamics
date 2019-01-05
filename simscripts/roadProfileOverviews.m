% Run all the sims to generate the basic graphs for the different road
% profiles

speeds=[5,10,15];

% Loop through speeds.

for pt=1:6
   for sp=1:numel(speeds)
    disp(['Running Sim ' num2str(pt) ' @ ' num2str(speeds(sp)) ' m/s']);
    
    % Set forcing selector control signal to choose profile
    set_param('halfmodel/Forcing Selector/Road Profile Control Signal',...
        'Value',num2str(pt));
    
    v_speed=speeds(sp);
    sim('halfmodel');
    simStatus=get_param('halfmodel','SimulationStatus');
    waitfor(simStatus,'Value','stopped');
    
    graphsMaker; % Run graph making script.
   end
end
disp('Sims Complete');