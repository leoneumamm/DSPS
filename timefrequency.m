function [Pft,Fft,LF_STFT,HF_STFT,iRR,Time,Fs,window_stft,segment,overlap] = timefrequency(iRR,Time,Fs,ax)
time_test1 = Time(3) - Time(2);
time_test2 = Time(2) - Time(1);
if abs(time_test1 - time_test2) > 10e-3;
    er = errordlg('Data are not Even Spaced. Please Re-sample','Error','modal');
    uiwait(er)
    [Time,iRR,Fs] = preprocessing(iRR,Time);
end

if isempty(Fs)
    prompt = {'Sampling Frequency','Enter Segment Size:','Enter Overlap Size:'};
    dlg_title = 'STFT Parameters';
    num_lines = 1;
    def = {'4','512','256'};
    answer = inputdlg(prompt,dlg_title,num_lines,def);
    Fs = str2double(answer{1});
    segment = str2double(answer{2});
    overlap = str2double(answer{3});
else
    prompt = {'Enter Segment Size:','Enter Overlap Size:'};
    dlg_title = 'STFT Parameters';
    num_lines = 1;
    def = {'512','256'};
    answer = inputdlg(prompt,dlg_title,num_lines,def);
    segment = str2double(answer{1});
    overlap = str2double(answer{2});
end
if overlap >  segment,
    er = errordlg('Overlap Must be Smaller Than the Segment! Try Again','Range Error');
    uiwait(er)
    [Pft,Fft,LF_STFT,HF_STFT] = timefrequency(iRR,Time,Fs);
else
[window, control] = window_select();   

step = segment - overlap;
L = length(iRR);                                                                             % Elsenbruch et al., 20000
iter = floor((L-segment)/step) + 1;
start = 1;
stop = segment;
for i=1:iter,
    irr_temp = iRR(start:stop) - mean(iRR(start:stop));
    if window == 1
        [Pft(:,i),Fft]=periodogram(irr_temp,hanning(size(irr_temp,2)),[],Fs);
        window_stft = 'Hanning';
    elseif window == 2
        [Pft(:,i),Fft]=periodogram(irr_temp,triang(size(irr_temp,2)),[],Fs);
        window_stft = 'Triangular';
    elseif window == 3
        [Pft(:,i),Fft]=periodogram(irr_temp,blackman(size(irr_temp,2)),[],Fs);
        window_stft = 'Blackman';
    elseif window == 4
        [Pft(:,i),Fft]=periodogram(irr_temp,hamming(size(irr_temp,2)),[],Fs);
        window_stft = 'Hamming';
    elseif window == 5
        [Pft(:,i),Fft]=periodogram(irr_temp,kaiser(size(irr_temp,2)),[],Fs);
        window_stft = 'Kaiser';
    elseif window == 6
        [Pft(:,i),Fft]=periodogram(irr_temp,gausswin(size(irr_temp,2)),[],Fs);
        window_stft = 'Gaussian';
    else
        [Pft(:,i),Fft]=periodogram(irr_temp,rectwin(size(irr_temp,2)),[],Fs);
        window_stft = 'Rectangular';
    end
    start = start + step;
    stop = stop + step;
end
[HF_STFT,LF_STFT] = integral(Pft,Fft,iter);
Pot = 10*log10(Pft);
Pot(Pot < 0) = 0;
axes(ax)
imagesc(Time,Fft,Pot);
shading interp
ylim([0,1])
set(gca,'YDir','Normal')
title('Time Frequency Analysis - STFT')
xlabel('Time (s)')
ylabel('Frequency (Hz)')
end
