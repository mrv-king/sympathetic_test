% 380 samples x 148 signal types
% train data:       304 samples
% validation data:  76 samples
clear;
main_accum = [];

for step = 1 : 1 : 128
    load(num2str(step), 'accum');
    accum_u = unique(accum(19,:));
    count = arrayfun(@(i)numel(find(accum(19,:)==accum_u(i))),1:numel(accum_u));
    output = [accum_u;count];
    main_accum = [main_accum output];
end

main_accum = main_accum';
amount = main_accum(:,2);

[uniqueData, firstInd, allInd] = unique(main_accum(:,1));
for i = 1:numel(firstInd)
    total(i) = sum(amount(allInd == i));
end

statistic = [uniqueData total'];
Q = quantile(statistic(:,2),0.01);
stat_filtered = statistic(statistic(:,2)>=Q,:);

N = min(stat_filtered(:,2));
indexes = stat_filtered(:,1)';

counter = zeros(2, 128, 'int16');

counter(1,indexes) = indexes;

train_dataset = [];
test_dataset = [];


data_accum = [];

for step = 1 : 1 : 128
    load(num2str(step), 'accum');
    data_accum = [data_accum accum];
end

data_accum_columns = size(data_accum,2);
columns_permut = randperm(data_accum_columns);
data_accum = data_accum(:,columns_permut);

for step = 1 : 1 : data_accum_columns
    if ismember(data_accum(19,step), counter(1,:))
        if counter(2,data_accum(19,step)) < N*0.8
            train_dataset = [train_dataset data_accum(:,step)];
            counter(2,data_accum(19,step)) = counter(2,data_accum(19,step)) + 1;
        elseif counter(2,data_accum(19,step)) < N
            test_dataset = [test_dataset data_accum(:,step)];
            counter(2,data_accum(19,step)) = counter(2,data_accum(19,step)) + 1;
        end
    end
end

data_accum_columns = size(train_dataset,2);
columns_permut = randperm(data_accum_columns);
train_dataset = train_dataset(:,columns_permut);

%train_dataset = sortrows(train_dataset.',19).';
test_dataset = sortrows(test_dataset.',19).';

train_dataset = [round(train_dataset(1:18,:),4); train_dataset(19,:)];
test_dataset = [round(test_dataset(1:18,:),4); test_dataset(19,:)];

[r1, c1] = size(train_dataset);
[r2, c2] = size(test_dataset);

delete train_dataset.h5 test_dataset.h5

h5create("train_dataset.h5","/train_dataset",[r1 c1]);
h5create("test_dataset.h5","/test_dataset",[r2 c2]);

h5write("train_dataset.h5","/train_dataset",train_dataset);
h5write("test_dataset.h5","/test_dataset",test_dataset);