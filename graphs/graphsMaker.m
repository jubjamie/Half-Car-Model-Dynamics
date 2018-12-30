% Make graphs for report - Half Body

%% Car Displacement Replica
clf(11);
f11=figure(11);
plot(Displacements.Body_Displacement.Time,Displacements.Body_Displacement.Data,'k-');
hold on;
plot(Displacements.Front_Offset.Time,Displacements.Front_Offset.Data+Displacements.Body_Displacement.Data,'r-');
plot(Displacements.Back_Offset.Time,Displacements.Back_Offset.Data+Displacements.Body_Displacement.Data,'b-');

% Overlay relative road profile forcing
wheelSettle=-((m1+m2)*g)/kT;
bodySettle=(-m1*g/ks)+wheelSettle;

plot(Forcing.Time,Forcing.Data+bodySettle,'g--');
set(f11,'Position',[250 250 900 450]);
hold off;
grid on;
legend('CoM Displacement','Front Point Displacement','Rear Point Displacement');
xlabel('Time (s)');
ylabel('Displacement (m)');
title('Car Point Displacements with Overlaid Relative Forcing');