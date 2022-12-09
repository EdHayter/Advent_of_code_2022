A = importdata('input9.txt');

H = [1,1];
T = [1,1];
T_locs = T;

for i = 1:length(A.data)
    for i2 = 1:A.data(i)
        switch A.textdata{i} %move head
            case 'U'
                H = H + [0 1];
            case 'D'
                H = H + [0 -1];
            case 'R'
                H = H + [1 0];
            case 'L'
                H = H + [-1 0];
        end
        %catch tail up after each move
        if any(abs(H-T) == 2)
            T = T + round((H-T)/2); 
            T_locs(end+1,:) = T; %inefficient, but fast enough
        end
    end
end
size(unique(T_locs,'rows'),1)

%% pt 2, need to loop over each knot in the rope
H = repmat([1 1],[10,1]); %swap from 2 variables to 1 for all knots
T_locs = [1 1];

for i = 1:length(A.data)
    for i2 = 1:A.data(i)
        switch A.textdata{i}
            case 'U'
                H(1,:) = H(1,:) + [0 1];
            case 'D'
                H(1,:) = H(1,:) + [0 -1];
            case 'R'
                H(1,:) = H(1,:) + [1 0];
            case 'L'
                H(1,:) = H(1,:) + [-1 0];
        end
        %catch tail up after each move
        for knot = 1:9
            if any(abs(H(knot,:)-H(knot+1,:)) == 2)
                H(knot+1,:) = H(knot+1,:) + round((H(knot,:)-H(knot+1,:))/2);
            end
                T_locs(end+1,:) = H(10,:);
        end
    end
end
size(unique(T_locs,'rows'),1)