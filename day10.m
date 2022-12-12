opts = detectImportOptions('input10.txt');
opts.DataLines(1) = 1;
data = readtable('input10.txt',opts);

X = cumsum(data.Var2,'omitnan')+1;
%at end of cycle i, X is X(i)
cycle = cumsum((string(data.Var1) == 'addx') + 1); 

strength = [];
for i = 20:40:220
    t = i-cycle;
    X(t == min(t(t>0)));
    strength(end+1) = i * X(t == min(t(t>0)));
end

sum(strength)

%% pt 2
%remake X 
X = 1;
for i = 1:size(data,1)
    if strcmp(data.Var1{i},'noop')
        X(end+1) = X(end);
    else
        X(end+1) = X(end);
        X(end+1) = sum([X(end), data.Var2(i)],'omitnan');
    end
end 
X = X(2:end); %X(i) is X at END of cycle i
CRT = zeros(1,240);
for i = 1:240
    CRT(i) = mod(i-1,40)+1 >=X(i)-1 & mod(i-1,40)+1 <= X(i)+1;
end
CRT = reshape(CRT,[40,6])';
imshow(CRT)

