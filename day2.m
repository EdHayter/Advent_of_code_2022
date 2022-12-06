readtable('input2.txt','readvariablenames',0);
data = table2array(ans);

data=cell2mat(data);
data=double(data);
points = data(:,2)-87;
wins = (data(:,2) - data(:,1) == 24 | data(:,2)-data(:,1)==21) * 6;
draws = (data(:,2) - data(:,1) == 23) * 3;
points = points + wins + draws;
sum(points)

%% pt 2

wins = (data(:,2) == 90)*6;
draws = (data(:,2) == 89)*3;
idx = zeros(2500,1);
idx(data(:,2)==90)=1;
idx(data(:,2)==88)=-1;
points = data(:,1) - 64 + idx;
points = mod(points-1,3)+1 + wins + draws;
sum(points)
