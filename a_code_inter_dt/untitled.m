%%
%%%%% combine data in one cell inter3 %%%%%
clear; clc;

% mobility=30:2:60;
mobility=30:2:60;
for i = 1:length(mobility)
    num_file=numel(dir(sprintf('/volumes/Data/Data/inter3/Cell_inter3_%d_*.mat',mobility(i))));
    for j = 1 : num_file
        c1=struct2cell(load(sprintf('/volumes/Data/Data/inter3/Cell_inter3_%d_%d.mat',mobility(i),j)));
        c_cell=c1{1,1}; 
        Data_stack_inter3=(c_cell(~cellfun('isempty',c_cell(:,1))));
        Data_lattice_inter3=(c_cell(~cellfun('isempty',c_cell(:,2))));
        save(sprintf('/volumes/yoonD/RPS_data/inter3/Cell_inter3_%d_%d.mat',mobility(i),j),'Data_stack_inter3','-v7.3');
        save(sprintf('/volumes/yoonD/RPS_data/inter3/Cell_inter3_%d_%d.mat',mobility(i),j),'Data_lattice_inter3','-v7.3');
        clear c1 c_cell Data_stack_inter3 Data_lattice_inter3
    end
end

