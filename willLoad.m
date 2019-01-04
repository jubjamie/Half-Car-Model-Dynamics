answer = questdlg('Load Workspace?', ...
	'Save Variables in Workspace to file?', ...
	'Yes','No','Yes');
% Handle response
switch answer
    case 'Yes'
        prompt = {'Filename'};
        Ptitle = 'Load Workspace';
        dims = [1 35];
        definput = {'baseVehicleData'};
        loadName = inputdlg(prompt,Ptitle,dims,definput);
        load(loadName{1});
    case 'No'
        disp('Not saving Workspace Variables');
end