%% Only for TADPAD solution
clear; clc;

basepath=pwd;
% see calling conventions
chanlist=[3:8];
myoptions='-r'; % always used in the full run
% (see documentation for tapadm)

% firstpath='ampsfilt';
% should be correct ???
% Or is this changed for the velocity
% repaired version?? Think again
% firstpath='ampsfiltadj1';
% % first full version
% % outpath=[firstpath pathchar 'recursedsl' pathchar 'rawpos']
% outpath=[firstpath pathchar 'recursevelrep1' pathchar 'rawpos']
% 
% % start pos taken from the DOWNSAMPLED versions of the data
% % startpath=[basepath, pathchar, 'ampsfiltdsadj1', pathchar, 'beststartl', pathchar, 'rawpos']
% startpath=[basepath, pathchar, 'ampsfiltadj1', pathchar, 'velrep', pathchar, 'rawpos']

% Commented out
% second full version (for comparison with smoothed full version)
% outpath=[firstpath pathchar 'recursevelrepl' pathchar 'rawpos']
% startpath=[basepath pathchar 'ampsfiltadja', pathchar, ...
% 'velrep' pathchar 'rawpos']
mkdir([outpath pathchar 'posamps']);
stats=tapad_ph_rs(basepath,[firstpath pathchar 'amps'], outpath,triallist,chanlist,myoptions,startpath);