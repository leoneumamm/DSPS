function figproperties(what,where)
if strcmp(what,'pan')
    pan(where)
elseif strcmp(what,'zoomon')
   zoom(where,'on');    
elseif strcmp(what,'zoomoff')
    zoom(where,'off');
elseif strcmp(what,'lim')
    prompt = {'X-axis Lower Limit:','X-axis Upper Limit:','Y-axis Lower Limit'...
        ,'Y-axis Upper Limit'};
    dlg_title = 'Figure Properties';
    num_lines = 1;
    indx1 =num2str(min(get(where,'xlim')));
    indx2 =num2str(max(get(where,'xlim')));
    indy1 =num2str(min(get(where,'ylim')));
    indy2 =num2str(max(get(where,'ylim')));
    def = {indx1,indx2,indy1,indy2};
    answer = inputdlg(prompt,dlg_title,num_lines,def);
    xl1 = str2double(answer{1});
    xl2 = str2double(answer{2});
    yl1 = str2double(answer{3});
    yl2 = str2double(answer{4});
    set(where,'xlim',[xl1,xl2]);
    set(where,'ylim',[yl1,yl2]);
end
end
