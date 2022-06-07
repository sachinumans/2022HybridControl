function t = xml_cell_find(T, i, name)

t = false;
Ti = T{i};
if isfield(Ti, 'name')
    t = strcmp(Ti.name, name);
end
