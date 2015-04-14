%do_ampvsposamp
%tapad version


nsensor=12;		%total number of channels in the system. Do not change

pcorder=3;		%Chooses principal component regression. Normally no reason to change

%This allows samples to be ignored at the begining and end of each trial
%This is useful if trial duration is generous, with the subject moving very
%little at the beginning and end. This can help avoid giving the regression
%analysis a lot of very similar data, not containing any speech movements.
%Note that the specification is in samples. Downsampled tapad data usually
%has a samplerate of 25Hz, so 5 corresponds to 1/5 seconds.
trimsamp=[5 5];

adjnum=1;			%allow for multiple adjustments

basepath='ampsfiltds';		%normally ampsfilt or ampsfiltds 
if adjnum>1 basepath=[basepath 'adj' int2str(adjnum-1)]; end;
amppath=[basepath pathchar 'amps' pathchar];
pospath=[basepath pathchar 'beststartl' pathchar 'rawpos' pathchar]; %may need changing in unusual cases
outsuffix=strrep(pospath,pathchar,'');
outsuffix=strrep(outsuffix,'ampsfilt','');
outsuffix=strrep(outsuffix,'rawpos','');

outfile=['ampvsposampstats_' outsuffix];


%allow for regression analysis to be done separately for sub-parts of a
%session
nsub=1;
trialbuf=cell(nsub,1);
sufbuf=int2str((1:nsub)');	%subpart number attached to output filename (may be problems if more than 9 parts)

%will normally be based on the settings used with do_do_comppos when
%computing statistics
%repeat the next four lines for each sub-part

restlist=[];		%e.g skip rest, rubbish, dummy
triallist=setdiff(triallist,restlist);
trialbuf{1}=triallist;

sensorsused=[1:12];		%sensors actually in use

compsensor=3;    %comparison sensor; normally a stable reference sensor

compsens=ones(nsensor,1)*NaN;
eucthresh=ones(nsensor,2)*NaN;

compsens(sensorsused)=compsensor;
compsens([compsensor])=NaN;

%copy a list of sensor names here for references

%set up seperate branches here if multiple adjustments are done
if adjnum==1

%%paste in the last five lines from the output of parsestats


end;

parameter7b=ones(1,nsensor)*NaN;		%not currently needed for tapad

eucthresh=[lolimb' hilimb'];

ampvsposampa7pc(amppath,pospath,outfile,trialbuf,sufbuf,sensorsused,rmsthreshb,velthreshb,compsens,eucthresh,parameter7b,pcorder,trimsamp)
