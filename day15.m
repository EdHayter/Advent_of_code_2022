A = importdata('input15.txt');
data = split(A,{'=',',',':'});
data = cellfun(@str2num,data(:,2:2:8));

data(:,5) = sum(abs(data(:,1:2)-data(:,3:4)),2);%manhattan limit for all sensors

ctr = 0; %counter for points where beacon cannot be
y=2000000;
for x = min(data(:,1)-data(:,5))-1 : max(data(:,1) + data(:,5))+1 %make sure big enough to encompass all beacon possibilities of x
    %manhattan from all sensors
    manhattan = abs(x-data(:,1)) + abs(y-data(:,2));

    %if x,y is with manhattan distance limit of any sensor, and no beacon at x,y...
    if any(manhattan <= data(:,5)) && ~any(x==data(:,3) & y == data(:,4))
        ctr=ctr+1;
    end
end
ctr %this is slow, could vectorise but it works fine
%% pt 2
% find 2 sensors that are m1+m2+2 apart
clear dists matsums
for s1 = 1:size(data,1)
    for s2 = 1:size(data,1)
        dists(s1,s2) = abs(data(s1,1)-data(s2,1)) + abs(data(s1,2)-data(s2,2));
        matsums(s1,s2) = sum(data([s1 s2],5));
    end
end
[a,~] = ind2sub(size(dists),find(dists - matsums==2));
%find points 1 outside of sensor area for each, and find overlap
critical_sensors = data(a,:);
critical_sensors(:,5) = critical_sensors(:,5)+1;
for i = 1:4
    %generate list of coordates 1 outside of each sensor area and find intersect
    x = [critical_sensors(i,1):critical_sensors(i,1)+critical_sensors(i,5),critical_sensors(i,1):critical_sensors(i,1)+critical_sensors(i,5),...
        critical_sensors(i,1):-1:critical_sensors(i,1)-critical_sensors(i,5),critical_sensors(i,1):-1:critical_sensors(i,1)-critical_sensors(i,5)];
    y = [critical_sensors(i,2)-critical_sensors(i,5):critical_sensors(i,2),critical_sensors(i,2)+critical_sensors(i,5):-1:critical_sensors(i,2),...
        critical_sensors(i,2)-critical_sensors(i,5):critical_sensors(i,2),critical_sensors(i,2)+critical_sensors(i,5):-1:critical_sensors(i,2)];
    if i ==1,xy=[x',y']; 
    else
        xy = intersect(xy,[x',y'],'rows');
    end
end
xy(1)*4e6 + xy(2)

%% visualise sensor areas
hold off, scatter(data(:,1),data(:,2)),hold on
for i = [16 1 18 5]
patch([data(i,1),data(i,1)+data(i,5),data(i,1),data(i,1)-data(i,5)],...
    [data(i,2)-data(i,5),data(i,2),data(i,2)+data(i,5),data(i,2)],'red')
end
grid minor
ylim([0 4e6]),xlim([0 4e6])


