function [distanceVector,roadProfile] = getRoadProfile(roadProfile,timeStep,fidelity,v_speed,trailingDistance,upcomingDistance)
%GETROADPROFILE Summary of this function goes here
%   Detailed explanation goes here

trailingTime=trailingDistance/v_speed;
upcomingTime=upcomingDistance/v_speed;
trailingDataSteps=trailingTime*fidelity;
upcomingDataSteps=upcomingTime*fidelity;

%Create distance vector
%Total time to cover
totalSteps=trailingDataSteps+upcomingDataSteps;
totalDistance=trailingDistance++upcomingDistance;
distanceVector=linspace(0,totalDistance,totalSteps);


end

