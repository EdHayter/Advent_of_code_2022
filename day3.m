A = importdata('input3.txt');

for i = 1:300
    t = char(A(i));
    t1 = t(1:length(t)/2);
    t2 = t(length(t)/2+1:end);
    item = intersect(t1,t2);
    priority = double(item)-96;
    if priority < 0
        priority = priority + 58;
    end
    priorities(i) = priority;
end
sum(priorities)

%% pt2 
clear priorities
for i = 1:3:300
    item = intersect(intersect(char(A(i)),char(A(i+1))),char(A(i+2)));
     priority = double(item)-96;
    if priority < 0
        priority = priority + 58;
    end
    priorities(i) = priority;
end
sum(priorities)