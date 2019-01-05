% Make graphs for report - Half Body
%Get settings
roadProfilesList={'Step','Sine Road','Zero','Pulses','Humpback','Random'};
roadProfileType=string(roadProfilesList{str2num(get_param('halfmodel/Forcing Selector/Road Profile Control Signal','Value'))});
disp(roadProfileType);
ForcingDataFix=reshape(Forcing.Data(1,1,:),numel(Forcing.Time),1);

%% Car Displacement Replica
f11=figure(11);
plot(Displacements.Body_Displacement.Time,Displacements.Body_Displacement.Data,'k-','LineWidth',1.2);
hold on;
plot(Displacements.Front_Offset.Time,Displacements.Front_Offset.Data+Displacements.Body_Displacement.Data,'r-');
plot(Displacements.Back_Offset.Time,Displacements.Back_Offset.Data+Displacements.Body_Displacement.Data,'b-');


plot(Forcing.Time,ForcingDataFix+bodySettle,'g--');
set(f11,'Position',[250 250 900 450]);
hold off;
grid on;
legend('CoM Displacement','Front Point Displacement','Rear Point Displacement','Relative Road Forcing Input');
legend('Location','Southeast');

delete(findall(gcf,'type','annotation'));
dim = [0.3464,0.138622,0.22611,0.1288];
str = ['Road Profile: ' + roadProfileType + newline + 'Vehicle Speed: ' + num2str(v_speed) + ' m/s'];
annotation('textbox',dim,'String',str,'FitBoxToText','on');

xlabel('Time (s)');
ylabel('Displacement (m)');
title(['Car Point Displacements with Overlaid Relative Forcing - Road Profile: ' + roadProfileType]);
set(findall(gcf,'-property','FontSize'),'FontSize',14);
saveas(f11,['graphs/overview/carDisplacementMulti_' + roadProfileType + '_' + v_speed + '.png']);

%% Wheel Displacements
f12=figure(12);
plot(Wheels_Data.Front_Wheel_Displacement.Time,Wheels_Data.Front_Wheel_Displacement.Data,'r-');
hold on;
plot(Wheels_Data.Rear_Wheel_Displacement.Time,Wheels_Data.Rear_Wheel_Displacement.Data,'b-');

set(f12,'Position',[250 250 900 450]);
hold off;
grid on;
legend('Front Wheel Displacement','Rear Wheel Displacement');
legend('Location','Southeast');

delete(findall(gcf,'type','annotation'));
dim = [0.360888888888889,0.136400003178914,0.226111104703612,0.128888885709975];
annotation('textbox',dim,'String',str,'FitBoxToText','on');

xlabel('Time (s)');
ylabel('Displacement (m)');
title(['Wheel Displacements - Road Profile: ' + roadProfileType]);
set(findall(gcf,'-property','FontSize'),'FontSize',14);
saveas(f12,['graphs/overview/wheelDisplacementMulti_' + roadProfileType + '_' + v_speed + '.png']);