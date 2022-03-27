%%%%% Make RPSLS data %%%%%%

%%
%%%%% data for intra %%%%%
clear; close all; clc
intra=[3.3,5.65,6.5,100];
mobility=60:5:120;
[I,M]=meshgrid(intra,mobility);
parfor i = 1:numel(I)
    RPSLS_intra2_individual_L(300,0,120000,2000,1,1,M(i),0.3,1.1,2.5,0.7,I(i));
end

%%
%%%%% data for intra5_2
% intra1=0.3;
% intra2=1.1;
% intra3=2.5;
% intra4=0.7;
clear; close all; clc;
mobility=30:2:60;
intra=[2.2, 3.3, 9.3, 100];
[I,M]=meshgrid(intra,mobility);
for i = 1:numel(I)
    RPSLS_intra2_dindividual_L(300,0,180000,500,1,1,M(i),0.3,1.1,2.5,0.7,I(i))
end

%%
%%%%% data for inter %%%%%
clear; clc;
% intra=[3.3,5.65,6.5,100];
% mobility=60:20:120;
% [x,y]=meshgrid(intra,mobility);
mobility=30:2:60;
for i = 1:length(mobility)
    RPS_inter_individual(300,0,180000,1000,1,1,mobility(i))
end

%%
%%%%% make intra3
clear; close all; clc
intra=[2.5,5.2,100];
mobility=30:2:60;
[I,M]=meshgrid(intra,mobility);

parfor i = 1 : numel(I)
    RPS_intra_individual(300,0,180000,1000,1,1,M(i),I(i),1.0,0.5)
end
