function [Confidence_interval] = montecarlosim(coeff,Time,SSE)

model = @(par,t) par(1) + par(2).*exp(-t/par(3));
curve1 = model(coeff,Time);
p0 = coeff;

par = zeros(1000,3);
for iter = 1:1000,
    st_deviation = sqrt(SSE/(length(Time) - 3));
    curve = curve1 + st_deviation*randn(size(curve1));    
    par(iter,:) = nlinfit(Time,curve,model,p0);
    p0 = par(iter,:);
    SSE = sum((curve - model(par(iter,:),Time)).^2);
end
F0_coeff = sort(par(:,1));
FCdelta_coeff = sort(par(:,2));
Tau_coeff = sort(par(:,3));
F0_coeff = F0_coeff(25:950);

FCdelta_coeff = FCdelta_coeff(25:950);

Tau_coeff = Tau_coeff(25:950);
FC0_CI = [F0_coeff(1),F0_coeff(2)];
FCdelta_CI = [FCdelta_coeff(1),FCdelta_coeff(2)];
Tau_CI = [Tau_coeff(1),Tau_coeff(2)];
Confidence_interval = [FC0_CI,FCdelta_CI,Tau_CI];
end