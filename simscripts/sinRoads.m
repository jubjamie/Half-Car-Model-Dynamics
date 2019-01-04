% Run the sin case at different speeds
% Set speeds and profile type.
speeds=0.5:0.1:30;
set_param('halfmodel/Forcing Selector/Road Profile Control Signal','Value','2');

amps=zeros(1,numel(speeds));
velAmps=amps;
frontVelAmps=amps;
rearVelAmps=amps;
for sp=1:numel(speeds)
    disp(['Running Sim @ ' num2str(speeds(sp)) ' m/s']);
    v_speed=speeds(sp);
    sim('halfmodel');
    simStatus=get_param('halfmodel','SimulationStatus');
    waitfor(simStatus,'Value','stopped');
    amps(sp)=sinStats(Displacements.Body_Displacement,5);
    velAmps(sp)=sinStats(Displacements.Body_Velocity,5);
    frontVelAmps(sp)=sinStats(Displacements.Front_Combined_Velocity,5);
    rearVelAmps(sp)=sinStats(Displacements.Rear_Combined_Velocity,5);
end
disp('Sims Complete');

f21=figure(21);
hold off;
plot(speeds,amps);
xlabel('Vehicle Speed (m/s)');
ylabel('Average Body Displacement Amplitude (m/s)');
title('Average Body Displacement Amplitude on the Sinousoidal Road at Different Speeds');
grid on;
set(f21,'Position',[150 150 800 550]);
saveas(f21,'graphs/sin/averageAmps.png');

f22=figure(22);
hold off;
plot(speeds,velAmps);
hold on;
plot(speeds,frontVelAmps);
plot(speeds,rearVelAmps);
xlabel('Vehicle Speed (m/s)');
ylabel('Average Body Velocity Amplitude (m)');
title('Average Body Velocity Amplitude on the Sinousoidal Road at Different Speeds');
legend('CoM','Front Point','Rear Point');
grid on;
set(f22,'Position',[150 150 800 550]);
saveas(f22,'graphs/sin/averageVelAmps.png');