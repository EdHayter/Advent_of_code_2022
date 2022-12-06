instructions = readtable('input5.txt');
fid = fopen('input5.txt');
fread(fid,500); 
ans(2:4:500);
char(ans');
reshape(ans(1:72),[9,8])';
ans(end:-1:1,:)';
t = cellstr(ans); t2=t;
fclose(fid);
for i = 1:size(instructions,1)
    num = instructions.Var2(i);
    t{instructions.Var6(i)} = [t{instructions.Var6(i)},t{instructions.Var4(i)}(end:-1:end-num+1)];
    t{instructions.Var4(i)} = t{instructions.Var4(i)}(1:end-num);
end
for i = 1:9
    out(i) = t{i}(end);
end
out
%% pt2 
t=t2;
for i = 1:size(instructions,1)
    num = instructions.Var2(i);
    t{instructions.Var6(i)} = [t{instructions.Var6(i)},t{instructions.Var4(i)}(end-num+1:end)];
    t{instructions.Var4(i)} = t{instructions.Var4(i)}(1:end-num);
end
for i = 1:9
    out(i) = t{i}(end);
end
out