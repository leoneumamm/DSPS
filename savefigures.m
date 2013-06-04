options = {};
N = 1;
if exist('Pxx','var')
    options{N} = 'Pxx';
    N = N + 1;
end
if exist('Pxx_AR','var')
    options{N} = 'Pxx_AR';
    N = N + 1;
end
if exist('RMSSDj','var')
    options{N} = 'Time Varying';
    N = N + 1;
end
if exist('ECG','var')
    options{N} = 'ECG';
    N = N + 1;
end
if exist('iRR','var')
    options{N} = 'iRR';
    N = N + 1;
end
if exist('STFT','var')
    options{N} = 'STFT';
    N = N + 1;
end
if exist('STAR','var')
    options{N} = 'STAR';
    N = N + 1;
end

if N > 1
    dpilist = ['150';'300';'600'];
    colorlist = {'Black';'White';'Red';'Yellow';'Cyan';'Green'};
    plotlist = {'Line';'Dot';'Dashed-Line';'Line-Dot';'Dot-Line';'Hist'};
    fidsf = figure('name','Save Figure Dialog',...
        'number','off','position',[300,300,300,270],'resize','off',...
        'color',[0.839,0.91,0.851],'MenuBar','none');
    lsf = uicontrol('Style','listbox','Position',[10,40,170,200],'String',...
        'options');
    p1sv = uicontrol('Style','pop','String',plotlist,'position',...
        [200,190,70,40]);
    p2sv = uicontrol('Style','pop','String',colorlist,'position',...
        [200,160,70,40]);
    p3sv = uicontrol('Style','pop','String',dpilist,'position',...
        [200,130,70,40]);
    bsf1 = uicontrol('Position',[10,15,120,20],'String', 'Preview',...
        'CallBack','tempsf = figure();plot(randn(1,100))');
    %Pegar o indice que foi selecionado na listbox plotar com visualize off
    %e salvar com saveas
    bsf2 = uicontrol('String','Save','Callback',['[filesf, pathsf] =',...
        'uiputfile({''*.png'';''*.tif'';''*.pdf'';''*.*''},''Save Figure Dialog'',''Figure_1'');',...
        'saveas(fsf,[pathsf,filesf]);'],'position',[132,15,120,20]);
<<<<<<< HEAD
 end
=======
 end
>>>>>>> a4246c034565407677c5d0f26b37f4f7cb4902ec
