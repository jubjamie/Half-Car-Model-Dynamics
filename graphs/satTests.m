%% Car Displacement Replica
f30=figure(30);
plot(satFront.time,satFront.signals.values,'b-','LineWidth',1);
hold on;
plot(satRear.time,satRear.signals.values,'r--','LineWidth',1);
set(f30,'Position',[250 250 900 450]);
hold off;
grid on;
%ylim([-1,1]);
xlabel('Time (s)');
ylabel('Tyre Force (N)');
legend('Front Wheel','Rear Wheel');
legend('Location','Northeast');
title('Tyre Force Post Saturation Block');
set(findall(gcf,'-property','FontSize'),'FontSize',14);
delete(findall(gcf,'type','annotation'));
saveas(f30,['graphs/verification/tyreSaturation.png']);