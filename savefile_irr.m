prompt = {'Enter File Name:'};
dlg_title = 'Save Dialog';
num_lines = 1;
def = {'.txt'};
Name = inputdlg(prompt,dlg_title,num_lines,def);
save(Name{1}, 'iRR', '-ASCII');
