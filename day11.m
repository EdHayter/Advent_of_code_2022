file = 'input11.txt';
opts = detectImportOptions(file);
opts.DataLines(1)=1;
data = readtable(file,opts);

for i =1:8 %prep monkey variables
    items{i} = str2num(data.Var2{(i-1)*6+2});
    ind = regexp(data.Var2{(i-1)*6+4},'\d+');
    test(i) = str2double(data.Var2{(i-1)*6+4}(ind:end));
    monkeys(i,:) = [str2double(data.Var2{(i-1)*6+5}(end)),str2double(data.Var2{(i-1)*6+6}(end))];
end
monkeys = monkeys+1; %matlab 1 indexing for ease
inspections = zeros(8,1);

for ctr = 1:20
    for mi = 1:8 %monkey index
        switch mi %later improve with no hard coding!
            case 1
                items{mi} = floor(items{mi}*7/3);
            case 2
                items{mi} = floor((items{mi} + 4)/3);
            case 3
                items{mi} = floor(items{mi}*5/3);
            case 4
                items{mi} = floor(items{mi} .* items{mi} / 3);
            case 5
                items{mi} = floor((items{mi} + 1)/3);
            case 6
                items{mi} = floor((items{mi} + 8)/3);
            case 7
                items{mi} = floor((items{mi} + 2)/3);
            case 8
                items{mi} = floor((items{mi} + 5)/3);
        end
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

for i =1:8 %prep monkey variables
    items{i} = str2num(data.Var2{(i-1)*6+2});
    ind = regexp(data.Var2{(i-1)*6+4},'\d+');
    test(i) = str2double(data.Var2{(i-1)*6+4}(ind:end));
    monkeys(i,:) = [str2double(data.Var2{(i-1)*6+5}(end)),str2double(data.Var2{(i-1)*6+6}(end))];
end
monkeys = monkeys+1; %matlab 1 indexing for ease
inspections = zeros(8,1);

for ctr = 1:10000
    for mi = 1:8 %monkey index
        switch mi %later improve with no hard coding!
            case 1
                items{mi} = floor(items{mi}*7);
            case 2
                items{mi} = floor((items{mi} + 4));
            case 3
                items{mi} = floor(items{mi}*5);
            case 4
                items{mi} = floor(items{mi} .* items{mi});
            case 5
                items{mi} = floor((items{mi} + 1));
            case 6
                items{mi} = floor((items{mi} + 8));
            case 7
                items{mi} = floor((items{mi} + 2));
            case 8
                items{mi} = floor((items{mi} + 5));
        end
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



