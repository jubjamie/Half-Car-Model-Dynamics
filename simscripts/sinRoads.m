% Run the sin case at different speeds
% Set speeds and profile type.
speeds=1:0.5:10;
set_param('halfmodel/Forcing Selector/Road Profile Control Signal','Value','2');

amps=zeros(1,numel(speeds));
for sp=1:numel(speeds)
    disp(['Running Sim @ ' num2str(speeds(sp)) ' m/s']);
    v_speed=speeds(sp);
    sim('halfmodel');
    simStatus=get_param('halfmodel','SimulationStatus');
    waitfor(simStatus,'Value','stopped');
    amps(sp)=sinStats(Displacements.Body_Displacement,5);
end
disp('Sims Complete');

f21=figure(21);
hold off;
plot(speeds,amps);
xlabel('Vehicle Speed (m/s)');
ylabel('Average Body Displacement Amplitude (m)');
title('Average Body Displacement Amplitude on the Sinousoidal Road at Different Speeds');
grid on;
set(f21,'Position',[150 150 800 550]);
saveas(f21,'graphs/sin/averageAmps.png');