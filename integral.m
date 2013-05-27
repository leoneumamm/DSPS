function [alta,baixa] = integral(Pft,frequencia)

AF_ind = find(frequencia >= 0.15 & frequencia < 0.4);

BF_ind = find(frequencia >= 0.04 & frequencia < 0.15);




% 
% tempo=cumsum(rr);
% t=1:1/frs:tempo(end);  
% time = t(1:end-janela);
% k=find((time./60000)>=indcarga(1,pessoa).tempo(1));
% 







inc = frequencia(2)-frequencia(1);  % Incremento para garantir o espaçamento entre as frequências
for g = 1:length(Pft),
    baixa(:,g) = trapz(Pft(BF_ind,g)).*(inc);
end
for g = 1:length(Pft),
    alta(:,g) = trapz(Pft(AF_ind,g)).*(inc);
end
end


% Escala em dB.Hz!