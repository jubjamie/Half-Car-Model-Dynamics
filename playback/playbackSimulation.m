% Main script to create plot for simulation using matlab getframe and movie
fidelity=20;
%Each section below creates a different part of the plot.

%Create time uniform road profile
roadProfile=uniformData(Forcing,fidelity);
visRoad=6+a+b;
trailingDistance=b+(visRoad/2);
upcomingDistance=a+(visRoad/2);
trailingTime=trailingDistance/v_speed;
upcomingTime=upcomingDistance/v_speed;
trailingDataSteps=ceil(trailingTime*fidelity);
upcomingDataSteps=ceil(upcomingTime*fidelity);
%Create distance vector
%Total time to cover
totalSteps=trailingDataSteps+upcomingDataSteps;
totalDistance=trailingDistance+upcomingDistance;
distanceVector=linspace(-trailingDistance,upcomingDistance,totalSteps);
roadProfile=padarray(roadProfile,[0,trailingDataSteps],'pre');
roadProfile=padarray(roadProfile,[0,upcomingDataSteps],'post');

%Create time uniform displacements
bodyDisplacements=uniformData(Displacements.Body_Displacement,fidelity);
frontDisplacements=uniformData(Displacements.Front_Offset,fidelity)+bodyDisplacements;
backDisplacements=uniformData(Displacements.Back_Offset,fidelity)+bodyDisplacements;

%Wheel Bits
wheelRadius=0.07;
backWheelDisplacements=uniformData(Wheels_Data.Rear_Wheel_Displacement,fidelity)+wheelRadius+0.01;
frontWheelDisplacements=uniformData(Wheels_Data.Front_Wheel_Displacement,fidelity)+wheelRadius+0.01;

%Other
thetas=uniformData(Pitch.Theta,fidelity);

%loop to make frames
disp('Creating Video File');
v=VideoWriter('playback.avi');
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
   xlim([-trailingDistance, upcomingDistance]);
   ylim([0,2]);
   hold on;
   %Plot Car body
   [cardetailX, cardetailY]=makeCarBody(carPositions,carVector,thetas(i),totalDistance);
   plot(cardetailX,cardetailY,'b-');
   %Plot road profile
   plot(distanceVector,roadProfile(i:i+totalSteps-1),'r-');
   % Plot Wheels
   %Front
   ellipse(wheelRadius*totalDistance/2,wheelRadius,0,carPositions(3),frontWheelDisplacements(i),'b');
   %Rear
   ellipse(wheelRadius*totalDistance/2,wheelRadius,0,carPositions(1),backWheelDisplacements(i),'b');
   hold off;
   writeVideo(v,getframe(f1));
end
close(v);
disp('Frames Made');
progressbar(1);
%{
playbackFigure=figure('Position',[0 0 1280 720]);
movie(playbackFigure, frames,3,fidelity);
%}