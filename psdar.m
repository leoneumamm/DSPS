function [F,Pxx,LF,HF,VLF,LFnu,HFnu,LF_HF,TotalPower,window_ar,order,bands] = psdar(iRR,Time,ax)

if Time(3) - Time(2) ~= Time(2) - Time(1)
    er = errordlg('Data are not Even Spaced. Please Re-sample','Error','modal');
    uiwait(er)
    [Time,iRR] = preprocessing(iRR,Time);
end

prompt = {'Sampling Frequency','Enter the Order:','Enter Window Type:'};
dlg_title = 'Auto Regressive Power Spectral Density Parameters';
num_lines = 1;
def = {'4','14','Hanning'};
answer = inputdlg(prompt,dlg_title,num_lines,def);
if not(isempty(answer)),
    Fs = str2double(answer{1});
    order = str2double(answer{2});
    window = answer{3};
    switch window
        case 'Hanning'
            iRR = iRR.*hanning(length(iRR))';
            window_ar = 'Hanning';
        case 'Rectwin'
            iRR = iRR.*rectwin(length(iRR))';
            window_ar = 'Rectangular';
        case 'Blackman'
            iRR = iRR.*blackman(length(iRR))';
            window_ar = 'Blackman';
        case 'Hamming'
            iRR = iRR.*hamming(length(iRR))';
            window_ar = 'Hamming';
        case 'Triangular'
            iRR = iRR.*triang(length(iRR))';
            window_ar = 'Triangular';
        case 'Kaiser'
            iRR = iRR.*kaiser(length(iRR))';
            window_ar = 'Kaiser';
        case 'Gaussian'
            iRR = iRR.*gaussian(length(iRR))';
            window_ar = 'Gaussian';
    end
    [Pxx,F] = pburg(iRR,order,[],Fs);
    [LF,HF,VLF,LFnu,HFnu,LF_HF,TotalPower,bands] = psdintegral(F,Pxx);
    axes(ax)
    plot(F,Pxx)
    title('Power Spectral Density Estimative via Auto Regressive Method')
    xlabel('Frequency (Hz)')
    ylabel('PSD (ms^2/Hz)')
end