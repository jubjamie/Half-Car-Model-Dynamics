function [uniformProfile] = uniformData(ProfileData,fidelity)
%UNIFORMDATA Linear Interp data

%Create uniform timedata
timepoints=[0:1/fidelity:max(ProfileData.Time)];
pointcount=numel(timepoints);
uniformProfile=zeros(1,pointcount);

% Loop through data and interp

for i=1:pointcount
    timestamp=timepoints(i);
    %Find value at front suspension (i.e. at timestep)
    rightIndex=find(ProfileData.Time>=timestamp,1,'first');
    rightValue=ProfileData.Data(rightIndex);
    rightTime=ProfileData.Time(rightIndex);
    if rightIndex>1
        leftValue=ProfileData.Data(rightIndex-1);
        leftTime=ProfileData.Time(rightIndex-1);
        uniformProfile(i)=leftValue+(((timestamp-leftTime)/...
            (rightTime-leftTime))*(rightValue-leftValue));
    else
        uniformProfile(i)=ProfileData.Data(1);
    end
    
end

end

