A = importdata('input12.txt');
data=char(A);
data = double(data);
data = padarray(data,[1,1],150); %pad to avoid 0 referencing
[row, col] = ind2sub(size(data),find(data==83)); %start
visited = [row col];
[target(1), target(2)] = ind2sub(size(data),find(data==69)); %end
data(visited(1),visited(2)) = 97; %assign heights to S/E
data(target(1),target(2)) = 122;
distances = 0;
ctr = 1; %loop counter
found = 0;


while ~found
    possible_nodes = [];
    for i = 1:size(visited,1) %find traversable nodes, this is slow (repeats nodes) but fine
        if data(visited(i,1)+1,visited(i,2)) <= data(visited(i,1),visited(i,2))+1
            possible_nodes(end+1,:) = [visited(i,1)+1,visited(i,2)];
        end
        if data(visited(i,1)-1,visited(i,2)) <= data(visited(i,1),visited(i,2))+1
            possible_nodes(end+1,:) = [visited(i,1)-1,visited(i,2)];
        end
        if data(visited(i,1),visited(i,2)+1) <= data(visited(i,1),visited(i,2))+1
            possible_nodes(end+1,:) = [visited(i,1),visited(i,2)+1];
        end
        if data(visited(i,1),visited(i,2)-1) <= data(visited(i,1),visited(i,2))+1
            possible_nodes(end+1,:) = [visited(i,1),visited(i,2)-1];
        end
    end
    %remove already visited nodes & duplicates
    possible_nodes = possible_nodes(~ismember(possible_nodes,visited,'rows'),:);
    possible_nodes = unique(possible_nodes,'rows');

    %update node list with distances to each
    visited = cat(1,visited,possible_nodes);
    distances = cat(1,distances,repmat(ctr,[size(possible_nodes,1),1]));

    if ismember(target,visited,'rows')
        found = 1;
        ctr
    end
    ctr = ctr + 1; %update loop counter
end
% [~,i] = ismember(target,visited,'rows');
% distances(i)

%%
data=char(A);
data = double(data);
data = padarray(data,[1,1],0); %pad to avoid 0 referencing
[row,col] = ind2sub(size(data),find(data==69)); %start - step down from top
visited = [row,col];
data(visited(1),visited(2)) = 122 ; %assign heights to S/E
distances = 0;
found = 0;
ctr = 1; %loop counter

while ~found
    possible_nodes = [];
    for i = 1:size(visited,1) %find traversable nodes, this is slow (repeats nodes) but fine
        if data(visited(i,1)+1,visited(i,2)) >= data(visited(i,1),visited(i,2))-1
            possible_nodes(end+1,:) = [visited(i,1)+1,visited(i,2)];
        end
        if data(visited(i,1)-1,visited(i,2)) >= data(visited(i,1),visited(i,2))-1
            possible_nodes(end+1,:) = [visited(i,1)-1,visited(i,2)];
        end
        if data(visited(i,1),visited(i,2)+1) >= data(visited(i,1),visited(i,2))-1
            possible_nodes(end+1,:) = [visited(i,1),visited(i,2)+1];
        end
        if data(visited(i,1),visited(i,2)-1) >= data(visited(i,1),visited(i,2))-1
            possible_nodes(end+1,:) = [visited(i,1),visited(i,2)-1];
        end
    end
    %remove already visited nodes & duplicates
    possible_nodes = possible_nodes(~ismember(possible_nodes,visited,'rows'),:);
    possible_nodes = unique(possible_nodes,'rows');

    %update node list with distances to each
    visited = cat(1,visited,possible_nodes);
    distances = cat(1,distances,repmat(ctr,[size(possible_nodes,1),1]));
  
    if any(data(sub2ind(size(data),visited(:,1),visited(:,2)))==97) % when first a is found, stop
        found = 1;
        ctr
    end
    ctr = ctr + 1; %update loop counter
end

