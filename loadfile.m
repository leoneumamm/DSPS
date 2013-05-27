function [Time,iRR,filename,pathname] = loadfile(ax)
[filename, pathname] = uigetfile( ...
    {'*.txt','Text Files (*.txt)';
    '*.xls;*.xlsx',  'Excel Files (*.xls,*.xlsx)'; ...
    '*.*',  'All Files (*.*)'}, ...
    'Choose the Signal');
iRR = load([pathname, filename]);
if find(iRR <0)
    er = errordlg('Signal with Mean Removed. Cannot Create Time Vector!','Erro','modal');
    uiwait(er)
    wd = questdlg(' Data are Interpolated ?',...
        'Warning','Yes','No','Yes');
    if strcmp(wd,'Yes')
        prompt = {'Sampling Frequency'};
        dlg_title = 'Time Creation';
        num_lines = 1;
        def = {'4'};
        answer = inputdlg(prompt,dlg_title,num_lines,def);
        Fs = str2double(answer{1});
        Time = [0:length(iRR) - 1]/Fs;
        return
    else
        Time = 1:length(iRR);
        wd = warndlg('The "Time" Vector is Now The Number of Data Points','Warning');
        uiwait(wd)
        return
    end
end
    if max(iRR) > 10, % Time in Seconds - Test for iRR in milisec or sec.
        Time = cumsum(iRR)/1000;
    else
        Time = cumsum(iRR);
    end
    axes(ax)
    plot(Time,iRR,'k')
    xlabel('Time (s)')
    ylabel('iRR (ms)')
    title('Tachogram')
    axis tight
end
