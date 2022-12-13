% import, sort data
data = importdata('input7.txt');

directories = ["" ""];
data{end+1} = '$';

for i = 1:length(data)
    % remove text from files with sizes
    [~,e] = regexp(data{i},'\d+'); 
    if ~isempty(e), data{i} = (data{i}(1:e)); end 
end

%% main loop to iteratively condense file system and record directory sizes
while data{1}(end)=='/'
clear idx
for i = 1:length(data)
    idx(i) = contains(data{i},'$');
end
f = find(idx);
for i = 1:length(f)-1
    t = data(f(i)+1:f(i+1)-1);
    clear t_num
    for ti = 1:length(t), t_num(ti) = ~isempty(str2num(t{ti}));end
    if ~isempty(t) && sum(t_num)==length(t_num)
        directory = data{f(i-1)}(6:end);
        ctr = f(i)-1; 
        flag = 0;
        while ~flag
            flag = strcmp(data{ctr},['dir ',directory]);
            ctr=ctr-1;
            if ctr==0 
                break
            end
        end
        ctr=ctr+1;
        data{ctr} = string(sum(cellfun(@str2num,t)));
        directories(end+1,:) = [directory,data{ctr}];
        data(f(i)-1:f(i+1)-1)={'bin'};
    end
end
for i = 1:length(data)
    idx(i) = ~strcmp(data{i},'bin');
end
data=data(idx);
end

%% get answers
directories(:,2);
double(ans(2:end));
ans(ans<=100000);
sum(ans)

file_limit = str2num(directories(end,2))-40e6;
directories(:,2);
double(ans(2:end));
ans - file_limit;
ans(ans<0) = inf;
min(ans) + file_limit
