function autoartefactremove(ECG,Fs,iRR_pos,ref_val)
ecg_time = [0:length(ECG)-1]/Fs;
iRR = diff(ecg_time(iRR_pos)*1000);
control = iRR_pos(find(iRR < ref_val));
if ~isempty(control)
    if control(1) ~= iRR_pos(1) && control(end) ~= iRR_pos(end)
        for iter = 1:length(control)
            pos_plot_bef(iter) = iRR_pos(find(iRR_pos == control(iter))-1);
            pos_plot_aft(iter) = iRR_pos(find(iRR_pos == control(iter))+1);
        end
    else
        cont = 1;
        for iter = 2:length(control) - 1
            pos_plot_bef(cont) = iRR_pos(find(iRR_pos == control(iter))-1);
            pos_plot_aft(cont) = iRR_pos(find(iRR_pos == control(iter))+1);
            cont = cont + 1;
        end
    end
    pos_plot = sort([pos_plot_bef,pos_plot_aft,control]);
    disp(pos_plot)
    plot(ecg_time,ECG,'k')
    hold on
    plot(ecg_time(iRR_pos),ECG(iRR_pos),'g.-')
    %plot(ecg_time(pos_plot),ECG(pos_plot),'r-')
    plot(ecg_time(pos_plot),ECG(pos_plot),'r.-')
    xlabel('Time (s)')
    ylabel('Volts (v)')
    title('RRi Detection')
    axis tight
    hold off
end
end
