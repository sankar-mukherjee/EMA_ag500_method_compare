%do_do_comppos
%wrapper script to call two different display functions for EMA data:
%1) do_comppos_a_f
%   typical use: get statistics to set up amplitude adjustment
%2) show_trialox
%       this is the display function also used while the experiment is running
%       Use in conjunction with showstats to store start positions
%
%Use the doshowtrial flag to swap between these two functions



%1: show_trialox; 0: do_comppos_a_f

%main path to the position data
% basepath=['ampsfilt' pathchar 'kalmanns' pathchar 'rawposm' pathchar];


%Additional path only used by the do_comppos_a_f branch.
%Allows different processing of the same set of data to be compared.
%Uncomment and set appropriately, if required.
% altpath=['ampsfilt' pathchar 'kalmanus' pathchar 'rawposm' pathchar];


if ~exist('altpath','var') altpath=''; end;


%list of trials to display
restlist=[];     %list of trials to skip

triallist=setdiff(triallist,restlist);


%for reference, put a list of sensor names as a comment here
kanallist=[3:8]; %channels to be displayed

if ~doshowtrial

    %Comparison sensor: Sensor to show in combination with the other sensors
    %Euclidean distance between this sensor and the other sensors will be
    %displayed. Uncomment if required.
    %     compsensor=3;
    if ~exist('compsensor','var') compsensor=[]; end;

    %   autoflag: must be 0, 1 or 2
    %   0: display pauses after every trial
    %   1: display is done for all trials of one sensor, then pauses
    %   2: No pauses. Convenient in combination with a diary file for running
    %   the script unattended. The graphics are stored and can be looked at
    %   later.
    autoflag=2;

    %default settings for name of diary file (and fig files)
    diaryname=['comppos_stats_' basepath];
    if ~isempty(compsensor) diaryname=[diaryname '_comp' int2str(compsensor)]; end;
    if ~isempty(altpath) diaryname=[diaryname '_alt_' altpath]; end;
    diaryname=[diaryname '.txt'];
    diaryname=strrep(diaryname,pathchar,'_');
    diaryname=strrep(diaryname,'ampsfilt','');
    diaryname=strrep(diaryname,'rawpos','');
    diaryname=strrep(diaryname,'__','_');
    %If a diary file is defined, various statistics are stored in it (on rms,
    %tangential velocity, euclidean distance). These can be used to set up the
    %amplitude adjustment. In addition all the graphics are stored in
    %subdirectory 'figs/'.
    %Uncomment if required. Change name if desired
    diaryfile=diaryname;

    if ~exist('diaryfile','var') diaryfile=''; end;


    do_comppos_a_f(basepath,altpath,triallist,kanallist,compsensor,autoflag,diaryfile);

else
    hf=[];
    [statxb,sstatsdb,nancntb,hf]=show_trialox(basepath,triallist(1),kanallist,hf);
    plotstep=1;
    disp('Arrange figures. Adjust plotstep if desired');
    disp('Set plotstep to a large value to speed up display');
    disp('if you are mainly interested in the overview of all trials,');
    disp('and not in the display of individual trials');
    disp('');
    disp('Type ''return'' when ready to continue');


    keyboard;
    [statxb,statsdb,nancntb,hf]=show_trialox(basepath,triallist(2:end),kanallist,hf,plotstep);

end;
