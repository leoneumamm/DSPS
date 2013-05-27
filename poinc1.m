function [SD1T, SD2T] = poinc1(data,rmssd,sdnn)
if nargin < 3,
    rmssd = rms(diff(data));
    sdnn = std(data);
else
end
SD1T=sqrt((rmssd^2)/2);
SD2T=sqrt((2*sdnn^2)-SD1T);
% plot(data(1:end - 1),data(2:end),'k.')
% title('Poincaré Plot');
% xlabel('RRi+1(ms)');
% ylabel('RRi(ms)')

centroide1=mean(data);

el1=elipse(centroide1,centroide1, SD1T, SD1T, 45,36);
% axes(ax)
% hold on
% plot(el1(:,1), el1(:,2), '-k','LineWidth',2)
% plot(centroide1,centroide1,'.r')
% [x11,y22] = pol2cart((pi/4),SD1T);
% plot(x11+centroide1,y22+centroide1,'k','LineWidth',2);
% plot([centroide1 -x11+centroide1],[centroide1 y22+centroide1],'k','LineWidth',2)
% 
% [x33,y44] = pol2cart((pi/4),SD2T);
% plot(x33+centroide1,y44+centroide1,'k','LineWidth',2);
% 
% plot([centroide1 x33+centroide1],[centroide1 y44+centroide1],'k','LineWidth',2)
% axis equal
% hold off
end









