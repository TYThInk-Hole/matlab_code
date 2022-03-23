%%%% make subplot for figure on paper %%%%%
%
%%%% figure1
clear; close all; clc;
mobility=60:20:120;
for i = 1:length(mobility)
    fig=hgload(sprintf('/Volumes/yoonD/Data/inter3/figure/stack_hist_%d.fig',mobility(i)));
    figure(100);
    h(i)=subplot(2,2,i);
    copyobj(allchild(get(fig,'CurrentAxes')),h(i));
end
%
%%%% figure3
clear; close all; clc;
mobility=60:2:118;
data_cell=cell(length(mobility),4);
for i = 1:length(mobility)
    d1=load(sprintf('/Volumes/yoonnas1.synology.me/yoondata/Data/mass/inter3/Cell_inter3_%d',mobility(i)));
    d2=struct2cell(d1);
    d3=d2{1,1};
    for j=1:length(d3(:,1))
        data=d3{j,1};
        data_cell{i,1}=mean(nonzeros(data(:,1)));
        data_cell{i,2}=mean(nonzeros(data(:,2)));
        data_cell{i,3}=mean(nonzeros(data(:,3)));
        data_cell{i,4}=mean(nonzeros(data(:,1)+data(:,2)+data(:,3)));
        clear data
    end
    clear d1 d2 d3
end
save('/Volumes/yoonnas1.synology.me/yoondata/Data/mean_lifespan_inter3');
%%
%%%%% stack data to one cell inter %%%%%
clear; close all; clc
cd('/volumes/yoonD/inter3');
mobility=60:5:120;
% intr=[2.5,5.2,100];
% for n=1:numel(intr)
%     intra=intr(n);
for i=5:numel(mobility)
    M=mobility(i);
    dd=dir(sprintf('/volumes/yoonD/inter3/%d/*.mat',M));
    num=numel(dd);
    data_cell=cell(200*num,2);
    for j = 1:num
        p_cell=struct2cell(load(sprintf('/Volumes/yoonD/inter3/%d/Cell_inter3_%d_%d.mat',M,M,j)));
        inner_cell=p_cell{1,1};
        for l=1:numel(inner_cell(:,1))
            data_cell(l+numel(inner_cell(:,1)),1)=inner_cell(l,1);
            data_cell(l+numel(inner_cell(:,1))`,2)=inner_cell(l,2);
        end
        clear p_cell inner_cell
    end
    save(sprintf('/volumes/yoonD/Data/data_tomakefigure/inter3/inter3_%d',M),"data_cell",'-v7.3');
    clear num data_cell M
end
%     clear intra
% end

%%
%%%%% stack data to one cell intra%%%%%
clear; close all; clc
cd('/volumes/yoonD/intra3');
mobility=60:5:120;
intr=[2.5,5.2,100];
for n=1:numel(intr)
    intra=intr(n);
    for i=1:numel(mobility)
        num=numel(sprintf('Cell_intra3_%d_*%d.mat',intra,i));
        data_cell=cell(200*num,2);
        M=mobility(i);
        for j = 1:num
            p_cell=struct2cell( ...
                load(sprintf('/Volumes/yoonD/intra3/Cell_intra3_%d_%d_%d.mat',intra,M,j)));
            inner_cell=p_cell{1,1};
            for l=1:numel(inner_cell(:,1))
                data_cell(l,1)=inner_cell(l,1);
                data_cell(l,2)=inner_cell(l,2);
            end
            clear p_cell inner_cell
        end
        save(sprintf('/volumes/yoonD/Data/data_tomakefigure/intra3/intra3_%d',M),"data_cell",'-v7.3');
        clear num data_cell M
    end
    clear intra
end