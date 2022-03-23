clear ; close all; clc;
% mobility=60:5:120;
% intra3=[3.3,5.65,6.5,100];
% intra5=[2.2,3.3,9.3,100];
cd('E:/Data/Figures/')

Data_intra=cell(13,8);

for j = 1:13 %% data load by mobility
    mobility= 5*j+55;
    mkdir(sprintf('%d',mobility))
    cd(sprintf('%d',mobility))
    intra=[3.3,5.65,6.5,100,2.2,3.3,9.3,100];
    parfor jj = 1:8 %% data load by intra
        if jj < 5
            intra3=intra(jj);
            mkdir(sprintf('%d',intra3));
            cd(sprintf('%d',intra3));
            A=load(sprintf('E:/Data/RPSLS1/Cell_A_%d_%d.mat',intra3,mobility)); %load Cell(stack & lattice) data
        else
            intra5=intra(jj);
            mkdir(sprintf('%d',intra5));
            cd(sprintf('%d',intra5));
            A=load(sprintf('E:/Data/RPSLS2/Cell_B_%d_%d.mat',intra5,mobility)); %load Cell(stack & lattice) data
        end

        B=struct2cell(A); %convert struct to cell
        C=B{1,1}; %take 2 columns(stack,lattcie)
        A1=C(:,1); %column with stack
        A2=C(:,2 ); %column sith laatice

        Mu=zeros(90,2); % column_1 : mu of Stacks c olumn_2 : Lattices

        for i = 20 : 20 : 1800

            Stack=nonzeros(A1{i,1});
            set(gcf,'visible','off');
            h_1=histogram(Stack,30,'normalization','pdf'); hold on; %plot probability density function
            pd_1 = fitdist(Stack,'exponential'); %fit data to exponential distribution(output = mu,std)
            y_1=pdf(pd_1,h_1.BinEdges);
            plot(h_1.BinEdges,y_1); hold off;
            axis([0 3000 0 0.01]);

            Lattice=nonzeros(A2{i,1});
            set(gcf,'visible','off');
            h_2=histogram(Lattice,30,'normalization','pdf'); hold on;
            pd_2 = fitdist(Lattice,'exponential');
            y_2=pdf(pd_2,h_2.BinEdges);
            plot(h_2.BinEdges,y_2); hold off;
            axis([0 3000 0 0.01]);

            print('-dpng',sprintf('E:/Data/Figures/%d/%d/Stack_hist_%d_%d.png',mobility,intra(jj),i,mobility));
            print('-dpng',sprintf('E:/Data/Figures/%d/%d/Lattice_hist_%d_%d.png',mobility,intra(jj),i,mobility));

            Mu(i/20,:)=[pd_1.mu,pd_2.mu];

        end
        
        Data_intra{j,jj}=Mu;

        video_1 = VideoWriter(sprintf('E:/Data/Figures/%d/%d/Stack_hist_%d',mobility,intra(jj),mobility));
        video_2 = VideoWriter(sprintf('E:/Data/Figures/%d/%d/Lattice_hist_%d',mobility,intra(jj),mobility));

        video_1.FrameRate=10;
        video_2.FrameRate=10;

        open(video_1);
        open(video_2);

        imagefile_1=dir('E:/Data/Figures/S_F/*.png');
        imagefile_2=dir('E:/Data/Figures/L_F/*.png');

        num=numel(imagefile_1);

        for ii = 1:num
            ite=20*(ii);
            set(gcf,'visible','on');
            img_1 = imread(sprintf('E:/Data/Figures/S_F/Stack_hist_%d_%d.png',mobility,ite));
            img_2 = imread(sprintf('E:/Data/Figures/L_F/Lattice_hist_%d_%d.png',mobility,ite));
            writeVideo(video_1,img_1);
            writeVideo(video_2,img_2);
        end
        close(video_1); close(video_2);
        cd('E:/Data/Figures/');
    end
    clear;    
end
save('E:/Data/Data_intra',Data_intra,'v-7.3')