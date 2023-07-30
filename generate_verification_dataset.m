load('test', 'ans');

encryp = combvec([0 1 2 3], ...         %Section0 Fault
                 [0 1 2 3], ...         %Section2 Fault
                 [0 1 2 3], ...         %Section4 Fault
                 [0 1])';               %Sympathetic trip
     
[r_ans, c_ans] = size(ans);
ans = ans(2:r_ans,901:c_ans-1);
argument_matrix = [ans(r_ans-1,:); ans(r_ans-2,:); ans(r_ans-3,:); ans(r_ans-4,:)]';
[rows, columns] = size(argument_matrix);

out = [];
for j = 1:rows
    out = [out, find(ismember(encryp, argument_matrix(j,:) , 'rows'))];
end
ans = round(ans(:,:),4);
ans = [ans(1:18,:); out];


[r2, c2] = size(ans);

delete predict_dataset.h5
h5create("predict_dataset.h5","/predict_dataset",[r2 c2]);
h5write("predict_dataset.h5","/predict_dataset",ans);