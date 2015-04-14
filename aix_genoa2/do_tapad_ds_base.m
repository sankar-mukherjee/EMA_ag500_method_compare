%do_tapad_ds
%run tapad with downsampled data

basepath=pwd;
%subdirectory where amps are stored, and where the calculated positions
%will be stored.
%Setting will normally be 'ampsfiltds'
% firstpath='ampsfiltds';

outpath=[firstpath pathchar 'beststartl' pathchar 'rawpos'];
mkdir([outpath pathchar 'posamps']);
%just for reference, include a comment line here with the names of the
%sensors

%Normal list of channels to process is 1:12, but eliminate any channels
%from the list that are not in use (or unusable)
chanlist=[1:12];

%Leave startfile empty to run without start positions. Otherwise insert the
%name of the mat file containing the start positions to use

%set up for variables names used by showstats, mode 7
	if ~isempty(startfile)
	startpos=mymatin(startfile,'data');
	startcomment=mymatin(startfile,'comment');
	disp('Comment with start positions');
	disp(startcomment);
end;

% triallist=[7:14 16:23 25:31 33 35:37];	%list of trials to process
	%list of trials to process

%This switch chooses the Levenberg-Marquardt version of the nonlinear
%optimization procedure. Currently no other options are useful.
myoptions='';


if exist('startpos','var')
	outstats=tapad_ph_rs(basepath,[firstpath pathchar 'amps'],outpath,triallist,chanlist,myoptions,startpos);

else
	outstats=tapad_ph_rs(basepath,[firstpath pathchar 'amps'],outpath,triallist,chanlist,myoptions);
end;

%This stores a small mat file with a few statistics on each trial.
%Currently for maintenance purposes only
%Uncomment if required
%save(['tapaddsstats_' firstpath '_' int2str(triallist(1)) '_' int2str(triallist(end))],'outstats');

