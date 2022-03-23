clear all; close all; clc;
%%
k=[0.1,1,10,0.1,1,10,0.2:0.2:1,0.2:0.2:1];

parfor i=1:16
    if i <=3
        rr=k(i);
        RPS_inter_individual_L(300,0,360000,rr,1,30);
    elseif i>3 && i <= 6
        rr=k(i);
        RPS_inter_individual_L2(300,0,360000,rr,1,80);
    elseif i > 6 && i <= 11
        rr=k(i);
        RPS_inter_individual_LF(300,0,360000,rr,30);
    elseif i>11
        rr=k(i);
        RPS_inter_individual_LF2(300,0,360000,rr,80);
    end
end
%%
parfor i=1:16
    if i <=3
        rr=k(i);
        RPS_inter_individual_L(300,0,360000,rr,1,30);
    elseif i>3 && i <= 6
        rr=k(i);
        RPS_inter_individual_L2(300,0,360000,rr,1,80);
    elseif i > 6 && i <= 11
        rr=k(i);
        RPS_inter_individual_LF(300,0,360000,rr,30);
    elseif i>11
        rr=k(i);
        RPS_inter_individual_LF2(300,0,360000,rr,80);
    end
end