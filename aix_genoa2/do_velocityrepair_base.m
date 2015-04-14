%do_velocityrepair
%Filtering of position data. Repair of outliers also possible



%Sensor names: must be a complete list of 12 sensors. Use dummy names if some sensors are
%not in use
usersensornames=str2mat('t_back','t_mid','t_tip','ref','jaw','nose','upper_lip',...
     'lower_lip','head_left','head_right','mouth_left','mouth_right');
%
%this creates a struct P with sensor names as fields, and sensor number as
%the value of the field (useful for defining the filter lists below)
P=desc2struct(usersensornames);

list1=[P.t_back P.t_mid P.lower_lip P.upper_lip P.jaw];		%normal articulators
list2=[P.ref P.nose P.head_left P.head_right P.mouth_left P.mouth_right];		%reference sensors
list3=[P.t_tip];

filterspecs=cell(3,2);	%create cell array; put filter filenames in first column, lists in second colum
filterspecs{1,1}='fir_20_30';
filterspecs{1,2}=list1;
filterspecs{2,1}='fir_05_15';
filterspecs{2,2}=list2;
filterspecs{3,1}='fir_40_50';
filterspecs{3,2}=list3;

nsensor=12;			%do not change

%change subdirectory names as required
% inpath=['ampsfiltdsadj1' pathchar 'beststartl' pathchar 'rawpos' pathchar ];
% amppath=['ampsfiltdsadj1' pathchar 'amps' pathchar];
% 
% outpath=['ampsfiltdsadj1' pathchar 'velrep' pathchar 'rawpos' pathchar];
mkdir([outpath 'posamps']);

%copy in here the filter specification exactly as used by do_filteramps (or
%the equivalent script used when running the experiment


chanlist=[1:12];

%data is repaired if difference between measured and predicted velocity
%exceeds threshold specified here (in mm/s). If threshold is left as NaN then the
%data is filtered but no repairs are made
veldifflim=ones(nsensor,1)*NaN;
%add lines like the following to activate repairs for specific sensors (e.g
%for sensor 3)
%veldifflim(3)=300;		%threshold for measure minus predicted = 300mm/s

velocityrepair(inpath,amppath,outpath,triallist,chanlist,filterspecs,veldifflim);
