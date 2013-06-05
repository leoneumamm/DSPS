function [Par,Far,LF_STAR,HF_STAR,iRR,Time,Fs,window_star,segment,overlap] = timefrequencyar(iRR,Time,Fs,ax)
time_test1 = Time(3) - Time(2);
time_test2 = Time(2) - Time(1);

if abs(time_test1 - time_test2) > 10e-3;
    er = errordlg('Data are not Even Spaced. Please Re-sample','Error','modal');
    uiwait(er)
    [Time,iRR,Fs] = preprocessing(iRR,Time);
end

if isempty(Fs)
    prompt = {'Sampling Frequency','Model Order','Enter Segment Size:','Enter Overlap Size:'};
    dlg_title = 'STAR Parameters';
    num_lines = 1;
    def = {'4','14','512','256'};
    answer = inputdlg(prompt,dlg_title,num_lines,def);
    if isempty(cellfun(@isempty,answer))
        Par=0;
        Far=0;
        LF_STAR=0;
        HF_STAR=0;
        window_star=0;
        segment=0;
        overlap=0;
        return
    else
        Fs = str2double(answer{1});
        order = str2double(answer{2});
        segment = str2double(answer{3});
        overlap = str2double(answer{4});
    end
else

    prompt = {'Model Order','Enter Segment Size:','Enter Overlap Size:'};
    dlg_title = 'STAR Parameters';
    num_lines = 1;
    def = {'14','512','256'};
    answer = inputdlg(prompt,dlg_title,num_lines,def);
    if isempty(cellfun(@isempty,answer))
        Par=0;
        Far=0;
        LF_STAR=0;
        HF_STAR=0;
        window_star=0;
        segment=0;
        overlap=0;
        return
    else
        order = str2double(answer{1});
        segment = str2double(answer{2});
        overlap = str2double(answer{3});
    end

end
if overlap >  segment,
    er = errordlg('Overlap Must be Smaller Than the Segment! Try Again','Range Error');
    uiwait(er)
    [Pft,Fft,LF_STFT,HF_STFT] = timefrequencyar(iRR,Time,Fs);
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
            irr_temp = irr_temp.*hanning(length(irr_temp))';
            [Par(:,i),Far] = pburg(irr_temp,order,[],Fs);
            window_stft = 'Hanning';
        elseif window == 2
            irr_temp = irr_temp.*triang(length(irr_temp))';
            [Par(:,i),Far] = pburg(irr_temp,order,[],Fs);
            window_stft = 'Triangular';
        elseif window == 3
            irr_temp = irr_temp.*blackman(length(irr_temp))';
            [Par(:,i),Far] = pburg(irr_temp,order,[],Fs);
            window_stft = 'Blackman';
        elseif window == 4
            irr_temp = irr_temp.*hamming(length(irr_temp))';
            [Par(:,i),Far] = pburg(irr_temp,order,[],Fs);
            window_stft = 'Hamming';
        elseif window == 5
            irr_temp = irr_temp.*kaiser(length(irr_temp))';
            [Par(:,i),Far] = pburg(irr_temp,order,[],Fs);
            window_stft = 'Kaiser';
        elseif window == 6
            irr_temp = irr_temp.*gausswin(length(irr_temp))';
            [Par(:,i),Far] = pburg(irr_temp,order,[],Fs);
            window_stft = 'Gaussian';
        else
            irr_temp = irr_temp.*rectwin(size(irr_temp))';
            [Par(:,i),Far] = pburg(irr_temp,order,[],Fs);
            window_stft = 'Rectangular';
        end
        start = start + step;
        stop = stop + step;
    end
    [HF_STAR,LF_STAR] = integral(Par,Far,iter);
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
