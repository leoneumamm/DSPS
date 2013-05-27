function My_Callback()
myhandles = guidata(gcbo);
myhandles.numberOfErrors = myhandles.numberOfErrors + 1;
guidata(gcbo,myhandles) 
end