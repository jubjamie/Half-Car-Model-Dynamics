% Run the humpback case at different speeds
% Set speeds and profile type.
speeds=horzcat(0.5:0.5:7.5,8:0.2:18);
set_param('halfmodel/Forcing Selector/Road Profile Control Signal','Value','5');

% Pre-allocate
flightTimes=zeros(1,numel(speeds));
didFlys=zeros(1,numel(speeds));

% Run a sim at each speed and calculate flight times
for sp=1:numel(speeds)
    disp(['Running Sim @ ' num2str(speeds(sp)) ' m/s']);
    v_speed=speeds(sp);
    sim('halfmodel');
    simStatus=get_param('halfmodel','SimulationStatus');
    waitfor(simStatus,'Value','stopped');
    flightTimes(sp)=flightTime(FlightDetect.Both_Wheels);
    didFlys(sp)=max(FlightDetect.DidFly.Data);
end
disp('Sims Complete');

% Plot
f45=figure(45);
hold off;
plot(speeds,flightTimes);
xlabel('Vehicle Speed (m/s)');
ylabel('Half Car Flight Time (s)');
title('Car Flight Time over the Humpback Road at Different Speeds');
grid on;
set(f45,'Position',[150 150 800 550]);
set(findall(gcf,'-property','FontSize'),'FontSize',14);
saveas(f45,'graphs/humpback/flightTimes.png');