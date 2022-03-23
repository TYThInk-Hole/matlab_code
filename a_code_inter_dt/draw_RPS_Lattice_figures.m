%%
clear all; %close all; clc;
%%%%% inter %%%%%

%%%%%%%%%% data load %%%%%%%%%%%%%

%%%%% [0.1,1,10] %%%%%
reproduction_rate=1;
step=linspace(100,100000,1000);
step_size=5;

%%%%%% make video file %%%%%
% v = VideoWriter('inter_extinct_001.avi');
% v.FrameRate=5;
% open(v);

%%%%% histogram bar color %%%%%
o=[0.8500 0.3250 0.0980];
p=[0.4940 0.1840 0.5560];
g=[0.4660 0.6740 0.1880];

%%%%% load data and plot %%%%%
for i = 900:900
    if mod(i,step_size)==0
        a1=[];a2=[];a3=[];
        kkk=step(i);
        matrix_a1=load(sprintf('C:/Data/RPS/data_L/inter_dt_L_40/1/%d_1_stack_inter%d.csv', ...
            kkk,reproduction_rate));
        matrix_a2=load(sprintf('C:/Data/RPS/data_L/inter_dt_L_40/2/%d_2_stack_inter%d.csv', ...
            kkk,reproduction_rate));
        matrix_a3=load(sprintf('C:/Data/RPS/data_L/inter_dt_L_40/3/%d_3_stack_inter%d.csv', ...
            kkk,reproduction_rate));
        Lattice_a1=load(sprintf('C:/Data/RPS/data_L/inter_dt_L_40/1_1/%d_1_stack_inter%d.csv', ...
            kkk,reproduction_rate));
        Lattice_a2=load(sprintf('C:/Data/RPS/data_L/inter_dt_L_40/2_1/%d_2_stack_inter%d.csv', ...
            kkk,reproduction_rate));
        Lattice_a3=load(sprintf('C:/Data/RPS/data_L/inter_dt_L_40/3_1/%d_3_stack_inter%d.csv', ...
            kkk,reproduction_rate));

        Stack=matrix_a1+matrix_a2+matrix_a3;
        Lattice=Lattice_a1+2*Lattice_a2+3*Lattice_a3;

        f=figure(5);
        f.Position=[300 0 1500 1000];

%         subplot(4,2,[2 4]);
%         heatmap(Stack,'colormap',jet); title('age');
% 
%         subplot(4,2,[6 8]);
%         heatmap(Lattice,'colormap',summer); title('species location')


        a1=nonzeros(reshape(matrix_a1,1,[]));
        a2=nonzeros(reshape(matrix_a2,1,[]));
        a3=nonzeros(reshape(matrix_a3,1,[]));

%         a_sum=[a1,a2,a3];

%         subplot(4,2,1);
%         histogram(a_sum,400); title('total'); set(gca,'Yscale','log');

        subplot(3,1,1);
        histogram(a1,400,'facecolor',o); title('A'); set(gca,'Yscale','log');
        grid on; ylim([0 10000]); xlim([0 80000]); yticks([0 ,10, 10^2, 10^3, 10^4]);

        subplot(3,1,2);
        histogram(a2,400,'facecolor',p); title('B'); set(gca,'Yscale','log');
        grid on; ylim([0 10000]); xlim([0 80000]);  yticks([0 ,10, 10^2, 10^3, 10^4]);

        subplot(3,1,3);
        histogram(a3,400,'facecolor',g); title('C'); set(gca,'Yscale','log');
        grid on; ylim([0 10000]); xlim([0 80000]); yticks([0 ,10, 10^2, 10^3, 10^4]); 
%         frame=getframe(gcf);

%         writeVideo(v,frame);

    end

end

% close(v);
%    ffmpegimages2video('test1%02d.png','sinedemo.gif','InputFrameRate',5,...
% 'VideoCodec','gif','DeleteSource','on');
%     ffmpegimages2video('test2%02d.png','sinedemo.gif','InputFrameRate',5,...
% 'VideoCodec','gif','DeleteSource','on');

%%
clear all; close all; clc;
%%%%% intra %%%%%

%%%%%%%%%% data load %%%%%%%%%%%%%

%%%%% [0.1,1,10] %%%%%
intra1=1;
step=linspace(100,100000,1000);
step_size=5;

%%%%%% make video file %%%%%
v = VideoWriter('intra_exti_100.avi');
v.FrameRate=5;
open(v);

%%%%% histogram bar color %%%%%
b=[0.6350 0.0780 0.1840];
o=[0.9290 0.6940 0.1250];
g=[0.4660 0.6740 0.1880];
r=[0.3010 0.0780 0.9330];
%%%%% load data and plot %%%%%
for i = 1:length(step)
    if mod(i,step_size)==0
        a1=[];a2=[];a3=[];
        kkk=step(i);
        matrix_a1=load(sprintf('F:/Data/RPS/data_L/intra_dt_L_40/1/%d_1_stack_intra%d.csv', ...
            kkk,intra1));
        matrix_a2=load(sprintf('F:/Data/RPS/data_L/intra_dt_L_40/2/%d_2_stack_intra%d.csv', ...
            kkk,intra1));
        matrix_a3=load(sprintf('F:/Data/RPS/data_L/intra_dt_L_40/3/%d_3_stack_intra%d.csv', ...
            kkk,intra1));
        Lattice_a1=load(sprintf('F:/Data/RPS/data_L/intra_dt_L_40/1_1/%d_1_stack_intra%d.csv', ...
            kkk,intra1));
        Lattice_a2=load(sprintf('F:/Data/RPS/data_L/intra_dt_L_40/2_1/%d_2_stack_intra%d.csv', ...
            kkk,intra1));
        Lattice_a3=load(sprintf('F:/Data/RPS/data_L/intra_dt_L_40/3_1/%d_3_stack_intra%d.csv', ...
            kkk,intra1));

        Stack=matrix_a1+matrix_a2+matrix_a3;
        Lattice=Lattice_a1+2*Lattice_a2+3*Lattice_a3;

        f=figure(1);
        f.Position=[200 100 1800 1200];

        subplot(4,2,[2 4]);
        heatmap(Stack,'colormap',jet); title('age');

        subplot(4,2,[6 8]);
        heatmap(Lattice,'colormap',summer); title('species location')


        a1=reshape(matrix_a1,1,[]);
        a2=reshape(matrix_a2,1,[]);
        a3=reshape(matrix_a3,1,[]);

        a_sum=[a1,a2,a3];

        subplot(4,2,1);
        histogram(a_sum,300,'facecolor',b); title('total'); set(gca,'Yscale','log');

        subplot(4,2,3);
        histogram(a1,300,'facecolor',o); title('A'); set(gca,'Yscale','log');

        subplot(4,2,5);
        histogram(a2,300,'facecolor',g); title('B'); set(gca,'Yscale','log');

        subplot(4,2,7);
        histogram(a3,300,'facecolor',r); title('C'); set(gca,'Yscale','log');

        frame=getframe(gcf);

        writeVideo(v,frame);

    end

end

close(v);
%%
clear all; close all; clc;
%%%%% inter %%%%%

%%%%%%%%%% data load %%%%%%%%%%%%%

%%%%% [20, 40, 60, 80, 100, 120] %%%%%
mobility=60;
step=linspace(100,100000,1000);
step_size=5;

%%%%%% make video file %%%%%
% v = VideoWriter('inter_mobility_60.avi');
% v.FrameRate=5;
% open(v);

%%%%% histogram bar color %%%%%
b=[0.6350 0.0780 0.1840];
o=[0.9290 0.6940 0.1250];
g=[0.4660 0.6740 0.1880];
r=[0.3010 0.0780 0.9330];
%%%%% load data and plot %%%%%
for i = 200:200
    if mod(i,step_size)==0
        a1=[];a2=[];a3=[];
        kkk=step(i);
        matrix_a1=load(sprintf('C:/Data/RPS/data_L/inter_dt_mu_60_1/1/%d_1_stack_inter%d.csv', ...
            kkk,mobility));
        matrix_a2=load(sprintf('C:/Data/RPS/data_L/inter_dt_mu_60_1/2/%d_2_stack_inter%d.csv', ...
            kkk,mobility));
        matrix_a3=load(sprintf('C:/Data/RPS/data_L/inter_dt_mu_60_1/3/%d_3_stack_inter%d.csv', ...
            kkk,mobility));
        Lattice_a1=load(sprintf('C:/Data/RPS/data_L/inter_dt_mu_60_1/1_1/%d_1_stack_inter%d.csv', ...
            kkk,mobility));
        Lattice_a2=load(sprintf('C:/Data/RPS/data_L/inter_dt_mu_60_1/2_1/%d_2_stack_inter%d.csv', ...
            kkk,mobility));
        Lattice_a3=load(sprintf('C:/Data/RPS/data_L/inter_dt_mu_60_1/3_1/%d_3_stack_inter%d.csv', ...
            kkk,mobility));

        Stack=matrix_a1+matrix_a2+matrix_a3;
        Lattice=Lattice_a1+2*Lattice_a2+3*Lattice_a3;

        f=figure(1);
        f.Position=[200 100 1800 1200];

        subplot(4,2,[2 4]);
        heatmap(Stack,'colormap',jet); title('age');

        subplot(4,2,[6 8]);
        heatmap(Lattice,'colormap',summer); title('species location')


        a1=reshape(matrix_a1,1,[]);
        a2=reshape(matrix_a2,1,[]);
        a3=reshape(matrix_a3,1,[]);

        a_sum=[a1,a2,a3];

        subplot(4,2,1);
        histogram(a_sum,300,'facecolor',b); title('total'); set(gca,'Yscale','log');

        subplot(4,2,3);
        histogram(a1,300,'facecolor',o); title('A_1'); set(gca,'Yscale','log');

        subplot(4,2,5);
        histogram(a2,300,'facecolor',g); title('B_0.8'); set(gca,'Yscale','log');

        subplot(4,2,7);
        histogram(a3,300,'facecolor',r); title('C_1.2'); set(gca,'Yscale','log');

%         frame=getframe(gcf);

%         writeVideo(v,frame);

    end

end

% close(v);
%%
clear all; %close all; clc;
%%%%% intra RPSLS%%%%%

%%%%%%%%%% data load %%%%%%%%%%%%%

%%%%% [2.2, 3.3, 9.3, 100] %%%%% intra2
%%%%% [3.3,5.65,6.5,100] %%%%% intra
intra5=9.3;
step=linspace(100,180000,1800);
step_size=5;

%%%%%% make video file %%%%%
% v = VideoWriter('intra2_LS_ext3_30.avi');
% v.FrameRate=10;
% open(v);

%%%%% histogram bar color %%%%%
b=[0.6350 0.0780 0.1840];
o=[0.9290 0.6940 0.1250];
g=[0.4660 0.6740 0.1880];
r=[0.3010 0.0780 0.9330];
k=[0 0 1];
%%%%% load data and plot %%%%%
for i = 400:400
    if mod(i,step_size)==0
%         a1=[];a2=[];a3=[];a4=[];a5=[];
        kkk=step(i);
        matrix_a1=load(sprintf('C:/Data/RPS/data_L/intra_dt_LS_30/1/%d_1_stack_intra%d.csv', ...
            kkk,intra5));
        matrix_a2=load(sprintf('C:/Data/RPS/data_L/intra_dt_LS_30/2/%d_2_stack_intra%d.csv', ...
            kkk,intra5));
        matrix_a3=load(sprintf('C:/Data/RPS/data_L/intra_dt_LS_30/3/%d_3_stack_intra%d.csv', ...
            kkk,intra5));
        matrix_a4=load(sprintf('C:/Data/RPS/data_L/intra_dt_LS_30/4/%d_4_stack_intra%d.csv', ...
            kkk,intra5));
        matrix_a5=load(sprintf('C:/Data/RPS/data_L/intra_dt_LS_30/5/%d_5_stack_intra%d.csv', ...
            kkk,intra5));
        Lattice_a1=load(sprintf('C:/Data/RPS/data_L/intra_dt_LS_30/1_1/%d_1_stack_intra%d.csv', ...
            kkk,intra5));
        Lattice_a2=load(sprintf('C:/Data/RPS/data_L/intra_dt_LS_30/2_1/%d_2_stack_intra%d.csv', ...
            kkk,intra5));
        Lattice_a3=load(sprintf('C:/Data/RPS/data_L/intra_dt_LS_30/3_1/%d_3_stack_intra%d.csv', ...
            kkk,intra5));
        Lattice_a4=load(sprintf('C:/Data/RPS/data_L/intra_dt_LS_30/4_1/%d_4_stack_intra%d.csv', ...
            kkk,intra5));
        Lattice_a5=load(sprintf('C:/Data/RPS/data_L/intra_dt_LS_30/5_1/%d_5_stack_intra%d.csv', ...
            kkk,intra5));


        %         Stack=matrix_a1+matrix_a2+matrix_a3;
        %         Lattice=Lattice_a1+2*Lattice_a2+3*Lattice_a3;

        f=figure(2);
        f.Position=[300 0 1100 1100];

        a1=nonzeros(reshape(matrix_a1,1,[]));
        a2=nonzeros(reshape(matrix_a2,1,[]));
        a3=nonzeros(reshape(matrix_a3,1,[]));
        a4=nonzeros(reshape(matrix_a4,1,[]));
        a5=nonzeros(reshape(matrix_a5,1,[]));

        %         a_sum=[a1,a2,a3,a4,a5];

        subplot(5,1,1);
        histogram(a1,500,'facecolor',b); title('A'); set(gca,'Yscale','log');
        grid on; ylim([0 70000]); xlim([0 27000]);

        subplot(5,1,2);
        histogram(a2,500,'facecolor',o); title('B'); set(gca,'Yscale','log');
        grid on; ylim([0 70000]); xlim([0 27000]);

        subplot(5,1,3);
        histogram(a3,500,'facecolor',g); title('C'); set(gca,'Yscale','log');
        grid on; ylim([0 70000]); xlim([0 27000]);

        subplot(5,1,4);
        histogram(a4,500,'facecolor',r); title('D'); set(gca,'Yscale','log');
        grid on; ylim([0 70000]); xlim([0 27000]);

        subplot(5,1,5);
        histogram(a5,500,'facecolor',k); title('E'); set(gca,'Yscale','log');
        grid on; ylim([0 70000]); xlim([0 27000]);

%         frame=getframe(gcf);

%         writeVideo(v,frame);

    end

end

% close(v);
