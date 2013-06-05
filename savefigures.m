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
if exist('STAR','var')
    options{N} = 'STAR';
    N = N + 1;
end

options = sort(options);

if N > 2
    dpilist = ['150';'300';'600'];
    colorlist = {'Black';'White';'Red';'Yellow';'Cyan';'Green'};
    plotlist = {'Line';'Dot';'Dashed-Line';'Line-Dot';'Dot-Line';'Hist'};
    fidsf = figure('name','Save Figure Dialog',...
        'number','off','position',[300,300,300,270],'resize','off',...
        'color',[0.839,0.91,0.851],'MenuBar','none');
    lsf = uicontrol('Style','listbox','Position',[10,40,170,200],'String',...
        options);
    p1sv = uicontrol('Style','pop','String',plotlist,'position',...
        [200,190,70,40]);
    p2sv = uicontrol('Style','pop','String',colorlist,'position',...
        [200,160,70,40]);
    p3sv = uicontrol('Style','pop','String',dpilist,'position',...
        [200,130,70,40]);
   
    bsf1 = uicontrol('Position',[10,15,120,20],'String', 'Preview',...
        'CallBack',['gopt = options(get(lsf,''Value''));fsf=figure();',...
        'if strcmp(gopt,''Welch-Periodogram'');plot(F,Pxx);xlabel(''Frequency (Hz)'');',...
        'ylabel(''PSD (ms^2/Hz)'');title(''Power Spectral Density Estimative',...
        ' via Modified Periodogram'');elseif strcmp(gopt,''RRi'');plot(Time,iRR);',...
        'xlabel(''Time (s)'');ylabel(''RRi (ms)''); title(''Tachogram'');',...
        'axis(''tight'');elseif strcmp(gopt,''AR-Periodogram'');',...
        'plot(F_AR,Pxx_AR);xlabel(''Frequency (Hz)'');ylabel(''PSD (s^2/Hz)'');',...
        'title(''Power Spectral Density Estimative via Auto Regressive Method'');',...
        'elseif strcmp(gopt,''ECG''); plot(time_ecg,ECG);xlabel(''Time (s)'');',...
        'ylabel(''V''); title(''Electrocardiogram'');elseif strcmp(gopt,''STFT'');',...
        'imagesc(Time,Fft,Pft);xlabel(''Time (s)'');ylabel(''Frequency (Hz)'');',...
        'title(''Short-Time Fourier Transform'');elseif strcmp(gopt,''STAR'');',...
        'imagesc(Time,Fft_AR,Pft_AR);xlabel(''Time (s)'');ylabel(''Frequency (Hz)'');',...
        'title(''Short-Time Auto Regressive'');end']);
end

%Create elseif's for all plots with visible off to save without preview.

bsf2 = uicontrol('String','Save','Callback',['if exist(''fsf'',''var'');[filesf, pathsf] =',...
    'uiputfile({''*.png'';''*.tif'';''*.pdf'';''*.*''},''Save Figure Dialog'',',...
    '''Figure_1.png'');saveas(fsf,[pathsf,filesf]);end;'],'position',[132,15,120,20]);






