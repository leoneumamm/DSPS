function iRR = hrvfilter(iRR,filter_type)
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
        
        iRR = signal;
end
end
