clear; close all; clc;

interval=20; % data generation interval
step=60:5:120; % mobility

intra=[3.3, 5.65, 6.5, 100]; % each species intra rate of intra3 model

Mu_Cell=cell(length(intra),length(step));

for i = 1:length(intra)

    intra3=intra(i);

    parfor k = 1:length(step)
        mobility=step(k);

%         calldata = load(sprintf('/Volumes/yoonD/Data/RPSLS1/Cell_A_%d_%d',intra3,mobility));
        calldata = load(sprintf('E:/Data/RPSLS1/Cell_A_%d_%d',intra3,mobility));

        data_cell = struct2cell(calldata);

        data=data_cell{1,1};

        Mu=zeros(90000/interval,10);

        for j = 1:length(data(:,1))/interval
            stack=data{j,1};

            sspecies_a=nonzeros(stack(:,1));
            sspecies_b=nonzeros(stack(:,2));
            sspecies_c=nonzeros(stack(:,3));
            sspecies_d=nonzeros(stack(:,4));
            sspecies_e=nonzeros(stack(:,5));

%             figure(1); set(gca,'visible','off');
%             subplot(5,1,1);
            if isempty(sspecies_a) == 1
                mu_s_a = nan;
                x=0;
%                 plot(x,'o');
            else
%                 h_a=histogram(sspecies_a,30,'normalization','pdf'); hold on;
                p_a=fitdist(sspecies_a,'exponential');
%                 y_a=pdf(p_a,h_a.BinEdges);
                mu_s_a = p_a.mu;
%                 plot(h_a.BinEdges,y_a); hold off;
            end

%             subplot(5,1,2);
            if isempty(sspecies_b) == 1
                mu_s_b = nan;
                x=0;
%                 plot(x,'o');
            else
%                 h_b=histogram(sspecies_b,30,'normalization','pdf'); hold on;
                p_b=fitdist(sspecies_b,'exponential');
%                 y_b=pdf(p_b,h_b.BinEdges);
                mu_s_b = p_b.mu;
%                 plot(h_b.BinEdges,y_b); hold off;
            end

%             subplot(5,1,3);
            if isempty(sspecies_c) == 1
                mu_s_c = nan;
                x=0;
%                 plot(x,'o');
            else
%                 h_c=histogram(sspecies_c,30,'normalization','pdf'); hold on;
                p_c=fitdist(sspecies_c,'exponential');
%                 y_c=pdf(p_c,h_c.BinEdges);
                mu_s_c = p_c.mu;
%                 plot(h_c.BinEdges,y_c); hold off;
            end

%             subplot(5,1,4);
            if isempty(sspecies_d) == 1
                mu_s_d = nan;
                x=0;
%                 plot(x,'o');
            else
%                 h_d=histogram(sspecies_d,30,'normalization','pdf'); hold on;
                p_d=fitdist(sspecies_d,'exponential');
%                 y_d=pdf(p_d,h_d.BinEdges);
                mu_s_d = p_d.mu;
%                 plot(h_d.BinEdges,y_d); hold off;
            end

%             subplot(5,1,5);
            if isempty(sspecies_e) == 1
                mu_s_d = nan;
                x=0;
%                 plot(x,'o');
            else
%                 h_e=histogram(sspecies_e,30,'normalization','pdf'); hold on;
                p_e=fitdist(sspecies_e,'exponential');
%                 y_e=pdf(p_e,h_e.BinEdges);
                mu_s_e = p_e.mu;
%                 plot(h_a.BinEdges,y_a); hold off;
            end
%             pause(0.1);

            lattice=data{j,2};

            lspecies_a=nonzeros(lattice(:,1));
            lspecies_b=nonzeros(lattice(:,2));
            lspecies_c=nonzeros(lattice(:,3));
            lspecies_d=nonzeros(lattice(:,4));
            lspecies_e=nonzeros(lattice(:,5));

%             figure(2); subplot(5,1,1);
            if isempty(lspecies_a) == 1
                mu_l_a = nan;
                x=0;
%                 plot(x,'o');
            else
%                 h_aa=histogram(lspecies_a,30,'normalization','pdf'); hold on;
                p_aa=fitdist(lspecies_a,'exponential');
%                 y_aa=pdf(p_aa,h_aa.BinEdges);
                mu_l_a = p_aa.mu;
%                 plot(h_aa.BinEdges,y_aa); hold off;
            end

%             subplot(5,1,2);
            if isempty(lspecies_b) == 1
                mu_l_b = nan;
                x=0;
%                 plot(x,'o');
            else
%                 h_bb=histogram(lspecies_b,30,'normalization','pdf'); hold on;
                p_bb=fitdist(lspecies_b,'exponential');
%                 y_bb=pdf(p_bb,h_bb.BinEdges);
                mu_l_b = p_bb.mu;
%                 plot(h_bb.BinEdges,y_bb); hold off;
            end

%             subplot(5,1,3);
            if isempty(lspecies_c) == 1
                mu_l_c = nan;
                x=0;
%                 plot(x,'o');
            else
%                 h_cc=histogram(lspecies_c,30,'normalization','pdf'); hold on;
                p_cc=fitdist(lspecies_c,'exponential');
%                 y_cc=pdf(p_cc,h_cc.BinEdges);
                mu_l_c = p_cc.mu;
%                 plot(h_cc.BinEdges,y_cc); hold off;
            end

%             subplot(5,1,4);
            if isempty(lspecies_d) == 1
                mu_l_d = nan;
                x=0;
%                 plot(x,'o');
            else
%                 h_dd=histogram(lspecies_d,30,'normalization','pdf'); hold on;
                p_dd=fitdist(lspecies_d,'exponential');
%                 y_dd=pdf(p_dd,h_dd.BinEdges);
                mu_l_d = p_dd.mu;
%                 plot(h_dd.BinEdges,y_dd); hold off;
            end

%             subplot(5,1,5);
            if isempty(lspecies_e) == 1
                mu_l_e = nan;
                x=0;
%                 plot(x,'o');
            else
%                 h_ee=histogram(lspecies_e,30,'normalization','pdf'); hold on;
                p_ee=fitdist(lspecies_e,'exponential');
%                 y_ee=pdf(p_ee,h_ee.BinEdges);
                mu_l_e = p_ee.mu;
%                 plot(h_ee.BinEdges,y_ee); hold off;

%                 pause(0.1);
            end
            Mu(j,:)=[mu_s_a,mu_s_b,mu_s_c,mu_s_d,mu_s_e,...
                mu_l_a,mu_l_b,mu_l_c,mu_l_d,mu_l_e];
            
        end
        Mu_Cell{i,k}=Mu;
             
    end
    clear
end
% save('/Volume/yoonD/Data/Lambda/intra3/Mu_Cell.mat','Mu_Cell');
save('E:/Data/Lambda/intra3/Mu_cell.mat','Mu_Cell');