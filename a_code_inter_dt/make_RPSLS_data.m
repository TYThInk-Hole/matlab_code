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
% parfor i = 1:16
%     mobility=mobility_step(i);
%     intra=[3.3, 5.65, 6.5, 100,2.2,3.3,9.3,100];
%     for j=1:8
%         if j < 5
%             intra3=intra(j);
%             RPSLS_intra_individual_L(300,0,180000,1,1,mobility,1.9,2.0,intra3,1.3,0.7)
%         else
%             intra5=intra(j);
%             RPSLS_intra_individual2_L(300,0,180000,1,1,mobility,0.3,1.1,2.5,0.7,intra5)
%         end
%     end
% end

%%%%% data for inter %%%%%

% intra=[3.3,5.65,6.5,100];
% mobility=60:20:120;
% [x,y]=meshgrid(intra,mobility);
%
% parfor i = 1:13
%
%     mobility=mobility_step(i);
%     RPS_inter_individual(300,0,180000,1,1,mobility)
%
% end

%%
%%%%% make intra3
clear; close all; clc
intra=[2.5,5.2,100];
mobility=60:5:120;
[I,M]=meshgrid(intra,mobility);
for j = 1:4
    parfor i = 9*(j-1)+1:9*j
        RPS_intra_individual(300,0,180000,1000,1,1,M(i),I(i),1.0,0.5)
    end
end