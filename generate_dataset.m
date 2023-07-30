%rng('default');

combinations = combvec([0 1 2 3], ...   %Section0 Fault    
                       [0 1 2 3], ...   %Section2 Fault    
                       [0 1 2 3])';     %Section4 Fault   
                         
encryp = combvec([0 1 2 3], ...         %Section0 Fault
                 [0 1 2 3], ...         %Section2 Fault
                 [0 1 2 3], ...         %Section4 Fault
                 [0 1])';               %Sympathetic trip

iter = size(combinations);

sub_iter = 10;

Section3_Breaker_Ctrl = linspace(0.5-0.02,0.5,sub_iter);

set_param('sympathetic_trip/SG Fault Section0', 't', '[0, 0.5, 0.7]');
set_param('sympathetic_trip/SG Fault Section2', 't', '[0, 0.5, 0.7]');
set_param('sympathetic_trip/SG Fault Section4', 't', '[0, 0.5, 0.7]');

for step = 1 : 1 : iter(1)
   set_param('sympathetic_trip/Section0 Fault Type', 'Value', num2str(combinations(step,1)));
   set_param('sympathetic_trip/Section2 Fault Type', 'Value', num2str(combinations(step,2)));
   set_param('sympathetic_trip/Section4 Fault Type', 'Value', num2str(combinations(step,3)));
   
   set_param('sympathetic_trip/to_File', 'FileName', ['temp']);
   
   accum = [];
   
   for i = 1 : 1 : sub_iter      
       set_param('sympathetic_trip/Section3 Breaker Ctrl', 'Time', num2str(Section3_Breaker_Ctrl(i)));
         
       set_param('sympathetic_trip','SimulationCommand','Update');
       sim('sympathetic_trip');
       
       load('temp', 'ans');
       [r_ans, c_ans] = size(ans);
       ans = ans(2:r_ans,901:c_ans-1);
       
       argument_matrix = [ans(r_ans-1,:); ans(r_ans-2,:); ans(r_ans-3,:); ans(r_ans-4,:)]';
       [rows, columns] = size(argument_matrix);
       out = [];
       for j = 1:rows
            out = [out, find(ismember(encryp, argument_matrix(j,:) , 'rows'))];
       end     
       ans = [ans(1:18,:); out];   
       accum = [accum ans];
       disp(['subtest' num2str(i)])
   end
   save([num2str(step+100)],"accum");
end