options = {};
N = 1;
if exist('Pxx_AR','var')
    options{N} = 'AR-Periodogram';
    N = N + 1;
end
if exist('ECG','var')
    options{N} = 'ECG';
    N=N+1;
end
if exist('iRR','var')
    options{N} = 'RRi';
    N = N + 1;
end
if exist('Pxx','var')
    options{N} = 'Welch-Periodogram';
    N = N + 1;
end

if exist('RMSSDj','var')
    options{N} = 'Time-Varying';
    N = N + 1;
end

if exist('Pft','var')
    options{N} = 'STFT';
    N = N + 1;
end
if exist('Pft_AR','var')
    options{N} = 'STAR';
    N = N + 1;
end

options = sort(options);

d3list = {'Imagesc';'Surf'};
colorlist = {'Black';'White';'Red';'Yellow';'Cyan';'Green'};
plotlist = {'Line';'Dot';'Dashed-Line';'Line-Dot';'Dot-Line';'Hist'};
colorct = {'k','w','r','y','c','g'};
plotct = {'-','.','--','-.','.-'};

fidsf = figure('name','Save Figure Dialog',...
    'number','off','position',[300,300,300,270],'resize','off',...
    'color',[0.839,0.91,0.851],'MenuBar','none');
lsf = uicontrol('Style','listbox','Position',[10,40,170,200],'String',...
    options,'CallBack',['if strcmp(options{get(lsf,''Value'')},''STFT'');',...
    'set(p1sv,''Enable'',''off''); set(p2sv,''Enable'',''off'');',...
    'set(p3sv,''Enable'',''on'');elseif strcmp(options{get(lsf,''Value'')},',...
    '''STAR'');set(p1sv,''Enable'',''off'');set(p3sv,''Enable'',''on'');',...
    'set(p2sv,''Enable'',''off'');else;set(p1sv,''Enable'',''on'');',...
    'set(p2sv,''Enable'',''on'');set(p3sv,''Enable'',''off'');end'] );
p1sv = uicontrol('Style','pop','String',plotlist,'position',...
    [200,190,70,40]);
p2sv = uicontrol('Style','pop','String',colorlist,'position',...
    [200,160,70,40]);
p3sv = uicontrol('Style','pop','String',d3list,'position',...
    [200,130,70,40]);
pltype = 'k-';

bsf1 = uicontrol('Position',[10,15,120,20],'String', 'Preview',...
    'CallBack',['gopt = options(get(lsf,''Value''));clrc = colorct{get(p2sv,''Value'')};',...
    'plrc = plotct{get(p1sv,''Value'')};pltype = [clrc,plrc];',...
    'fsf=figure();',...
    'if strcmp(gopt,''Welch-Periodogram'');plot(F,Pxx,pltype);xlabel(''Frequency (Hz)'');',...
    'ylabel(''PSD (ms^2/Hz)'');title(''Power Spectral Density Estimative',...
    ' via Modified Periodogram'');elseif strcmp(gopt,''RRi'');plot(Time,iRR,pltype);',...
    'xlabel(''Time (s)'');ylabel(''RRi (ms)''); title(''Tachogram'');',...
    'axis(''tight'');elseif strcmp(gopt,''AR-Periodogram'');',...
    'plot(F_AR,Pxx_AR,pltype);xlabel(''Frequency (Hz)'');ylabel(''PSD (s^2/Hz)'');',...
    'title(''Power Spectral Density Estimative via Auto Regressive Method'');',...
    'elseif strcmp(gopt,''ECG''); plot(ecg_time,ECG,pltype);xlabel(''Time (s)'');',...
    'ylabel(''V''); title(''Electrocardiogram'');elseif strcmp(gopt,''STFT'');',...
    'if get(p3sv,''Value'') == 1;imagesc(Time,Fft,Pft);else surf(time_stft,Fft,Pft);',...
    'zlabel(''PSD (ms^2/Hz)'');shading interp;end;xlabel(''Time (s)'');ylabel(''Frequency (Hz)'');',...
    'title(''Short-Time Fourier Transform'');elseif strcmp(gopt,''STAR'');',...
    'if get(p3sv,''Value'') == 1;imagesc(Time,Fft_AR,Pft_AR);',...
    'else; surf(time_star,Fft_AR,Pft_AR);zlabel(''PSD (ms^2/Hz)'');shading interp;end;xlabel(''Time (s)'');',...
    'ylabel(''Frequency (Hz)'');title(''Short-Time Auto Regressive'');end']);


bsf2 = uicontrol('String','Save','Callback',['gopt = options(get(lsf,''Value''));',...
    'fsf=figure(); set(fsf,''Visible'',''off'');',...
    'if strcmp(gopt,''Welch-Periodogram'');plot(F,Pxx,pltype);xlabel(''Frequency (Hz)'');',...
    'ylabel(''PSD (ms^2/Hz)'');title(''Power Spectral Density Estimative',...
    ' via Modified Periodogram'');elseif strcmp(gopt,''RRi'');plot(Time,iRR,pltype);',...
    'xlabel(''Time (s)'');ylabel(''RRi (ms)''); title(''Tachogram'');',...
    'axis(''tight'');elseif strcmp(gopt,''AR-Periodogram'');',...
    'plot(F_AR,Pxx_AR,pltype);xlabel(''Frequency (Hz)'');ylabel(''PSD (s^2/Hz)'');',...
    'title(''Power Spectral Density Estimative via Auto Regressive Method'');',...
    'elseif strcmp(gopt,''ECG''); plot(ecg_time,ECG,pltype);xlabel(''Time (s)'');',...
    'ylabel(''V''); title(''Electrocardiogram'');elseif strcmp(gopt,''STFT'');',...
    'imagesc(Time,Fft,Pft);xlabel(''Time (s)'');ylabel(''Frequency (Hz)'');',...
    'title(''Short-Time Fourier Transform'');elseif strcmp(gopt,''STAR'');',...
    'imagesc(Time,Fft_AR,Pft_AR);xlabel(''Time (s)'');ylabel(''Frequency (Hz)'');',...
    'title(''Short-Time Auto Regressive'');end;[filesf, pathsf] =',...
    'uiputfile({''*.png'';''*.tif'';''*.pdf'';''*.*''},''Save Figure Dialog'',',...
    '''Figure_1.png'');saveas(fsf,[pathsf,filesf]);'],'position',[132,15,120,20]);

%TODO: Time-Varying Variables plot.
