function [SD1T, SD2T] = poinc1(data,rmssd,sdnn)

if nargin == 1,
    rmssd = rootms(diff(data));
    sdnn = std(data);
else
end

SD1T=sqrt((rmssd.^2)/2);
SD2T=sqrt((2*sdnn.^2)-SD1T);


end









