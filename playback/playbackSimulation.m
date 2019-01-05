% Main script to create plot for simulation using matlab getframe and movie
fidelity=30;

%Each section below creates a different part of the plot.

%Create time uniform road profile
roadProfile=uniformData(Forcing,fidelity);
% Set physical domain space
trailingDistance=a+b+3;
upcomingDistance=3;
% Relate distances to data steps
trailingTime=trailingDistance/v_speed;
upcomingTime=upcomingDistance/v_speed;
trailingDataSteps=ceil(trailingTime*fidelity);
upcomingDataSteps=ceil(upcomingTime*fidelity);

%Create distance vector
%Total time to cover
totalSteps=trailingDataSteps+upcomingDataSteps;
totalDistance=trailingDistance+upcomingDistance;
distanceVector=linspace(-trailingDistance+a, upcomingDistance+a,totalSteps);
% Pad road profile array to give data for unsimulated time.
roadProfile=padarray(roadProfile,[0,trailingDataSteps],'pre');
roadProfile=padarray(roadProfile,[0,upcomingDataSteps],'post');

%Create time uniform displacements
bodyDisplacements=uniformData(Displacements.Body_Displacement,fidelity);
frontDisplacements=uniformData(Displacements.Front_Offset,fidelity)+...
                    bodyDisplacements;
backDisplacements=uniformData(Displacements.Back_Offset,fidelity)+...
                    bodyDisplacements;

%Wheel Bits
% Wheel Data Offsets as wheels don't act at same timestep as centre does.
backWheelDataSteps=floor(fidelity*(a+b)/v_speed);
frontWheelDataSteps=0;

% Set wheel geomtery and data
wheelRadius=0.06;
backWheelDisplacements=uniformData(Wheels_Data.Rear_Wheel_Displacement,...
                        fidelity)+wheelRadius;
frontWheelDisplacements=uniformData(Wheels_Data.Front_Wheel_Displacement,...
                        fidelity)+wheelRadius;

%Other
thetas=uniformData(Pitch.Theta,fidelity);
bodyCenterDataSteps=floor(fidelity*a/v_speed);

% Dynamically set axes height for scenarios outside normal scope.
ylimits=[min(min(roadProfile),0),max(max(bodyDisplacements)+0.5,3)];

% Calculate the aspect ratio skew for drawing
aspectX=720*totalDistance/((ylimits(2)-ylimits(1))*1280);

% Set up VideoWriter
disp('Creating Video File');
v=VideoWriter('playback.avi');
v.FrameRate=fidelity;
open(v);
progressbar('Making Frames');
disp('Making Frames');

% Loop through frames
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
   ylim(ylimits);
   hold on;
   %Plot Car body
   [cardetailX, cardetailY]=makeCarBody(carPositions,carVector,thetas(i),aspectX);
   plot(cardetailX,cardetailY,'b-');
   
   %Plot road profile
   plot(distanceVector,roadProfile(i:i+totalSteps-1),'r-','LineWidth',2);
   
   % Plot Wheels
   %Front
   ellipse(wheelRadius*aspectX,wheelRadius,0,carPositions(3),...
            frontWheelDisplacements(i)-wheelSettle,'b');
   hline(frontWheelDisplacements(i)-wheelRadius);
   
   %Rear
   ellipse(wheelRadius*aspectX,wheelRadius,0,carPositions(1),...
       backWheelDisplacements(i)-wheelSettle,'b');
   
   % Plot data trails when available 
   if i>trailingDataSteps && i<(numel(bodyDisplacements)-upcomingDataSteps...
                                                        -backWheelDataSteps)
      plot(distanceVector,frontWheelDisplacements(i-trailingDataSteps:i+...
                                        upcomingDataSteps-1)-wheelSettle);
      plot(distanceVector,backWheelDisplacements(i-trailingDataSteps+...
          backWheelDataSteps:i+upcomingDataSteps+backWheelDataSteps-1)-...
          wheelSettle);
      plot(distanceVector,bodyDisplacements(i-trailingDataSteps+...
          bodyCenterDataSteps:i+upcomingDataSteps+bodyCenterDataSteps-1)+0.3);
   end
      
   %Other text bits
   txt = ['Time: ' num2str(i/fidelity) 's'];
   text(3,ylimits(2)-0.5,txt)
   
   hold off;
   
   %Add to file
   writeVideo(v,getframe(f1));
end
close(v);
disp('Frames Made');
% Clean up
progressbar(1);
clear f1 v; % Remove containers from workspaces
% Beep to alert user video has been created.
beep; pause(0.2); beep; pause(0.2); beep;