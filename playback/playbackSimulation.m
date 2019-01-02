% Main script to create plot for simulation using matlab getframe and movie
fidelity=25;

%Each section below creates a different part of the plot.

%Create time uniform road profile
roadProfile=uniformData(Forcing,fidelity);
trailingDistance=a+b+3;
upcomingDistance=3;
trailingTime=trailingDistance/v_speed;
upcomingTime=upcomingDistance/v_speed;
trailingDataSteps=ceil(trailingTime*fidelity);
upcomingDataSteps=ceil(upcomingTime*fidelity);
%Create distance vector
%Total time to cover
totalSteps=trailingDataSteps+upcomingDataSteps;
totalDistance=trailingDistance+upcomingDistance;
distanceVector=linspace(-trailingDistance+a, upcomingDistance+a,totalSteps);
roadProfile=padarray(roadProfile,[0,trailingDataSteps],'pre');
roadProfile=padarray(roadProfile,[0,upcomingDataSteps],'post');

%Create time uniform displacements
bodyDisplacements=uniformData(Displacements.Body_Displacement,fidelity);
frontDisplacements=uniformData(Displacements.Front_Offset,fidelity)+bodyDisplacements;
backDisplacements=uniformData(Displacements.Back_Offset,fidelity)+bodyDisplacements;

%Wheel Bits
% Wheel Data Offsets as wheels don't act at same timestep as centre does.
backWheelDataSteps=floor(fidelity*(a+b)/v_speed);
frontWheelDataSteps=0;

wheelRadius=0.06;
backWheelDisplacements=uniformData(Wheels_Data.Rear_Wheel_Displacement,fidelity)+wheelRadius;
%backWheelDisplacements=padarray(backWheelDisplacements,[0, backWheelDataSteps],'pre');
frontWheelDisplacements=uniformData(Wheels_Data.Front_Wheel_Displacement,fidelity)+wheelRadius;

wheelSettle=-((m1+m2)*g)/kT;

%Other
thetas=uniformData(Pitch.Theta,fidelity);
bodyCenterDataSteps=floor(fidelity*a/v_speed);
bodySettle=(-m1*g/ks)+wheelSettle;

%loop to make frames
aspectX=720*totalDistance/(3*1280);
disp('Creating Video File');
v=VideoWriter('playback.avi');
v.FrameRate=fidelity;
open(v);
progressbar('Making Frames');
disp('Making Frames');
for i=1:numel(bodyDisplacements)
   progressbar(i/numel(bodyDisplacements));
   f1=figure('Position',[0 0 1280 720],'visible','off');
   
   %Car profile
   carVector=[backDisplacements(i),bodyDisplacements(i),frontDisplacements(i)];
   carVector=carVector+0.3;
   carPositions=[-b,0,a];
   %Plot car base
   plot(carPositions,carVector);
   xlim([-trailingDistance+a, upcomingDistance+a]);
   ylim([-2.5,0.5]);
   hold on;
   %Plot Car body
   [cardetailX, cardetailY]=makeCarBody(carPositions,carVector,thetas(i),totalDistance);
   plot(cardetailX,cardetailY,'b-');
   
   %Plot road profile
   plot(distanceVector,roadProfile(i:i+totalSteps-1),'r-','LineWidth',2); %CHECK THIS
   
   % Plot Wheels
   %Front
   ellipse(wheelRadius*aspectX,wheelRadius,0,carPositions(3),frontWheelDisplacements(i)-wheelSettle,'b');
   hline(frontWheelDisplacements(i)-wheelRadius);
   if i>trailingDataSteps && i<(numel(bodyDisplacements)-upcomingDataSteps-backWheelDataSteps)
      plot(distanceVector,frontWheelDisplacements(i-trailingDataSteps:i+upcomingDataSteps-1)-wheelSettle);
      plot(distanceVector,backWheelDisplacements(i-trailingDataSteps+backWheelDataSteps:i+upcomingDataSteps+backWheelDataSteps-1)-wheelSettle);
      plot(distanceVector,bodyDisplacements(i-trailingDataSteps+bodyCenterDataSteps:i+upcomingDataSteps+bodyCenterDataSteps-1)+0.3);
   end
   %Rear
   ellipse(wheelRadius*aspectX,wheelRadius,0,carPositions(1),backWheelDisplacements(i)-wheelSettle,'b');
   
   %Other text bits
   txt = ['Time: ' num2str(i/fidelity) 's'];
   text(a,1.5,txt)
   
   hold off;
   
   %Add to file
   writeVideo(v,getframe(f1));
end
close(v);
disp('Frames Made');
progressbar(1);
beep; pause(0.2); beep; pause(0.2); beep;
%{
playbackFigure=figure('Position',[0 0 1280 720]);
movie(playbackFigure, frames,3,fidelity);
%}