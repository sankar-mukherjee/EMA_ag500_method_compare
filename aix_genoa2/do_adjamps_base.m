
%do_adjamps
%tapad version

%Often the calculation of the adjustment parameters will be based on the
%downsampled tapad version.
%However, in straightforward cases it is not necessary to re-calculate the
%downsampled version, so the adjustment can be applied directly to the full
%version of the amplitudes

% myinfix='ds';		%apply to downsampled version
% myinfix='';			%apply to full version

adjnum=1;			%allow for more than one adjustment


sensorsused=[1:12];	%same setting as in do_ampvsposamp

%copy these settings from do_ampvsposamp
nsub=1;
trialbuf=cell(nsub,1);
sufbuf=int2str((1:nsub)');

%repeat as necessary for more than one sub-part
%note: although do_ampvsposamp may exclude unusual trials from the
%regression calculations, normally the actual adjustment of the amplitudes
%will be applied to all trial. So usually no restlist here.
trialbuf{1}=triallist;


inpath=['ampsfilt' myinfix];
if adjnum>1 inpath=[inpath 'adj' int2str(adjnum-1)]; end;
inpath=[inpath pathchar 'amps'];
outpath=['ampsfilt' myinfix 'adj' int2str(adjnum) pathchar 'amps'];
%assumes the regression analysis always based on downsampled tapad
coffile=['ampvsposampstats_ds'];
if adjnum>1 coffile=[coffile 'adj' int2str(adjnum-1)]; end;
coffile=[coffile 'beststartl'];


mkdir(outpath);
 
%loop through the sub-parts
for ipass=1:nsub

disp([ipass nsub]);
mysuff=deblank(sufbuf(ipass,:));
coffuse=[coffile mysuff];

triallist=trialbuf{ipass};


adjampsapc(inpath,outpath,triallist,sensorsused,coffuse)


end;
