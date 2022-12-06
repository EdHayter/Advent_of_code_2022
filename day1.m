data=nan;
fid = fopen('input1.txt');
while ~feof(fid)
    line = fgetl(fid);
    if ~isempty(line) 
        data(end+1) = str2num(line);
    else
        data(end+1)=nan;
    end
end
data=[data';nan]; fclose(fid);

nans = find(isnan(data));
for i = 1:sum(isnan(data))-1
    t(i) = nansum(data(nans(i):nans(i+1)));
end
max(t)

t = sort(t);
sum(t(end-2:end))
