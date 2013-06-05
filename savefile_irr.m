function savefile_irr(iRR)
[File,Path] = uiputfile('*.txt','Save RRi Dialog');
fRRi = fopen([Path,File],'w');
for iter = iRR
    fprintf(fRRi,'%e\r\n',iter);
end
fclose(fRRi);
end
