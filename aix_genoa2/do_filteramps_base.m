%do_filteramps
%This script calls filteramps to filter the raw amp files, at the same
%time converting them to mat files and storing the sensor names in the new
%file.
%It also displays some statistics on signal level (very low values may mean
%the sensor is broken)

%do_filteramps template file: Replace these comment lines with brief
%information on the data it will be used for.
%All locations marked '??' require appropriate settings before running the
%script

clear variables

dodown=1;		%set to 1 to generate a downsampled version of the amplitudes
mysuff='';
idownfac=1;
usercomment='Filter complete data';

if dodown
	mysuff='ds';
	idownfac=8;
	usercomment='Filter and downsample data';
end;


inpath=['amps' filesep];
outpath=['ampsfilt' mysuff filesep 'amps' filesep];
mkdir(outpath);

chanlist=1:12;		%actually only needed by plotpegelstats, not by filteramps

%Sensor names: must be a complete list of 12 sensors. Use dummy names if some sensors are
%not in use
usersensornames=str2mat('t_back','t_mid','t_tip','ref','jaw','nose','upper_lip',...
     'lower_lip','head_left','head_right','mouth_left','mouth_right');
%
%this creates a struct P with sensor names as fields, and sensor number as
%the value of the field (useful for defining the filter lists below)
P=desc2struct(usersensornames);

%this will happen if sensor names are ambiguous (or not legal field names
%for a struct)
if isempty(P)
	disp('Check sensor names');
	return;
end;

%set up filtering (lists of sensor numbers; use P.t_tip etc. to refer to
%them symbolically)
%all sensors in the same list will be filtered the same way
list1=[P.t_back P.t_mid P.lower_lip P.upper_lip P.jaw];		%normal articulators
list2=[P.ref P.nose P.head_left P.head_right P.mouth_left P.mouth_right];		%reference sensors
list3=[P.t_tip];

%Check that a sensor has not been put in more than one list
%(but doesn't check that a sensor has been forgotten altogether)
biglist=[list1 list2 list3];
if length(biglist)~=length(unique(biglist))
	disp('Filter lists probably wrong!');
	keyboard;
	return;
end;

%Associate the sensor lists with the desired filter file
%These mat files must exist somewhere on matlab's path
%To find out where they are type e.g : which fir_20_30.mat
%To get a plot of the frequency response: load fir_20_30; freqz(data,1,4096,200)
filterspecs=cell(3,2);	%create cell array; put filter filenames in first column, lists in second colum
filterspecs{1,1}='fir_20_30';
filterspecs{1,2}=list1;
filterspecs{2,1}='fir_05_15';
filterspecs{2,2}=list2;
filterspecs{3,1}='fir_40_50';
filterspecs{3,2}=list3;

%list of trials to process
triallist=[4:7];

pegelstats=filteramps(inpath,outpath,triallist,filterspecs,idownfac,usersensornames,usercomment);
%display the statistics on the signal level of each sensor
plotpegelstats(pegelstats,triallist,chanlist);
