function [F,Pxx,LF,HF,VLF,LFnu,HFnu,LF_HF,TotalPower, iRR, Time,Fs,window_w...
    ,bands,segment,overlap,P] = psdestimative(iRR, Time, Fs,ax)

F = 0;
Pxx = 0;
LF = 0;
HF = 0;
VLF = 0;
LFnu = 0;
HFnu = 0;
LF_HF = 0;
TotalPower = 0;
window_w= 0;
bands = 0;
segment = 0;
overlap = 0;
P = 0;

time_test1 = Time(3) - Time(2);
time_test2 = Time(2) - Time(1);

if abs(time_test1 - time_test2) > 10e-3;
    er = errordlg('Data are not Even Spaced. Please Re-sample','Error','modal');
    uiwait(er)
    [Time,iRR, Fs] = preprocessing(iRR,Time);

    if Fs == 0
        return
    end
end

if isempty(Fs)
    prompt = {'Sampling Frequency','Enter Segment Size:','Enter Overlap Size:'};
    dlg_title = 'Power Spectral Density Parameters';
    num_lines = 1;
    def = {'4','512','256'};
    answer = inputdlg(prompt,dlg_title,num_lines,def);
    if isempty(cellfun(@isempty,answer))
        return
    else
        Fs = str2double(answer{1});
        segment = str2double(answer{2});
        overlap = str2double(answer{3});
    end

else
    prompt = {'Enter Segment Size:','Enter Overlap Size:'};
    dlg_title = 'Power Spectral Density Parameters';
    num_lines = 1;
    def = {'512','256'};
    answer = inputdlg(prompt,dlg_title,num_lines,def);
    if isempty(cellfun(@isempty,answer))
        return
    else
    segment = str2double(answer{1});
    overlap = str2double(answer{2});
    end
end


step = segment - overlap;
P = fix((length(iRR) - segment)/step) + 1;
[window, control] = window_select();

if control ~= 0,
    switch window
        case 1
            [Pxx,F] = pwelch(iRR,hanning(segment),overlap,[],Fs);
            window_w = 'Hanning';
        case 3
            [Pxx,F] = pwelch(iRR,blackman(segment),overlap,[],Fs);
            window_w = 'Blackman';
        case 4
            [Pxx,F] = pwelch(iRR,hamming(segment),overlap,[],Fs);
            window_w = 'Hamming';
        case 2
            [Pxx,F] = pwelch(iRR,triang(segment),overlap,[],Fs);
            window_w = 'Triangular';
        case 5
            [Pxx,F] = pwelch(iRR,kaiser(segment),overlap,[],Fs);
            window_w = 'Kaiser';
        case 6
            [Pxx,F] = pwelch(iRR,gausswin(segment),overlap,[],Fs);
            window_w = 'Gaussian';
    end
    else
        [Pxx,F] = pwelch(iRR,rectwin(segment),overlap,[],Fs);
        window_w = 'Rectangular';
    end

    [LF,HF,VLF,LFnu,HFnu,LF_HF,TotalPower,bands] = psdintegral(F,Pxx);

    axes(ax)
    plot(F,Pxx/1e6)
    title('Power Spectral Density Estimative via Modified Periodogram')
    xlabel('Frequency (Hz)')
    ylabel('PSD (s^2/Hz)')
end
