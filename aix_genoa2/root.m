clear; clc; close all;
%%
firstpath='ampsfiltds';
startfile='';
triallist=[4:7];

do_tapad_ds_base
clearvars -except triallist
%%
doshowtrial=1;
basepath=['ampsfiltds' pathchar 'beststartl' pathchar 'rawpos' pathchar];
% altpath=['ampsfiltadj1' pathchar 'recursevelrep1' pathchar 'rawpos' pathchar];

do_do_comppos_base
%%
start_position = showstats(7);
%save('start_position/start_pos.mat', 'start_position');
close all;
clearvars -except triallist
%%
startfile='start_pos.mat';
firstpath='ampsfiltds';
triallist=[4:7];
do_tapad_ds_base
clearvars -except triallist
%%
doshowtrial=0;
basepath=['ampsfiltds' pathchar 'beststartl' pathchar 'rawpos' pathchar];

do_do_comppos_base

save('dairy/coronal.mat', 'diaryfile');
close all;
clearvars -except triallist
%%
load('dairy/coronal.mat');
[rmsthreshb velthreshb parameter7b lolimb hilimb] = parsestats2(diaryfile);

%clearvars -except triallist
do_ampvsposamp_base
close all;
clearvars -except triallist
%%
myinfix='ds';
do_adjamps_base
clearvars -except triallist
%%
startfile='start_pos.mat';
firstpath='ampsfiltdsadj1';

do_tapad_ds_base
clearvars -except triallist
%%
myinfix='';
do_adjamps_base
close all;
clearvars -except triallist
%%
firstpath='ampsfiltadj1';
outpath=[firstpath pathchar 'recursel' pathchar 'rawpos']
startpath=['ampsfiltdsadj1', pathchar, 'beststartl', pathchar, 'rawpos']

do_Only_tapad_full
clearvars -except triallist
%%

inpath=['ampsfiltadj1' pathchar 'recursevel' pathchar 'rawpos' pathchar ];
amppath=['ampsfiltadj1' pathchar 'amps' pathchar];
outpath=['ampsfiltadj1' pathchar 'velrep' pathchar 'rawpos' pathchar];

do_velocityrepair_base
clearvars -except triallist
%%
firstpath='ampsfiltadj1';
outpath=[firstpath pathchar 'recursevelrep1' pathchar 'rawpos']
startpath=['ampsfiltdsadj1', pathchar, 'velrep', pathchar, 'rawpos']

do_Only_tapad_full


