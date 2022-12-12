data = char(importdata('input6.txt'));
markers =[];
for i = 4:length(data)
    t = data(i-3:i);
    if length(unique(t))==4
        markers(end+1)=i;
    end
end
min(markers)

%% pt2 
markers =[];
for i = 14:length(data)
    t = data(i-13:i);
    if length(unique(t))==14
        markers(end+1)=i;
    end
end
markers