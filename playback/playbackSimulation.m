% Main script to create plot for simulation using matlab getframe and movie
fidelity=25;
%Each section below creates a different part of the plot.

%Create time uniform road profile
roadProfile=uniformData(Forcing,fidelity);

%Create time uniform displacements
bodyDisplacements=uniformData(Displacements.Body_Displacement,fidelity);
frontDisplacements=uniformData(Displacements.Front_Offset,fidelity)+bodyDisplacements;
backDisplacements=uniformData(Displacements.Back_Offset,fidelity)+bodyDisplacements;

%loop to make frames
frames=struct('cdata', cell(1,numel(roadProfile)), 'colormap', cell(1,numel(roadProfile)));
progressbar('Making Frames');
for i=1:numel(roadProfile)
    progressbar(i/numel(roadProfile));
   f1=figure('Position',[0 0 1920 1080],'visible','off');
   %Car profile
   carVector=[backDisplacements(i),bodyDisplacements(i),frontDisplacements(i)];
   carVector=carVector+1;
   carPositions=[-b,0,a];
   %Plot car
   plot(carPositions,carVector);
   xlim([-b-3, a+3]);
   ylim([0,2]);
   frames(i)=getframe(f1);
end

figure(2);
movie(gcf, frames,3,fidelity);