%%
%%% fig1
%%%%%% /Volumes/yoonD/new/inter3/*.mat' 
clear; close all; clc
mobility=30;%40:10:60;
interval=2;

for i = 1:length(mobility)
    num=numel(dir(sprintf('/volumes/yoonD/RPS_data/inter3/stack/Cell_inter3_%d_*.mat',mobility(i))));
    cd('/volumes/yoonD/new/figure/inter3');
    for ite=1:num

        if mod(ite,interval)==0
            load(sprintf('/volumes/yoonD/RPS_Data/inter3/stack/Cell_inter3_%d_%d.mat',mobility(i),ite));
            d_c=Data_stack_inter3;
            data=cell2mat(d_c);
            close all;
            set(gcf,'visible','off');
            h=histogram(nonzeros(data),50,'normalization','pdf');
            pd=fitdist(nonzeros(data),'exponential'); hold on;
            y=pdf(pd,h.BinEdges);
            plot(h.BinEdges,y,'--','linewidth',3); hold off;
            axis([0 inf 1e-6 inf]);
%             xticks(0:1000:4000); yticks([1e-6 1e-5 1e-4 1e-3 1e-2 1e-1 1]);
            xlabel('generation');ylabel('rate');
            set(gca,'yscale','log','fontsize',17,'fontname','italic');
            savefig(sprintf('/Volumes/yoonD/new/figure/inter3/%d/Stack_hist_%d_%d.fig',mobility(i),mobility(i),ite));
            print('-depsc',sprintf('/Volumes/yoonD/new/figure/inter3/%d/Stack_hist_%d_%d.eps',mobility(i),mobility(i),ite));
            disp(ite)
        end
        clear h pd data d_s d_c

    end

end
%%
%%% fig2
%%%%% /volumes/yoonnas/Data/RPS_data/intra3/Cell_intra3_intra_mobility_number %%%%%
clear; close all; clc
intra=[2.5 5.2 100];
mobility=30:10:60;
interval=30;
j=1;
for i = 1:length(mobility)
    num=numel(dir(sprintf('/volumes/yoonD/RPS/RPS_data/intra3/Cell_intra3_%d_%d_*.mat',intra(j),mobility(i))));
    cd('/volumes/yoonD/RPS/new/figure/intra3');
    for ite=1:num

        if mod(ite,interval)==0
            load(sprintf('/volumes/yoonD/RPS/RPS_data/intra3/Cell_intra3_%d_%d_%d.mat',intra(j),mobility(i),ite));
            d_c=Data_Cell;
            data=cell2mat(d_c(:,1));
            close all;
            set(gcf,'visible','off');
            h=histogram(nonzeros(data),50,'normalization','pdf');
            pd=fitdist(nonzeros(data),'exponential'); hold on;
            y=pdf(pd,h.BinEdges);
            plot(1.1*h.BinEdges,0.8*y,'--','linewidth',3); hold off;
            axis([0 inf 1e-6 inf]);
%             xticks(0:1000:4000); yticks([1e-6 1e-5 1e-4 1e-3 1e-2 1e-1 1]);
            xlabel('generation');ylabel('rate');
            set(gca,'yscale','log','fontsize',17,'fontname','italic');
            savefig(sprintf('/Volumes/yoonD/RPS/new/figure/intra3/%d/Stack_hist_%d_%d_%d.fig',mobility(i),intra(j),mobility(i),ite));
            print('-depsc',sprintf('/Volumes/yoonD/RPS/new/figure/intra3/%d/Stack_hist_%d_%d_%d.eps',mobility(i),intra(j),mobility(i),ite));
            
        end
        clear h pd data d_s d_c
    end

end

%%
%%%%%% make histogram of 5species independently

mobility=30:2:60;
interval=5;
function hist_intra5(intra,mobility,species)
for i = 1:length(mobility)/2
    num=numel(dir(sprintf('/volumes/yoonD/RPS/RPS_data/RPSLS2/Cell_B_%d_%d_*.mat',intra,mobility)));
    for ite=1:num
        if mod(ite,interval)==0
            load(sprintf('/volumes/yoonD/RPS/RPS_Data/RPSLS2/Cell_B_%d_%d_%d.mat',intra,mobility,ite));
            d_c=Data_Cell_2(1:300,1);
            data=cell2mat(d_c);
            spe=nonzeros(data(:,species));                        

            close all;
          
            set(gcf,'visible','off');
            h=histogram(spe,50,'normalization','pdf');
            pd=fitdist(spe,'exponential'); hold on;
            y=pdf(pd,h.BinEdges);
            plot(h.BinEdges,y,'--','linewidth',3); hold off;
            axis([0 inf 1e-6 inf]);
            xlabel('generation');ylabel('rate');title('species_A');
            set(gca,'yscale','log','fontsize',17,'fontname','italic');
            savefig(sprintf('/Volumes/yoonD/RPS/RPS_paper/figure/hist5/%d/%d_Stack_hist_%d_%d_%d.fig',mobility,species,intra,mobility,ite));
            print('-depsc',sprintf('/Volumes/yoonD/RPS/RPS_paper/figure/hist5/%d/%d_Stack_hist_%d_%d_%d.eps',mobility,species,intra,mobility,ite));

            disp(ite)
        end
        
        clear h pd data d_s d_c

    end

end
end

%%
%%% fig3
%%%%% mean lifespan per mobility inter3 %%%%%
clear; close all; clc
mobility=30:2:60;
D=zeros(length(mobility),1);

for i = 1:length(mobility)
    num=numel(dir(sprintf('/volumes/yoonD/RPS/RPS_data/inter3/stack/Cell_inter3_%d_*.mat',mobility(i))));
    M=zeros(num,1);
    for ite=1:num
        load(sprintf('/volumes/yoonD/RPS_Data/inter3/stack/Cell_inter3_%d_%d.mat',mobility(i),ite));
        d_c=Data_stack_inter3;
        data=cell2mat(d_c);
        M(ite,1)=mean(nonzeros(data));
        disp(ite)
        clear h pd data d_s d_c
    end
    MM=mean(M);
    clear M
    D(i,1)=MM;
end
plot(10^(-mobility./10),D);
savefig('/Volumes/yoonD/RPS/RPS_paper/figure/fig3/mealifespan_mobility.fig');
print('-depsc','/Volumes/yoonD/RPS/RPS_paper/figure/fig3/mealifespan_mobility,eps');
%%
%%% fig4
%%%%% mean lifespan per mobility intra3 %%%%%
clear; close all; clc
intra=[2.5 5.2 100];
mobility=30:2:60;

for j = 1:length(intra)
    D=zeros(length(mobility),1);
    for i = 1:length(mobility)
        num=numel(dir(sprintf('/volumes/yoonD/RPS/RPS_data/intra3/Cell_intra3_%d_%d_*.mat',intra(j),mobility(i))));
        M=zeros(num,1);
        for ite=1:num
            load(sprintf('/volumes/yoonD/RPS/RPS_data/intra3/Cell_intra3_%d_%d_%d.mat',intra(j),mobility(i),ite));
            d_c=Data_Cell;
            data=cell2mat(d_c(:,1));
            M(ite,1)=mean(nonzeros(data));
            clear h pd data d_s d_c
            disp(ite)
        end
        MM=mean(M);
        D(i,1)=MM;
        clear MM M
    end
    plot(10^(-mobility./10),D);
    savefig(sprintf('/Volumes/yoonD/RPS/RPS_paper/figure/fig4/mealifespan_mobility_%d.fig',intra));
    print('-depsc',sprintf('/Volumes/yoonD/RPS/RPS_paper/figure/fig4/mealifespan_mobility_%d.eps',intra));
    clear D
end

