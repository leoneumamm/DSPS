function [iRR,Fs,Time] = hrvfilter(iRR,filter_type,Fs,Time,ax)
switch filter_type
    case 'Ratio'
        prompt = {'Order'};
        dlg_title = 'Ratio Filter Parameters';
        num_lines = 1;
        def = {'4'};
        answer = inputdlg(prompt,dlg_title,num_lines,def);
        order = str2double(answer{1});
        
        for k = 1:length(iRR) - 1
            
            if k <= order
                
                if abs(iRR(k)/iRR(k + 1)) <= 0.8 || abs(iRR(k)/iRR(k + 1)) >= 1.2
                    iRR(k) = mean(iRR(k + order));
                    
                end
            else
                
                if abs(iRR(k)/iRR(k + 1)) <= 0.8 || abs(iRR(k)/iRR(k + 1)) >= 1.2
                    iRR(k) = mean(iRR(k - order));
                    
                end
            end
            
        end
        
    case 'MovingAverage'
        prompt = {'Order'};
        dlg_title = 'Moving Avarage Filter Parameters';
        num_lines = 1;
        def = {'3'};
        answer = inputdlg(prompt,dlg_title,num_lines,def);
        order = str2double(answer{1});
        
        sample_loss = fix(order/2);
        iRR_temp1 = iRR(1:sample_loss);
        iRR_temp2 = iRR(end - sample_loss + 1:end);
        signal = iRR;
        for iter = 1:length(iRR) - 2*sample_loss,
            signal(iter) = mean(signal(iter:order + iter - 1));
        end
        
        iRR = signal;
        %iRR = [iRR_temp1,signal,iRR_temp2];
        %Output signal is bigger than input. Check This!
        
    case 'RunningMedian'
        prompt = {'Order'};
        dlg_title = 'Running Median Filter Parameters';
        num_lines = 1;
        def = {'3'};
        answer = inputdlg(prompt,dlg_title,num_lines,def);
        order = str2double(answer{1});
        
        sample_loss = fix(order/2);
        iRR_temp1 = iRR(1:sample_loss);
        iRR_temp2 = iRR(end - sample_loss + 1:end);
        signal = iRR;
        
        for iter = 1:length(iRR) - 2*sample_loss,
            signal(iter) = median(signal(iter:order + iter - 1));
        end
        
    case 'butter'
        time_test1 = Time(3) - Time(2);
        time_test2 = Time(2) - Time(1);
        if abs(time_test1 - time_test2) > 10e-3;
            er = errordlg('Data are not Even Spaced. Please Re-sample','Error','modal');
            uiwait(er)
            [Time,iRR,Fs] = preprocessing(iRR,Time);
        end
        options = {'Low Pass','High Pass','Stop Band','Band Pass'};
        [filterType, control] = listdlg('PromptString','Select a filter:',...
            'SelectionMode','single',...
            'ListString',options);        
        switch filterType
            case 1
                prompt = {'Cutoff Frequency:','Order','Forward/Reverse'};
                dlg_title = 'Butterworth Parameters';
                num_lines = 1;
                def = {'1','4','Y'};
                answer = inputdlg(prompt,dlg_title,num_lines,def);
                lC = str2double(answer{1});
                Order = str2double(answer{2});
                [B,A] = butter(Order,2*lC/Fs,'low');
            case 2
                prompt = {'Lower Cutoff Frequency:','Order','Forward/Reverse'};
                dlg_title = 'Butterworth Parameters';
                num_lines = 1;
                def = {'0.004','4','Y'};
                answer = inputdlg(prompt,dlg_title,num_lines,def);
                uC = str2double(answer{1});
                Order = str2double(answer{2});
                [B,A] = butter(Order,2*uC/Fs,'high');
            case 3
                prompt = {'Lower Cutoff Frequency:','Upper Cutoff Frequency:','Order','Forward/Reverse'};
                dlg_title = 'Butterworth Parameters';
                num_lines = 1;
                def = {'0.004','1','4','Y'};
                answer = inputdlg(prompt,dlg_title,num_lines,def);
                lC = str2double(answer{1});
                uC = str2double(answer{2});
                Order = str2double(answer{3});
                [B,A] = butter(Order,[2*lC/Fs,2*uC/Fs],'stop');
            otherwise
                prompt = {'Lower Cutoff Frequency:','Upper Cutoff Frequency:','Order','Forward/Reverse'};
                dlg_title = 'Butterworth Parameters';
                num_lines = 1;
                def = {'0.004','1','4','Y'};
                answer = inputdlg(prompt,dlg_title,num_lines,def);
                lC = str2double(answer{1});
                uC = str2double(answer{2});
                Order = str2double(answer{3});
                [B,A] = butter(Order,[2*lC/Fs,2*uC/Fs],'bandpass');
        end
        if isempty(cellfun(@isempty,answer))
            return
        end
        if strcmp(answer{end},'Y') || strcmp(answer{4},'y')
            signal = filtfilt(B,A,iRR);
        else
            signal = filt(B,A,iRR);
        end
end
iRR = signal;
axes(ax)
plot(Time,iRR,'k')
xlabel('Time (s)')
ylabel('RRi (ms)')
title('Tachgram')
axis tight
end
