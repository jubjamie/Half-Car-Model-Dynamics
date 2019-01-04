% Make graphs for report - Half Body
%Get filename bits
fext=input('What filename extension should be used? >> ','s');

%% Car Displacement Replica
f11=figure(11);
plot(Body_Displacement.Time,Body_Displacement.Data,'b-','LineWidth',1.2);

set(f11,'Position',[250 250 900 450]);
hold off;
grid on;

xlabel('Time (s)');
ylabel('Displacement (m)');
title('Quarter Car Body Vertical Displacement');
set(findall(gcf,'-property','FontSize'),'FontSize',14);
saveas(f11,['graphs/verification/bodyDisplacement_' fext '.png']);

%% Car Velocity
f12=figure(12);
plot(Velocity.Time,Velocity.Data,'r-','LineWidth',1.2);

set(f12,'Position',[250 250 900 450]);
hold off;
grid on;

xlabel('Time (s)');
ylabel('Velocity (m/s)');
title('Quarter Car Body Vertical Velocity');
set(findall(gcf,'-property','FontSize'),'FontSize',14);
saveas(f12,['graphs/verification/bodyVelocity_' fext '.png']);

%% Wheel Displacements
f13=figure(13);
plot(Wheel_Displacement.Time,Wheel_Displacement.Data,'b-','LineWidth',1.2);

set(f13,'Position',[250 250 900 450]);
hold off;
grid on;

xlabel('Time (s)');
ylabel('Displacement (m)');
title('Quarter Car Wheel Vertical Displacement');
set(findall(gcf,'-property','FontSize'),'FontSize',14);
saveas(f13,['graphs/verification/wheelDisplacement_' fext '.png']);

%% Wheel Velocity
f14=figure(14);
plot(Wheel_Velocity.Time,Wheel_Velocity.Data,'r-','LineWidth',1.2);

set(f14,'Position',[250 250 900 450]);
hold off;
grid on;

xlabel('Time (s)');
ylabel('Velocity (m/s)');
title('Quarter Car Wheel Vertical Velocity');
set(findall(gcf,'-property','FontSize'),'FontSize',14);
saveas(f14,['graphs/verification/wheelVelocity_' fext '.png']);