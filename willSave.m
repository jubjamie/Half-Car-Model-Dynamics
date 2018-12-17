answer = questdlg('Save Workspace?', ...
	'Save Variables in Workspace to file?', ...
	'Yes','No','Yes');
% Handle response
switch answer
    case 'Yes'
        prompt = {'Filename'};
        title = 'Save Workspace';
        dims = [1 35];
        definput = {'baseVehicleData'};
        saveName = inputdlg(prompt,title,dims,definput);
        save(saveName{1});
    case 'No'
        disp('Not saving Workspace Variables')
        dessert = 2;
end