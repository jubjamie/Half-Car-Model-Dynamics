% Run the sin case at different speeds
% Set speeds and profile type.
speeds=0.5:0.25:25;
set_param('halfmodel/Forcing Selector/Road Profile Control Signal','Value','2');

% Pre-allocate
amps=zeros(1,numel(speeds));
frontAmps=amps;
rearAmps=amps;
velAmps=amps;
frontVelAmps=amps;
rearVelAmps=amps;
pitchAmps=amps;

% Loop through speeds and sim. Record Data
for sp=1:numel(speeds)
    disp(['Running Sim @ ' num2str(speeds(sp)) ' m/s']);
    v_speed=speeds(sp);
    sim('halfmodel');
    simStatus=get_param('halfmodel','SimulationStatus');
    waitfor(simStatus,'Value','stopped');
    amps(sp)=sinStats(Displacements.Body_Displacement,5);
    frontAmps(sp)=sinStats(Displacements.Front_Combined_Displacements,5);
    rearAmps(sp)=sinStats(Displacements.Rear_Combined_Displacements,5);
    velAmps(sp)=sinStats(Displacements.Body_Velocity,5);
    frontVelAmps(sp)=sinStats(Displacements.Front_Combined_Velocity,5);
    rearVelAmps(sp)=sinStats(Displacements.Rear_Combined_Velocity,5);
    pitchAmps(sp)=sinStats(Pitch.Theta,5);
end
disp('Sims Complete');

% Plot displacement cyclic amplitudes
f21=figure(21);
hold off;
plot(speeds,amps);
hold on;
plot(speeds,frontAmps);
plot(speeds,rearAmps);
xlabel('Vehicle Speed (m/s)');
ylabel('Average Body Displacement Amplitude (m)');
title('Average Body Displacement Amplitude on the Sinousoidal Road at Different Speeds');
legend('CoM','Front','Rear');
grid on;
set(f21,'Position',[250 250 900 450]);
set(findall(gcf,'-property','FontSize'),'FontSize',14);
saveas(f21,'graphs/sin/averageAmps.png');

% Plot velocity cyclic amplitudes
f22=figure(22);
hold off;
plot(speeds,velAmps);
hold on;
plot(speeds,frontVelAmps);
plot(speeds,rearVelAmps);
xlabel('Vehicle Speed (m/s)');
ylabel('Average Body Velocity Amplitude (m/s)');
title('Average Body Velocity Amplitude on the Sinousoidal Road at Different Speeds');
legend('CoM','Front Point','Rear Point');
grid on;
set(f22,'Position',[250 250 900 450]);
set(findall(gcf,'-property','FontSize'),'FontSize',14);
saveas(f22,'graphs/sin/averageVelAmps.png');

% Plot pitch cyclic amplitudes
f23=figure(23);
hold off;
plot(speeds,pitchAmps);
xlabel('Vehicle Speed (m/s)');
ylabel('Average Body Pitching Amplitude (rad)');
title('Average Body Pitching Amplitude on the Sinousoidal Road at Different Speeds');
%legend('CoM','Front Point','Rear Point');
grid on;
set(f23,'Position',[250 250 900 450]);
set(findall(gcf,'-property','FontSize'),'FontSize',14);
saveas(f23,'graphs/sin/averagePitchAmps.png');