options = {};
N = 1;
if exist('Pxx_AR','var')
    options{N} = 'AR-Periodogram';
    varc{N} = 'Pxx_AR';
    N=N+1;
    varc{N} = 'F_AR';
    N = N + 1;
end
if exist('ECG','var')
    options{N} = 'ECG';
    varc{N} = 'ecg_time';
    N = N+1;
    varc{N} = 'ECG';
    N = N + 1;
end
if exist('iRR','var')
    options{N} = 'RRi';
    varc{N} = 'iRR';
    N = N + 1;
    varc{N} = 'Time';
    N = N + 1;
end
if exist('Pxx','var')
    options{N} = 'Welch-Periodogram';
    varc{N} = 'Pxx';
    N=N+1;
    varc{N} = 'F';
    N = N + 1;
end

if exist('RMSSDj','var')
    options{N} = 'Time-Varying';
    varc{N} = 'RMSSDj';
    N=N+1;
    varc{N} = 'pNN50j';
    N=N+1;
    varc{N} = 'SDNNj';
    N=N+1;
    varc{N} = 'averagej';
    N=N+1;
    varc{N} = 'Index';
    N = N + 1;
end


if exist('STFT','var')
    options{N} = 'STFT';
    varc{N} = 'Pft';
    N=N+1;
    varc{N} = 'Fft';
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
        'CallBack','set(fsf,''Visible'',''off'')');

        % TODO: solve problem of sorted index array.

     switch options{get(lsf,'Value')}
        case 'Welch-Periodogram'
            fsf = figure();
            plot(F_AR,Pxx_AR);
            set(fsf,'Visible','off')
        case 'AR-Periodogram'
            fsf = figure();
            plot(F_AR,Pxx_AR);
            set(fsf,'Visible','off')
        case 'Time-Varying'
            fsf = figure();
            plot(Index,RMSSDj);
            set(fsf,'Visible','off')
        case 'ECG'
            fsf = figure();
            plot(ecg_time, ECG);
            set(fsf,'Visible','off')
        case 'RRi'
            fsf = figure();
            plot(Time, iRR);
            set(fsf,'Visible','off')
        case 'STFT'
            fsf = figure();
            imagesc(Time,Fft,Pft)
            %....
        case 'STAR'
            fsf = figure();
            imagesc(Time, Fft_AR,Pft_AR)
        end
    end
    bsf2 = uicontrol('String','Save','Callback',['[filesf, pathsf] =',...
        'uiputfile({''*.png'';''*.tif'';''*.pdf'';''*.*''},''Save Figure Dialog'',''Figure_1'');',...
        'saveas(fsf,[pathsf,filesf]);'],'position',[132,15,120,20]);
end
