A = importdata('input4.txt');
A=string(A);
data = split(A,{',','-'});
data = double(data);
(data(:,1) >= data(:,3) & data(:,2) <= data(:,4))|... 
    (data(:,1) <= data(:,3) & data(:,2) >= data(:,4));
sum(ans)

%% pt2
data(:,2) >= data(:,3) & data(:,4)>=data(:,1);
sum(ans)

