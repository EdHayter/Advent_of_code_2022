opts = detectImportOptions('input8.txt');
opts.VariableTypes = 'char';
data = readtable('input8.txt',opts);
data = char(table2array(data));
data = double(data)-48;

visible = zeros(99);
visible(:,1) = 1;
visible(:,end) = 1;
visible(1,:) = 1;
visible(end,:) = 1;
for x = 2:98
    for y = 2:98
        visible(x,y) = all(data(x,y) > data(x+1:end,y)) | ...
            all(data(x,y) > data(1:x-1,y)) | ...
            all(data(x,y) > data(x,y+1:end)) | ...
            all(data(x,y) > data(x,1:y-1));
    end
end
sum(sum(visible))

%% pt 2
score = zeros(99);
for x = 2:98 %all outer trees will have 0 scenic score
    for y = 2:98
        i = x-1;
        while i~=1 && data(x,y) > data(i,y), i=i-1; end
        temp_score(1) = x-i;
        i = x+1;
        while i~=99 && data(x,y) > data(i,y), i=i+1; end
        temp_score(2) = i-x;
        i = y-1;
        while i~=1 && data(x,y) > data(x,i), i=i-1; end
        temp_score(3) = y-i;
        i = y+1;
        while i~=99 && data(x,y) > data(x,i), i=i+1; end
        temp_score(4) = i-y;
        score(x,y) = prod(temp_score);
    end
end
max(max(score))