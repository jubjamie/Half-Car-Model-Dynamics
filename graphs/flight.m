% Plot graphs for wheel flight
roadProfilesList={'Step','Sine Road','Zero','Pulses','Humpback','Random'};
roadProfileType=string(roadProfilesList{str2num(get_param('halfmodel/Forcing Selector/Road Profile Control Signal','Value'))});
disp(roadProfileType);

%Graph 1
f40=figure(40);
plot(FlightDetect.Both_Wheels.Time,FlightDetect.Both_Wheels.Data,'k-','LineWidth',1.5);
hold on;
plot(FlightDetect.Ind_Wheel_Bus.Front_Flight_Value.Time,FlightDetect.Ind_Wheel_Bus.Front_Flight_Value.Data,'r--');
plot(FlightDetect.Ind_Wheel_Bus.Rear_Flight_Value.Time,FlightDetect.Ind_Wheel_Bus.Rear_Flight_Value.Data,'b--');

set(f40,'Position',[250 250 900 450]);
hold off;
grid on;
legend('Half Car Flight','Front Wheel Flight','Rear Wheel Flight');
legend('Location','Northwest');
ylim([0,2]);

delete(findall(gcf,'type','annotation'));
dim = [0.315333333333333,0.803066668918403,0.185555550356706,0.097777775526047];
str = ['Road Profile: ' + roadProfileType + newline + 'Vehicle Speed: ' + num2str(v_speed) + ' m/s'];
annotation('textbox',dim,'String',str,'FitBoxToText','on');

xlabel('Time (s)');
ylabel('Displacement (m)');
title(['Car/Wheel Flight Periods - Road Profile: ' + roadProfileType]);
saveas(f11,['graphs/flight/flightCombined_' + roadProfileType + '_' + v_speed + '.png']);