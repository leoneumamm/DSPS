function [Time,iRR,ref_val,ecgf,irr_pos] = irrdetect(ECG,Fs)

prompt = {'Lower frequency','Higher Frequency'};
dlg_title = 'Band-Pass Filter Parameters';
num_lines = 1;
def = {'5','40'};
answer = inputdlg(prompt,dlg_title,num_lines,def);
low_fc = str2double(answer{1});
high_fc = str2double(answer{2});


[B,A] = butter(2,[low_fc/(Fs*2), high_fc/(Fs*2)],'bandpass');
ecgf = filtfilt(B,A,ECG);
ecg_time = [0:length(ecgf)-1]/Fs;

plot(ecg_time,ecgf,'k')
xlabel('Time (s)')
ylabel('Volts (s)')
title('RRi Detection')

prompt = {'Threshold','Refratory Period'};
dlg_title = 'Detection Parameters';
num_lines = 1;
def = {'0.5','250'};
answer = inputdlg(prompt,dlg_title,num_lines,def);
threshold = str2double(answer{1});
ref_val = str2double(answer{2});

cont = 1;
decgf = diff(ecgf);
for iter = 1:length(ecgf) -1
    if ecgf(iter) > threshold && decgf(iter) > 0 && decgf(iter+1) < 0 || decgf(iter) == 0,
        irr_pos(cont) = iter + 1;
        cont = cont + 1;
    end
end
plot(ecg_time,ecgf,'k')
hold on
plot(ecg_time(irr_pos),ecgf(irr_pos),'g.-')
title('RRi Detection')
xlabel('Time (s)')
ylabel('Volts (v)')
hold off
autoartefactremove(ecgf,Fs,irr_pos,ref_val)
iRR = diff(ecg_time(irr_pos)*1000);
Time = cumsum(iRR)/1000;

end