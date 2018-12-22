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
thetas=uniformData(Pitch.Theta,fidelity);

%loop to make frames
frames=0;
frames=struct('cdata', cell(1,numel(bodyDisplacements)), 'colormap', cell(1,numel(bodyDisplacements)));
%progressbar('Making Frames');
disp('Making Frames');
parfor i=1:numel(bodyDisplacements)
   %progressbar(i/numel(bodyDisplacements));
   f1=figure('Position',[0 0 1280 720],'visible','off');
   %Car profile
   carVector=[backDisplacements(i),bodyDisplacements(i),frontDisplacements(i)];
   carVector=carVector+1;
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
   hold off;
   frames(i)=getframe(f1);
end
disp('Frames Mode');
playbackFigure=figure('Position',[0 0 1280 720]);
movie(playbackFigure, frames,3,fidelity);