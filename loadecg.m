function [ecg_time,ECG,Fs_ecg] = loadfile()
[filename, pathname] = uigetfile( ...
    {'*.bin','Binary Files (*.bin)';
    '*.abf',  'ABF Files (*.abf)'; ...
    '*.txt','Text Files (*.txt)';
    '*.*',  'All Files (*.*)'}, ...
    'Choose the Signal');
if strfind(filename,'abf')
    prompt = {'Sampling Frequency'};
    dlg_title = 'Ecg Parameters';
    num_lines = 1;
    def = {'1000'};
    answer = inputdlg(prompt,dlg_title,num_lines,def);
    Fs_ecg= str2double(answer{1});
    ECG = abfload([pathname, filename]);
    ecg_time = [0:length(ECG)-1]/Fs_ecg;
elseif strfind(filename,'txt')
    ECG = load([pathname,filename]);
    prompt = {'Sampling Frequency'};
    dlg_title = 'Ecg Parameters';
    num_lines = 1;
    def = {'1000'};
    answer = inputdlg(prompt,dlg_title,num_lines,def);
    Fs_ecg= str2double(answer{1});
    ecg_time = [0:length(ECG)-1]/Fs_ecg;
else
    %%%implentar impdasbin
end
end

