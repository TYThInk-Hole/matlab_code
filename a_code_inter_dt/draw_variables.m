clear; close all; clc;

data_struct=load('Mu.mat');
data_cell=struct2cell(data_struct);
data=data_cell{1,1};

data_L_A=nonzeros(data(:,6));
data_L_B=nonzeros(data(:,7));
data_L_C=nonzeros(data(:,8));
data_L_D=nonzeros(data(:,9));
data_L_E=nonzeros(data(:,10));

t=1:1:length(data_L_A);


fig=figure(1);

subplot(5,1,1)
plot(t,data_L_A,'o'); title('A');
set(gca,'Xtick',0:1500:4500,'ylim',[0,200],'Ytick',0:100:200,'fontsize',13);

subplot(5,1,2)
plot(t,data_L_B,'o'); title('B');
set(gca,'Xtick',0:1500:4500,'ylim',[0,200],'Ytick',0:100:200,'fontsize',13);

subplot(5,1,3)
plot(t,data_L_C,'o'); title('C');
set(gca,'Xtick',0:1500:4500,'ylim',[0,200],'Ytick',0:100:200,'fontsize',13);

subplot(5,1,4)
plot(t,data_L_D,'o'); title('D');
set(gca,'Xtick',0:1500:4500,'ylim',[0,200],'Ytick',0:100:200,'fontsize',13);

subplot(5,1,5)
plot(t,data_L_E,'o'); title('E');
set(gca,'Xtick',0:1500:4500,'ylim',[0,200],'Ytick',0:100:200,'fontsize',13);

han=axes(fig,'visible','off');
han.XLabel.Visible='on';
han.YLabel.Visible='on';
ylabel(han,'lambda'); xlabel(han,'generation');
set(gca,'fontsize',18)

print('-dpng',sprintf('%d_%d_hist%03d_%d.png',species,mobility,counting,intra));


