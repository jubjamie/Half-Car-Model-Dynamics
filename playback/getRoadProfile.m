function [roadProfile] = getRoadProfile(ProfileData)
%GETROADPROFILE Summary of this function goes here
%   Detailed explanation goes here

%Create uniform road profile.
%Create uniform timedata
timepoints=[0:1/100:max(ProfileData.Time)];
pointcount=numel(timepoints);
roadProfile=zeros(1,pointcount);

parfor i=1:pointcount
    timestamp=timepoints(i);
    %Find value at front suspension (i.e. at timestep)
    rightIndex=find(ProfileData.Time>=timestamp,1,'first');
    rightValue=ProfileData.Data(rightIndex);
    rightTime=ProfileData.Time(rightIndex);
    if rightIndex>1
        leftValue=ProfileData.Data(rightIndex-1);
        leftTime=ProfileData.Time(rightIndex-1);
    else
        leftValue=0;
        leftTime=0;
    end
    roadProfile(i)=leftValue+(((timestamp-leftTime)/(rightTime-leftTime))*(rightValue-leftValue));
end

plot(timepoints,roadProfile);
end

