function [LF,HF,VLF,LFnu,HFnu,LF_HF,TotalPower,bands] = psdintegral(F,Pxx)

prompt = {'LF Band','HF Band:','VLF Band:'};
dlg_title = 'Energy Over Bands Parameters';
num_lines = 1;
def = {'0.04 - 0.15','0.14 - 0.4','< 0.04'};
answer = inputdlg(prompt,dlg_title,num_lines,def);

start_lf = str2double(answer{1}(1:4));
stop_lf = str2double(answer{1}(8:end));
start_hf = str2double(answer{2}(1:4));
stop_hf = str2double(answer{2}(8:end));
start_vlf = 1;
stop_vlf = str2double(answer{3}(2:end));
bands = [answer{1}(1:4),answer{1}(8:end),answer{2}(1:4),answer{2}(8:end),'< 0.04'];
         
LF = trapz(F(find(F >= start_lf,1):find(F >= stop_lf,1)),Pxx(find(F >= start_lf,1):find(F >= stop_lf,1)));
HF = trapz(F(find(F >= start_hf,1):find(F >= stop_hf,1)),Pxx(find(F >= start_hf,1):find(F >= stop_hf,1)));
VLF = trapz(F(start_vlf:find(F >= stop_vlf,1)),Pxx(start_vlf:find(F >= stop_vlf,1)));
TotalPower = trapz(F(1:find(F >= stop_hf,1)),Pxx(1:find(F >= stop_hf,1)));
LFnu = (LF/(TotalPower - VLF)) *100;
HFnu = (HF/(TotalPower - VLF)) *100;
LF_HF = LF./HF;

end