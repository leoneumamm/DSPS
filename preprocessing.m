function [Tx,iRRx,Fs] = preprocessing(iRR,Time)

Fs = 0
prompt = {'Re-sample Frequency:'};
dlg_title = 'Pre Processing';
num_lines = 1;
def = {'4'};
answer = inputdlg(prompt,dlg_title,num_lines,def);

if not(isempty(answer))
    Fs = str2double(answer{1});
    Tx = Time(1):1/Fs:Time(end);
    iRR = detrend(iRR,'linear');
    iRRx = spline(Time,iRR,Tx);
else
    return
end
end
