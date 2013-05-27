function [Time, iRR] = selectsignal(Time,iRR,select_type,ax)
iRR_temp = iRR;
Time_temp = Time;
switch select_type
    
    case 'Time'
        prompt = {'Begin (s)','End (s)'};
        dlg_title = 'Range Selection Parameters';
        num_lines = 1;
        def = {'0',num2str(fix(Time(end)))};
        answer = inputdlg(prompt,dlg_title,num_lines,def);
        
        start = str2double(answer{1});
        stop = str2double(answer{2});
        if start < 0 || start > Time(end),
            er = errordlg('The Range Not Understood! Try Again','Range Error');
            uiwait(er)
            [Time, iRR] = selectsignal(Time,iRR,'Time');
        elseif stop > Time(end),
            er = errordlg('The Range is Too Big! Try Again','Range Error');
            uiwait(er)
            [Time, iRR] = selectsignal(Time,iRR,'Time');
        else
            iRR = iRR(find(Time >= start,1):find(Time >= stop,1));
            Time = Time(find(Time >= start,1):find(Time >= stop,1));
        end
    case 'Plot'
        axes(ax)
        plot(Time,iRR,'k')
        axis tight
        xlabel('Time (s)')
        ylabel('iRR (ms)')
        title('Tachogram')
        [Points,Values] = ginput(2);
        if Points(1) < Time(1) || Points(2) < Time(1) || Points(1) >...
                Time(end) || Points(2) > Time(end),
            er = errordlg('The Range Not Understood! Try Again','Range Error');
            uiwait(er)
            [Time, iRR] = selectsignal(Time,iRR,'Plot');
        else
            iRR = iRR(find(Time >= Points(1),1):find(Time >= Points(2),1));
            Time = Time(find(Time >= Points(1),1):find(Time >= Points(2),1));
        end
    case 'ViewTime'
        button = questdlg('Select by View First ?','Options','Yes','No','Yes');
        switch button
            case 'Yes'
                axes(ax)
                plot(Time,iRR,'k')
                axis tight
                xlabel('Time (s)')
                ylabel('iRR (ms)')
                title('Tachogram')
                [Points,Values] = ginput(1);
                prompt = {'End (s)'};
                dlg_title = 'Range Selection Parameters';
                num_lines = 1;
                def = {num2str(fix(Time(end)) - Points)};
                answer = inputdlg(prompt,dlg_title,num_lines,def);
                stop = str2double(answer{1});
                if Points + stop > Time(end),
                    er = errordlg('The Range is Too Big! Try Again','Range Error');
                    uiwait(er)
                    [Time, iRR] = selectsignal(Time,iRR,'ViewTime');
                    
                else
                    
                    iRR = iRR(find(Time >= Points(1),1):find(Time >= Points(1) + stop,1));
                    Time = Time(find(Time >= Points(1),1):find(Time >= Points(1) + stop,1));
                end
            case 'No'
                prompt = {'Begin (s)'};
                dlg_title = 'Range Selection Parameters';
                num_lines = 1;
                def = {'0'};
                answer = inputdlg(prompt,dlg_title,num_lines,def);
                start = str2double(answer{1});
                axes(ax)
                plot(Time,iRR,'k')
                axis tight
                xlabel('Time (s)')
                ylabel('iRR (ms)')
                title('Tachogram')
                [Points,Values] = ginput(1);
                iRR = iRR(find(Time >= start,1):find(Time >= Points(1),1));
                Time = Time(find(Time >= start,1):find(Time >= Points(1),1));
        end
end
axes(ax)
plot(Time_temp,iRR_temp,'w')
size_axis = get(gca,'Ylim');
patch([Time(1) Time(end) Time(end) Time(1)],[min(size_axis) min(size_axis),...
    max(size_axis) max(size_axis)],[1,1,0.4]);
hold on
plot(Time,iRR,'k')
plot(Time_temp,iRR_temp,'k')
xlabel('Time (s)')
ylabel('RRi (ms)')
title('Tachogram')
axis tight
hold off

end