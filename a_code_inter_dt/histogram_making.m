%%
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
%%%%% /volumes/yoonnas/Data/RPS_data/intra3/Cell_intra3_intra_mobility_number %%%%%
clear; close all; clc
intra=[2.5 5.2 100];
mobility=30:10:60;
interval=30;
j=1;
for i = 1:length(mobility)
    num=numel(dir(sprintf('/volumes/Data/RPS_data/intra3/Cell_intra3_%d_%d_*.mat',intra(j),mobility(i))));
    cd('/volumes/yoonD/RPS/new/figure/intra3');
    for ite=1:num

        if mod(ite,interval)==0
            load(sprintf('/volumes/Data/RPS_data/intra3/Cell_intra3_%d_%d_%d.mat',intra(j),mobility(i),ite));
            d_c=Data_Cell;
            data=cell2mat(d_c(:,1));
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
            savefig(sprintf('/Volumes/yoonD/RPS/new/figure/intra3/%d/Stack_hist_%d_%d_%d.fig',mobility(i),intra(j),mobility(i),ite));
            print('-depsc',sprintf('/Volumes/yoonD/RPS/new/figure/intra3/%d/Stack_hist_%d_%d_%d.eps',mobility(i),intra(j),mobility(i),ite));
            disp(ite)
        end
        clear h pd data d_s d_c

    end

end