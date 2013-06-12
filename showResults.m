function showResults(values,resType)
switch resType
    case 'TD'
    rt = uicontrol('Style','Text','String','Results','Position',[600,330,280,25],'FontSize',12,'FontWeight','bold');
    rt = uicontrol('Style','Text','String','Time Domain','Position',[600,305,280,25],'FontWeight','bold');
    rt = uicontrol('Style','Text','String',['------------------------------',....
        '----------------------------------------'],'Position',[600,295,280,20],'FontWeight','bold','HorizontalAlignment','left');
    rt = uicontrol('Style','Text','String','RMSSD (ms)  69'   ,'Position',[600,279.7,280,20],'HorizontalAlignment','left');
    rt = uicontrol('Style','Text','String','SDNN (ms)  69'   ,'Position',[600,259.7,280,20],'HorizontalAlignment','left');
    rt = uicontrol('Style','Text','String','pNN50 (%)  69'   ,'Position',[600,239.7,280,20],'HorizontalAlignment','left');
    rt = uicontrol('Style','Text','String','Average RRi (ms)  69'   ,'Position',[600,219.7,280,20],'HorizontalAlignment','left');
    rt = uicontrol('Style','Text','String','Average HR (ms)  69'   ,'Position',[600,199.7,280,20],'HorizontalAlignment','left');
    rt = uicontrol('Style','Text','String','SD1 (ms)  69'   ,'Position',[600,179.7,280,20],'HorizontalAlignment','left');
    rt = uicontrol('Style','Text','String','SD2 (ms)  69'   ,'Position',[600,159.7,280,20],'HorizontalAlignment','left');
    rt = uicontrol('Style','Text','String','SD1/SD2 (ms)  69'   ,'Position',[600,139.7,280,20],'HorizontalAlignment','left');
end
end
