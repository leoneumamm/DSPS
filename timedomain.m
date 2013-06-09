function [RMSSD,pNN50,SDNN,SD1,SD2] = timedomain(iRR)

RMSSD = sqrt(sum(diff(iRR).*(diff(iRR)))/size(diff(iRR),1));
pNN50_control = gradient(iRR) >= 50;
pNN50 = (sum(pNN50_control)/length(iRR))*100;
SDNN = std(iRR);
[SD1, SD2] = poinc1(iRR);

end
