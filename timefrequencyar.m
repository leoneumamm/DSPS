function [Par,Far,LF_STAR,HF_STAR,iRR,Time,Fs,window_star,segment,overlap] = timefrequencyar(rr_filt,Time,Fs,ax)
time_test1 = Time(3) - Time(2);
time_test2 = Time(2) - Time(1);
if abs(time_test1 - time_test2) > 10e-3;
    er = errordlg('Data are not Even Spaced. Please Re-sample','Error','modal');
    uiwait(er)
    [Time,iRR,Fs] = preprocessing(iRR,Time);
else
    iRR = rr_filt;
    Time = Time;
end

if isempty(Fs)
    prompt = {'Sampling Frequency','Model Order','Enter Segment Size:','Enter Overlap Size:'};
    dlg_title = 'STAR Parameters';
    num_lines = 1;
    def = {'4','14','512','256'};
    answer = inputdlg(prompt,dlg_title,num_lines,def);
    Fs = str2double(answer{1});
    order = str2double(answer{2});
    segment = str2double(answer{3});
    overlap = str2double(answer{4});
else
    prompt = {'Model Order','Enter Segment Size:','Enter Overlap Size:'};
    dlg_title = 'STAR Parameters';
    num_lines = 1;
    def = {'14','512','256'};
    answer = inputdlg(prompt,dlg_title,num_lines,def);
    order = str2double(answer{1});
    segment = str2double(answer{2});
    overlap = str2double(answer{3});
end
if overlap >  segment,
    er = errordlg('Overlap Must be Smaller Than the Segment! Try Again','Range Error');
    uiwait(er)
    [Pft,Fft,LF_STFT,HF_STFT] = timefrequencyar(rr_filt,Time,Fs);
else
step = segment - overlap;
L = length(rr_filt);                                                                             % Elsenbruch et al., 20000
iter = L-segment;
for i=1:iter,
    irr_temp = rr_filt(i:step:i+segment) - mean(rr_filt(i:step:i+segment));
    [Par(:,i),Far] = pburg(irr_temp,order,[],Fs);
end
[HF_STAR,LF_STAR] = integral(Par,Far);
Pot = 10*log10(Par);
Pot(Pot < 0) = 0;
axes(ax)
imagesc(Time,Far,Pot);
shading interp
set(gca,'YDir','Normal')
ylim([0,1])
title('Time Frequency Analysis - STAR')
xlabel('Time (s)')
ylabel('Frequency (Hz)')
window_star = 'Verificar';
end