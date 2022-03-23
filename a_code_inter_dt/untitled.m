%%
%%%%%% /Volumes/yoonD/new/intra3/*.mat'
clear; close all; clc
mobility=60:5:120;
intra=[2.5,5.2,100];
interval=30;
for i = 1:1%length(mobility)
    num=numel(dir(sprintf('/volumes/yoonD/new/intra3/Cell_intra3_%d_%d_*.mat',intra(1),mobility(i))));
    C=cell(num,1);
    for ite=1:50
        tic
        d_s=load(sprintf('/volumes/yoonD/new/intra3/Cell_intra3_%d_%d_%d.mat',intra(1),mobility(i),ite));
        d_c=struct2cell(d_s);
        d_m=d_c{1,1};
        d_d=d_m(:,1);
        data=cell2mat(d_d);

        close all;
        set(gcf,'visible','off');
        h=histogram(nonzeros(data),100,'normalization','pdf');
        pd=fitdist(nonzeros(data),'exponential'); hold on;
        if mod(ite,interval)==0
            y=pdf(pd,h.BinEdges);
            plot(h.BinEdges,y,'--','linewidth',3); hold off;
            axis([0 inf 1e-6 inf]);
            %             xticks(0:1000:4000); yticks([1e-6 1e-5 1e-4 1e-3 1e-2 1e-1]);
            xlabel('generation');ylabel('rate');
            set(gca,'yscale','log','fontsize',17,'fontname','italic');
            savefig(sprintf('/Volumes/yoonD/new/figure/intra3/Stack_hist_%d.fig',mobility(i)));
            print('-depsc',sprintf('/Volumes/yoonD/new/figure/intra3/Stack_hist_%d.eps',mobility(i)));
        end
        C{ite,1}=pd.mu;
        toc
        disp(ite)
    end
    save(sprintf('/volumes/yoonD/new/mu_data/Cell_intra3_%d_%d',intra(1),mobility(i)),'C','-v7.3');
    clear C h pd data d_s d_c d_m d_d
end

