data=importdata('input13.txt');

data = replace(data,'[','{');
data = replace(data,']','}');

for i = 1:length(data)/2
    s1 = eval(data{(i-1)*2+1});
    s2 = eval(data{(i-1)*2+2});
    flag(i) = compare_list(s1,s2);
end
sum(find(flag==0))


%% pt 2, need to implement some sorting algorithm i suppose

%add divider packets
data{end+1} = '{{2}}';
data{end+1} = '{{6}}';

sorted = 0;
while ~sorted
    sorted = 1;
    for i = 1:length(data)-1
        s1 = eval(data{i});
        s2 = eval(data{i+1});
        flag = compare_list(s1,s2);
        if flag == 1
            data([i i+1]) = data([i+1 i]); %easy bubble!
            sorted = 0;
        end
    end
end
find(strcmp(data,'{{6}}') | strcmp(data,'{{2}}'));
prod(ans)

%% the recursive function itself
function flag = compare_list(s1,s2)
flag = [];
for ctr = 1:max(length(s1),length(s2))
    if ctr > length(s1)
        flag = 0; break %good input
    elseif ctr > length(s2)
        flag = 1;break %bad input
    end
    if ~iscell(s1{ctr}) && iscell(s2{ctr}), s1{ctr} = s1(ctr); end
    if ~iscell(s2{ctr}) && iscell(s1{ctr}), s2{ctr} = s2(ctr); end
    if ~iscell(s1{ctr}) && ~iscell(s2{ctr})
        if s1{ctr} > s2{ctr}
            flag = 1; break
        elseif s1{ctr} < s2{ctr}
            flag = 0; break
        elseif s1{ctr} == s2{ctr}
            %ctr=ctr+1; %initially using while ~isempty(flag)
        end
    elseif isempty(s1) && ~isempty(s2)
        flag = 0;
    elseif ~isempty(s1) && isempty(s2)
        flag = 1;
    else
        flag = compare_list(s1{ctr},s2{ctr});
    end
    if ~isempty(flag),break,end
end
end
