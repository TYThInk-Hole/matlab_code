%%
%%%%% RPS intra %%%%%
clear all; close all; clc;
% k=[0.1,1,10,0.1,1,10];%,0.2:0.2:1,0.2:0.2:1];
m=[2.5,5.2,100,2.5,5.2,100];
parfor i=1:3
%     if i <=3
        mm=m(i);
        RPS_intra_individual_L(300,0,360000,1,1,40,mm,1,0.5);
%     elseif i>3 && i <= 6
%         mm=m(i);
%         RPS_intra_individual_L2(300,0,360000,1,1,80,mm,1,0.5);
%     elseif i > 6 && i <= 11
%         rr=k(i);
%         RPS_intra_individual_LF(300,0,360000,rr,30);
%     elseif i>11
%         rr=k(i);
%         RPS_intra_individual_LF2(300,0,360000,rr,80);
%     end
end
%%
%%%%% RPSLS intra %%%%%
clear all; close all; clc;
k=[3.3,5.65,6.5,100];
parfor i=1:4
    intra3=k(i);
    RPSLS_intra_individual_L(100,0,10000,1,1,60,1.9,2,intra3,1.3,0.7)
end
%%
%%%%% RPSLS2 intra %%%%%
clear all; close all; clc;
% k=[2.2,3.3,9.3,100,3.3,5.65,6.5,100]; %total_intra
% k=[3.3,5.65,6.5,100]; %intra
k=[2.2,3.3,9.3,100]; %intra2
parfor i=1:4
%     if i <= 4
        intra5=k(i);
        RPSLS_intra2_individual_L(300,0,180000,1,1,30,0.3,1.1,2.5,0.7,intra5)
%     if i>4
%         intra3=k(i);
%         RPSLS_intra_individual_L(300,0,180000,1,1,40,1.9,2,intra3,1.3,0.7);
%     end
end