% Make graphs for report - Half Body
%Get filename bits
fext=input('What filename extension should be used? >> ','s');

% Car Displacement Replica
f11=figure(11);
plot(Displacements.Body_Displacement.Time,...
    Displacements.Body_Displacement.Data,'b-','LineWidth',1.2);

set(f11,'Position',[250 250 900 450]);
hold off;
grid on;

xlabel('Time (s)');
ylabel('Displacement (m)');
title('Half Car Body Vertical Displacement');
set(findall(gcf,'-property','FontSize'),'FontSize',14);
saveas(f11,['graphs/verification/bodyDisplacement_' fext '.png']);

% Car Velocity
f12=figure(12);
plot(Displacements.Body_Velocity.Time,Displacements.Body_Velocity.Data,'r-',...
    'LineWidth',1.2);

set(f12,'Position',[250 250 900 450]);
hold off;
grid on;

xlabel('Time (s)');
ylabel('Velocity (m/s)');
title('Half Car Body Vertical Velocity');
set(findall(gcf,'-property','FontSize'),'FontSize',14);
saveas(f12,['graphs/verification/bodyVelocity_' fext '.png']);

% Car Pitch
f15=figure(15);
plot(Pitch.Theta.Time,Pitch.Theta.Data,'b-','LineWidth',1.2);

set(f15,'Position',[250 250 900 450]);
hold off;
grid on;

xlabel('Time (s)');
ylabel('Pitch (rad)');
title('Half Car Body Pitch');
set(findall(gcf,'-property','FontSize'),'FontSize',14);
saveas(f15,['graphs/verification/bodyPitch_' fext '.png']);

% Angular Velocity
f16=figure(16);
plot(Pitch.Theta_dot.Time,Pitch.Theta_dot.Data,'r-','LineWidth',1.2);

set(f16,'Position',[250 250 900 450]);
hold off;
grid on;

xlabel('Time (s)');
ylabel('Angular Velocity (rad/s)');
title('Half Car Body Angular Velocity');
set(findall(gcf,'-property','FontSize'),'FontSize',14);
saveas(f16,['graphs/verification/bodyPitchVelocity_' fext '.png']);

% Wheel Displacements
f13=figure(13);
plot(Wheels_Data.Front_Wheel_Displacement.Time,...
    Wheels_Data.Front_Wheel_Displacement.Data,'b-','LineWidth',1.2);
hold on;
plot(Wheels_Data.Rear_Wheel_Displacement.Time,...
    Wheels_Data.Rear_Wheel_Displacement.Data,'b--','LineWidth',1);

set(f13,'Position',[250 250 900 450]);
hold off;
grid on;
legend('Front Wheel','Rear Wheel');
xlabel('Time (s)');
ylabel('Displacement (m)');
title('Half Car Wheels Vertical Displacements');
set(findall(gcf,'-property','FontSize'),'FontSize',14);
saveas(f13,['graphs/verification/wheelDisplacement_' fext '.png']);

% Wheel Velocity
f14=figure(14);
plot(Wheels_Data.Front_Wheel_Velocity.Time,...
    Wheels_Data.Front_Wheel_Velocity.Data,'r-','LineWidth',1.2);
hold on;
plot(Wheels_Data.Rear_Wheel_Velocity.Time,...
    Wheels_Data.Rear_Wheel_Velocity.Data,'r--','LineWidth',1);

set(f14,'Position',[250 250 900 450]);
hold off;
grid on;
legend('Front Wheel','Rear Wheel');
xlabel('Time (s)');
ylabel('Velocity (m/s)');
title('Half Car Wheels Vertical Velocities');
set(findall(gcf,'-property','FontSize'),'FontSize',14);
saveas(f14,['graphs/verification/wheelVelocity_' fext '.png']);