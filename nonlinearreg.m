function Coeff = nonlinearreg(Time,iRR,ax)
FC = 60./(iRR/1000);
p0 = [min(FC),max(FC) - min(FC),Time(find(FC >= .36*max(FC),1))];
model = @(par,t) par(1) + par(2).*exp(-t/par(3));
Coeff = nlinfit(Time,FC,model,p0);
Curve = model(Coeff,Time);
R = corrcoef(iRR,Curve);
R2 = R(2)^2;
SSE = sum((iRR - Curve).^2);
Coeff = [Coeff, R2,SSE];
axes(ax)
plot(Time,FC,'k.')
hold on
plot(Time,Curve,'r')
xlabel('Time (s)')
ylabel('HR (min^-^1)')
title('First Order Exponential Regression')
legend('Samples','Fit')
axis tight
hold off
end
