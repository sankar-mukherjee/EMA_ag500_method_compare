
clear;clc;

solution_path = 'ampsfiltdsadj1/beststartl';

triallist=[4:7];

files = dir([solution_path  '/rawpos/*.mat']);
for i=1:length(files)
    name = str2num(strrep(files(i).name,'.mat',''));
    f = sum(ismember(triallist,name));
    if(f)
        path = [solution_path  '/rawpos/' files(i).name];
        load(path);
        name = str2num(strrep(files(i).name,'.mat',''));
        dlmwrite(['data/' num2str(name) '.txt'],data,'delimiter',',');
    end
end
