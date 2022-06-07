function S = sub_allchildren(T, root_id)
% recursively finds IDs of all children of the given root element

S = T{root_id}.contents;
for i = S
    S = [S sub_allchildren(T, i)];
end
