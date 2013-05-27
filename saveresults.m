if exist('Results','var')
    prompt = {'Enter File Name:'};
    dlg_title = 'Save Dialog';
    num_lines = 1;
    def = {'.txt'};
    Name = inputdlg(prompt,dlg_title,num_lines,def);
    fid = fopen(char(Name),'w');
    fprintf(fid,'%s','File Name: ');
    fprintf(fid,'%s',filename(1:strfind(filename,'.txt')-1));
    fprintf(fid,'               %s','Path Name: ');
    fprintf(fid,'%s\r\n',pathname);    
    fprintf(fid,'%s','Date: ');
    fprintf(fid,'%s\r\n',date);
    fprintf(fid,'\r\n');
    fprintf(fid,'%s','Re-sample Frequency: ');
        if ~isempty(Fs);
            fprintf(fid,'%d',Fs);
            fprintf(fid,' %s','Hz');
        else
            fprintf(fid,'%s','None');
        end
        fprintf(fid,'           %s','Filter: ');
        fprintf(fid,'%s\r\n','None');
        fprintf(fid,'\r\n');
    
    try
        getfield(Results,'Time_Domain');
        fprintf(fid,'%s','------------------------------------------------')
        fprintf(fid,' %s','Time Domain:');
        fprintf(fid,'%s\r\n','------------------------------------------------')
        fprintf(fid,'\r\n');
        fprintf(fid,'          %s\r\n','RMSSD (ms)');
        fprintf(fid,'          %5.2f\r\n',Results.Time_Domain.RMSSD);
        fprintf(fid,'\r\n');
        fprintf(fid,'\r\n');
        fprintf(fid,'          %s\r\n','pNN50 (%)');
        fprintf(fid,'          %5.2f\r\n',Results.Time_Domain.pNN50);
        fprintf(fid,'\r\n');
        fprintf(fid,'\r\n');
        fprintf(fid,'          %s\r\n','SDNN (ms)');
        fprintf(fid,'          %5.2f\r\n',Results.Time_Domain.SDNN);
        fprintf(fid,'\r\n');
        fprintf(fid,'\r\n');
        fprintf(fid,'          %s\r\n','SD1 (ms)');
        fprintf(fid,'          %5.2f\r\n',Results.Time_Domain.SD1);
        fprintf(fid,'\r\n');
        fprintf(fid,'\r\n');
        fprintf(fid,'          %s\r\n','SD2 (ms)');
        fprintf(fid,'\r\n');
        fprintf(fid,'          %5.2f\r\n',Results.Time_Domain.SD2);
        fprintf(fid,'\r\n');
        fprintf(fid,'\r\n');
    catch
    end
    try
        getfield(Results,'Time_Varying');
        
        fprintf(fid,'        %s\r\n','Time Varying:');
        fprintf(fid,'\r\n');
        fprintf(fid,'%s','Segment Size: ');
        fprintf(fid,'%d\r\n',segment_TV);
        fprintf(fid,'%s','Overlap: ');
        fprintf(fid,'%d\r\n',overlap_TV);
        fprintf(fid,'%s','N° of Indexes: ');
        fprintf(fid,'%d\r\n',P_TV);
        fprintf(fid,'\r\n');
        fprintf(fid,'          %s\r\n','RMSSDj (ms)');
        for iter = 1:length(Results.Time_Varying.RMSSDj)
            fprintf(fid,' %5.2f',Results.Time_Varying.RMSSDj(iter));
            fprintf(fid,'%s',';');
%             if rem(iter,15) == 0
%                 fprintf(fid,'\r\n');
%             end
        end
        fprintf(fid,'\r\n');
        fprintf(fid,'\r\n');
        fprintf(fid,'          %s\r\n','pNN50j (%)');
        for iter = 1:length(Results.Time_Varying.pNN50j)
            fprintf(fid,' %5.2f',Results.Time_Varying.pNN50j(iter));
            fprintf(fid,'%s',';');
%             if rem(iter,15) == 0
%                 fprintf(fid,'\r\n');
%             end
        end
        fprintf(fid,'\r\n');
        fprintf(fid,'\r\n');
        fprintf(fid,'          %s\r\n','SDNNj (ms)');
        for iter = 1:length(Results.Time_Varying.SDNNj)
            fprintf(fid,' %5.2f',Results.Time_Varying.SDNNj(iter));
            fprintf(fid,'%s',';');
%             if rem(iter,15) == 0
%                 fprintf(fid,'\r\n');
%             end
        end
        fprintf(fid,'\r\n');
        fprintf(fid,'\r\n');
        fprintf(fid,'          %s\r\n','Averagej (ms)')
        for iter = 1:length(Results.Time_Varying.Averagej)
            fprintf(fid,' %5.2f',Results.Time_Varying.Averagej(iter));
            fprintf(fid,'%s',';');
%             if rem(iter,15) == 0
%                 fprintf(fid,'\r\n');
%             end
        end
        fprintf(fid,'\r\n');
        fprintf(fid,'\r\n');
    catch
    end
    try
        getfield(Results,'PSD')
        fprintf(fid,'        %s\r\n','Power Spectral Density - Welch:');
        fprintf(fid,'\r\n');
        fprintf(fid,'%s','Window: ');
        fprintf(fid,'%s\r\n',window_w);
        fprintf(fid,'%s','Bands: ');
        fprintf(fid,'%s','LF (');
        fprintf(fid,'%s',bands_PSD(1:4));
        fprintf(fid,'%s','-');
        fprintf(fid,'%s',bands_PSD(5:8));
        fprintf(fid,'%s',') ');
        fprintf(fid,'%s','HF (');
        fprintf(fid,'%s',bands_PSD(9:12));
        fprintf(fid,'%s','-');
        fprintf(fid,'%s',bands_PSD(13:15));
        fprintf(fid,'%s',') ');
        fprintf(fid,'%s','VLF (');
        fprintf(fid,'%s',bands_PSD(16:end));
        fprintf(fid,'%s\r\n',') ');
        fprintf(fid,'%s','Segment Size: ');
        fprintf(fid,'%d\r\n',segment_PSD);
        fprintf(fid,'%s','Overlap: ');
        fprintf(fid,'%d\r\n',overlap_PSD);
        fprintf(fid,'%s','N° of Estimatives: ');
        fprintf(fid,'%d\r\n',N_estimative_PSD);        
        fprintf(fid,'\r\n');
        fprintf(fid,'          %s\r\n','LF (ms²)');
        fprintf(fid,'          %5.2f\r\n',Results.PSD.LF);
        fprintf(fid,'\r\n');
        fprintf(fid,'\r\n');
        fprintf(fid,'          %s\r\n','HF (ms²)');
        fprintf(fid,'          %5.2f\r\n',Results.PSD.HF);
        fprintf(fid,'\r\n');
        fprintf(fid,'\r\n');
        fprintf(fid,'          %s\r\n','VLF (ms²)');
        fprintf(fid,'          %5.2f\r\n',Results.PSD.VLF);
        fprintf(fid,'\r\n');
        fprintf(fid,'\r\n');
        fprintf(fid,'          %s\r\n','LF (n.u)');
        fprintf(fid,'          %5.2f\r\n',Results.PSD.LFnu);
        fprintf(fid,'\r\n');
        fprintf(fid,'\r\n');
        fprintf(fid,'          %s\r\n','HF (n.u)');
        fprintf(fid,'          %5.2f\r\n',Results.PSD.HFnu);
        fprintf(fid,'\r\n');
        fprintf(fid,'\r\n');
        fprintf(fid,'          %s\r\n','LF/HF');
        fprintf(fid,'          %4.2f\r\n',Results.PSD.LF_HF);
        fprintf(fid,'\r\n');
        fprintf(fid,'\r\n');
        fprintf(fid,'          %s\r\n','Total Power (ms²)');
        fprintf(fid,'          %5.2f\r\n',Results.PSD.TotalPower);
        fprintf(fid,'\r\n');
        fprintf(fid,'\r\n');
    catch
    end
    try
        getfield(Results,'AR')
        fprintf(fid,'        %s\r\n','Power Spectral Density - Auto Regressive:');
        fprintf(fid,'\r\n');
        fprintf(fid,'%s','Window: ');
        fprintf(fid,'%s\r\n',window_AR);
        fprintf(fid,'%s','Bands: ');
        fprintf(fid,'%s','LF (');
        fprintf(fid,'%s',bands_AR(1:4));
        fprintf(fid,'%s','-');
        fprintf(fid,'%s',bands_AR(5:8));
        fprintf(fid,'%s',') ');
        fprintf(fid,'%s','HF (');
        fprintf(fid,'%s',bands_AR(9:12));
        fprintf(fid,'%s','-');
        fprintf(fid,'%s',bands_AR(13:15));
        fprintf(fid,'%s',') ');
        fprintf(fid,'%s','VLF (');
        fprintf(fid,'%s',bands_AR(16:end));
        fprintf(fid,'%s\r\n',') ');
        fprintf(fid,'%s','Model Order: ');
        fprintf(fid,'%d\r\n',order_AR);
        fprintf(fid,'\r\n');
        fprintf(fid,'\r\n');
        fprintf(fid,'          %s\r\n','LF (ms²)');
        fprintf(fid,'          %5.2f\r\n',Results.AR.LF);
        fprintf(fid,'\r\n');
        fprintf(fid,'\r\n');
        fprintf(fid,'          %s\r\n','HF (ms²)');
        fprintf(fid,'          %5.2f\r\n',Results.AR.HF);
        fprintf(fid,'\r\n');
        fprintf(fid,'\r\n');
        fprintf(fid,'          %s\r\n','VLF (ms²)');
        fprintf(fid,'          %5.2f\r\n',Results.AR.VLF);
        fprintf(fid,'\r\n');
        fprintf(fid,'\r\n');
        fprintf(fid,'          %s\r\n','LF (n.u)');
        fprintf(fid,'          %5.2f\r\n',Results.AR.LFnu_AR);
        fprintf(fid,'\r\n');
        fprintf(fid,'\r\n');
        fprintf(fid,'          %s\r\n','HF (n.u)');
        fprintf(fid,'          %5.2f\r\n',Results.AR.HFnu_AR);
        fprintf(fid,'\r\n');
        fprintf(fid,'\r\n');
        fprintf(fid,'          %s\r\n','LF/HF');
        fprintf(fid,'          %4.2f\r\n',Results.AR.LF_HF_AR);
        fprintf(fid,'\r\n');
        fprintf(fid,'\r\n');
        fprintf(fid,'          %s\r\n','Total Power (ms²)');
        fprintf(fid,'          %5.2f\r\n',Results.AR.TotalPower_AR);
        fprintf(fid,'\r\n');
        fprintf(fid,'\r\n');
    catch
    end
    try
        getfield(Results,'nlinfit.Par');
        fprintf(fid,'%s\r\n','FC0');
        fprintf(fid,'%4.2f\r\n',Results.nlinfit.Par(1));
        fprintf(fid,'%s\r\n','FCd');
        fprintf(fid,'%4.2f\r\n',Results.nlinfit.Par(2));
        fprintf(fid,'%s\r\n','Tau');
        fprintf(fid,'%4.2f\r\n',Results.nlinfit.Par(3));
    catch
    end
    try
        getfield(Results,'nlinfit.gof')
        fprintf(fid,'%s\r\n','R^2');
        fprintf(fid,'%4.2f\r\n',Results.nlinfit.gof(1));
        fprintf(fid,'%s\r\n','SSE');
        fprintf(fid,'%4.2f\r\n',Results.nlinfit.gof(2));
    catch
    end
    try
        getfield(Results,'STFT')
        fprintf(fid,'        %s\r\n','Short Time Fourier Transform:');
        fprintf(fid,'\r\n');
        fprintf(fid,'%s','Window: ');
        fprintf(fid,'%s\r\n',window_stft);
        fprintf(fid,'%s','Segment Size: ');
        fprintf(fid,'%d\r\n',segment_stft);
        fprintf(fid,'%s','Overlap: ');
        fprintf(fid,'%d\r\n',overlap_stft);
        fprintf(fid,'\r\n')
        fprintf(fid,'%s\r\n','LFj (ms²)');
        fprintf(fid,'\r\n');
        for iter = 1:length(Results.STFT.LF)
            fprintf(fid,' %5.2f',Results.STFT.LF(iter));
%             if rem(iter,10) == 0
%                 fprintf(fid,'\r\n');
%             end
        end
        fprintf(fid,'\n\r');
        fprintf(fid,'\n\r');
        fprintf(fid,'%s\r\n','HFj (ms²)');
        fprintf(fid,'\r\n');
        for iter = 1:length(Results.STFT.HF)
            fprintf(fid,' %5.2f',Results.STFT.LF(iter));
%             if rem(iter,10) == 0
%                 fprintf(fid,'\r\n');
%             end
        end
    catch
    end
    try
        getfield(Results,'STAR')
        fprintf(fid,'        %s\r\n','Short Time Fourier Transform - Auto Regressive');
        fprintf(fid,'\r\n');
        fprintf(fid,'%s','Window: ');
        fprintf(fid,'%s\r\n',window_star);
        fprintf(fid,'%s','Segment Size: ');
        fprintf(fid,'%d\r\n',segment_star);
        fprintf(fid,'%s','Overlap: ');
        fprintf(fid,'%d\r\n',overlap_star);
        fprintf(fid,'\r\n')
        fprintf(fid,'%s\n\r','LFj (ms^2)');
        fprintf(fid,'\r\n');
        for iter = 1:length(Results.STAR.LF)
            fprintf(fid,' %5.2f',Results.STAR.LF(iter));
%             if rem(iter,10) == 0
%                 fprintf(fid,'\r\n');
%             end
        end
        fprintf(fid,'\r\n');
        fprintf(fid,'\r\n');
        fprintf(fid,'%s\r\n','HFj (ms^2)');
        fprintf(fid,'\r\n');
        for iter = 1:length(Results.STAR.HF)
            fprintf(fid,' %5.2f',Results.STAR.HF(iter));
            if rem(iter,10) == 0
                fprintf(fid,'\r\n');
            end
        end
    catch
    end
    fclose(fid);
end