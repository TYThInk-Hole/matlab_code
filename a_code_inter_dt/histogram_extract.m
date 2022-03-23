clear; close all; clc

Data_intra=cell(13,8);
for i = 1:13
    intra=[3.3,5.65,6.5,100,2.2,3.3,9.3,100];
   
    parfor ii = 1:8 
        mobility=linspace(60,120,13);
        if ii < 5
            
            A=load(sprintf('/Volumes/yoonD/Data/RPSLS1/Cell_A_%d_%d.mat',intra(ii),mobility(i)));
            cd(sprintf('/Volumes/yoonD/Data/Figures/%d/intra3/%d',mobility(i),intra(ii)))
            B=struct2cell(A);
            C=B{1,1};
            A1=C(:,1);
            A2=C(:,2);

            Mu=zeros(90,2); % column_1 : mu of Stacks column_2 : Lattices

            for j=40:40:1800
                Stack=nonzeros(A1{j,1});
                set(gcf,'visible','off'); 
                h_1=histogram(Stack,30,'normalization','pdf');
                pd_1=fitdist(Stack,'exponential'); hold on;
                y_1=pdf(pd_1,h_1.BinEdges);
                plot(h_1.BinEdges,y_1); hold off;
                axis([0 3000 0 0.01]);
                
                savefig(sprintf('/Volumes/yoonD/Data/Figures/%d/intra3/%d/Stack_hist_%d_%d.fig',mobility(i),intra(ii),j,mobility(i)));
                print('-dpng',sprintf('/Volumes/yoonD/Data/Figures/%d/intra3/%d/Stack_hist_%d_%d.png',mobility(i),intra(ii),j,mobility(i)));

                Lattice=nonzeros(A2{j,1});
                set(gcf,'visible','off');
                h_2=histogram(Stack,30,'normalization','pdf'); hold on;
                pd_2=fitdist(Stack,'exponential');
                y_2=pdf(pd_2,h_2.BinEdges);
                plot(h_2.BinEdges,y_2); hold off;
                axis([0 3000 0 0.01]);
                
                savefig(sprintf('/Volumes/yoonD/Data/Figures/%d/intra3/%d/Lattice_hist_%d_%d.fig',mobility(i),intra(ii),j,mobility(i)));
                print('-dpng',sprintf('/Volumes/yoonD/Data/Figures/%d/intra3/%d/Lattice_hist_%d_%d.png',mobility(i),intra(ii),j,mobility(i)));

                Mu(j/20,:)=[pd_1.mu,pd_2.mu];
            end

            Data_intra{i,ii}=Mu;
            cd('/Volumes/yoonD/Data/')
        else
            
            A=load(sprintf('/Volumes/yoonD/Data/RPSLS2/Cell_B_%d_%d.mat',intra(ii),mobility(i)));
            cd(sprintf('/Volumes/yoonD/Data/Figures/%d/intra5/%d',mobility(i),intra(ii)))
            B=struct2cell(A);
            C=B{1,1};
            A1=C(:,1);
            A2=C(:,2);

            Mu=zeros(90,2); % column_1 : mu of Stacks column_2 : Lattices

            for j=20:20:1800
                Stack=nonzeros(A1{j,1});
                set(gcf,'visible','off');
                h_1=histogram(Stack,30,'normalization','pdf'); hold on;
                pd_1=fitdist(Stack,'exponential');
                y_1=pdf(pd_1,h_1.BinEdges);
                plot(h_1.BinEdges,y_1); hold off;
                axis([0 3000 0 0.01]);

                savefig(sprintf('/Volumes/yoonD/Data/Figures/%d/intra5/%d/Stack_hist_%d_%d.fig',mobility(i),intra(ii),j,mobility(i)));
                print('-dpng',sprintf('/Volumes/yoonD/Data/Figures/%d/intra5/%d/Stack_hist_%d_%d.png',mobility(i),intra(ii),j,mobility(i)));

                Lattice=nonzeros(A2{j,1});
                set(gcf,'visible','off');
                h_2=histogram(Stack,30,'normalization','pdf'); hold on;
                pd_2=fitdist(Stack,'exponential');
                y_2=pdf(pd_2,h_2.BinEdges);
                plot(h_2.BinEdges,y_2); hold off;
                axis([0 3000 0 0.01]);

                savefig(sprintf('/Volumes/yoonD/Data/Figures/%d/intra5/%d/Lattice_hist_%d_%d.fig',mobility(i),intra(ii),j,mobility(i)));
                print('-dpng',sprintf('/Volumes/yoonD/Data/Figures/%d/intra5/%d/Lattice_hist_%d_%d.png',mobility(i),intra(ii),j,mobility(i)));

                Mu(j/20,:)=[pd_1.mu,pd_2.mu];
            end

            Data_intra{i,ii}=Mu;
            cd('/Volumes/yoonD/Data/')
        end

    end
end
