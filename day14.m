f = 'input14.txt';
opts = detectImportOptions(f);
opts.DataLines(1)=1;
opts.Delimiter{2} = '->';
data = readtable(f,opts);
data = str2double(data{:,:});

area = zeros(200,1000);

for r = 1:size(data,1)
    for c = 1:2:size(data,2)-2
        x = data(r,[c+1 c+3])+1;
        y = data(r,[c c+2]);
        if ~isnan(x(1))
            area(min(x):max(x),min(y):max(y)) = 1;
        end
    end
end
areat = area;
%imshow(area), keyboard
sand_counter = 0;

fin = 0;
while ~fin
sand = [1,500]; %initialise sand
stop = 0;
while ~stop && sand(1)<200
    if area(sand(1) + 1, sand(2)) == 0
        sand = sand + [1 0];
    elseif area(sand(1) + 1, sand(2) - 1) == 0
        sand = sand + [1 -1];
    elseif area(sand(1) + 1, sand(2) + 1) == 0
        sand = sand + [1 1];
    else 
        stop = 1;
    end
end
if stop
    area(sand(1),sand(2)) = 1;
    sand_counter = sand_counter + 1;
else 
    fin = 1;
end
%imshow(area),drawnow
end
sand_counter
%% pt 2
area=areat;
area(max(find(sum(area,2)))+2,:)=1;

sand_counter = 0;

fin = 0;
while ~fin
sand = [1,500]; %initialise sand
stop = 0;
while ~stop && area(1,500)==0
    if area(sand(1) + 1, sand(2)) == 0
        sand = sand + [1 0];
    elseif area(sand(1) + 1, sand(2) - 1) == 0
        sand = sand + [1 -1];
    elseif area(sand(1) + 1, sand(2) + 1) == 0
        sand = sand + [1 1];
    else 
        stop = 1;
    end
end
if stop
    area(sand(1),sand(2)) = 1;
    sand_counter = sand_counter + 1;
else 
    fin = 1;
end
%imshow(area),drawnow
end
sand_counter
