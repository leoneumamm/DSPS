function [Index,RMSSD,pNN50,SDNN,average,segment,overlap,P] = timevarying(iRR,Time)

prompt = {'Enter Segment Size:','Enter Overlap Size:'};
dlg_title = 'Time-Varying Parameters';
num_lines = 1;
def = {'30','0'};
answer = inputdlg(prompt,dlg_title,num_lines,def);
Time_min = min(Time);
Time = Time - Time_min;
segment = str2double(answer{1});
overlap = str2double(answer{2});
start = 0;
stop = segment;
forward = segment - overlap;

P = fix((Time(end) - segment)/forward + 1); % Number of iteration based on
                                            % segment and overlap.

for iter = 1:P

    iRR_temp = iRR(find(Time >= start,1):find(Time >= stop,1));
    RMSSD(iter) = rootms(diff(iRR_temp));
    pNN50_control = gradient(iRR_temp) >= 50;
    pNN50(iter) = (sum(pNN50_control)/length(iRR_temp))*100;
    SDNN(iter) = std(iRR_temp);
    average(iter) = mean(iRR_temp);

    Index(iter) = start;
    start = start + forward;
    stop = stop + forward;

end
Index = Index + Time_min;
end
