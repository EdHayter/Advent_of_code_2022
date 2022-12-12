% new attempt with better generalisation - no hard coding for operations
file = 'input11.txt';
opts = detectImportOptions(file);
opts.DataLines(1)=1;
data = readtable(file,opts);
data.Var2{strcmp(data.Var2,'new = old * old')} = 'new = old .* old'; 


for i =1:8 %prep monkey variables
    items{i} = str2num(data.Var2{(i-1)*6+2}); item_save = items;
    ind = regexp(data.Var2{(i-1)*6+4},'\d+');
    test(i) = str2double(data.Var2{(i-1)*6+4}(ind:end));
    monkeys(i,:) = [str2double(data.Var2{(i-1)*6+5}(end)),str2double(data.Var2{(i-1)*6+6}(end))];
    data.Var2{(i-1)*6+3}(end+1) = ';';
end
monkeys = monkeys+1; %matlab 1 indexing for ease
inspections = zeros(8,1);

for ctr = 1:20
    for mi = 1:8 %monkey index
        old = items{mi};
        eval(data.Var2{(mi-1)*6+3});
        items{mi} = floor(new/3);
        for ii = 1:length(items{mi})
            if mod(items{mi}(ii),test(mi))==0
                items{monkeys(mi,1)}(end+1) = items{mi}(ii);
            else
                items{monkeys(mi,2)}(end+1) = items{mi}(ii);
            end
        end
        inspections(mi) = inspections(mi) + length(items{mi});
        items{mi} = [];
    end
end
sort(inspections);
ans(end-1)*ans(end)

%% pt 2

items = item_save;
inspections = zeros(8,1);

for ctr = 1:10000
    for mi = 1:8 %monkey index
        old = items{mi};
        eval(data.Var2{(mi-1)*6+3});
        items{mi} = new;
        items{mi} = mod(items{mi},prod(test));
        for ii = 1:length(items{mi})
            if mod(items{mi}(ii),test(mi))==0
                items{monkeys(mi,1)}(end+1) = items{mi}(ii);
            else
                items{monkeys(mi,2)}(end+1) = items{mi}(ii);
            end
        end
        inspections(mi) = inspections(mi) + length(items{mi});
        items{mi} = [];
    end
end
sort(inspections);
ans(end-1)*ans(end)



