for i = 1:2
    if i==1
        draw_intra_stack
    else
        draw_inter_stack
    end
end




function draw_intra_stack
clear all; close all; clc
cd('F:/Data/RPS/hist');
dir1=('F:/Data/RPS/hist');
mkdir('intra');
cd('intra');
dir2=fullfile(dir1,'intra');
for intra = [2.5,5.2,100]
    mkdir(sprintf('%d',intra));
    cd(sprintf('%d',intra))
    dir3=fullfile(dir2,sprintf('%d',intra));
    for j=1:3
        species=j;
        mkdir(sprintf('%d',species));
        cd(sprintf('%d',species));
        dir4=fullfile(dir3,sprintf('%d',species));
        parfor i = 1:9

            mobility = (i*10)+30;
            counting=1;

            mkdir(sprintf('%d',mobility));
            cd(sprintf('%d',mobility));

            while true %%%% counting the number of files

                filedir=sprintf('F:/Data/RPS/data_S/intra/%d/%d_%d_stack_intra%d_%d.csv',species,counting,species,mobility,intra);  %%% intra

                if exist(filedir,'file')==0
                    break
                else
                    if mod(counting,5) == 1
                        data=load(filedir);
                        set(gcf,'visible','off');
                        h=histogram(data,50);
                        print('-dpng',sprintf('%d_%d_hist%03d_%d.png',species,mobility,counting,intra));
                    end
                    counting=counting+1;
                end

            end
            video=VideoWriter(sprintf('hist_video_%d.avi',intra));
            video.FrameRate=5;
            open(video);

            imagefile=dir('*.png');
            num=numel(imagefile);

            for tt = 1:num
                ite2=5*(tt-1)+1;
                set(gcf,'visible','on');
                img = imread(sprintf('%d_%d_hist%03d_%d.png',species,mobility,ite2,intra));
                writeVideo(video,img);
            end

            close(video);
            cd(dir4);
        end
        cd(dir3)

    end
    cd(dir2)


end
cd(dir1)
end

function draw_inter_stack
clear all; close all; clc
cd('F:/Data/RPS/hist')
dir1=('F:/Data/RPS/hist');
mkdir('inter_stack');
cd('inter_stack');
dir2=fullfile(dir1,'inter_stack');
for j=1:3
    species=j;
    mkdir(sprintf('%d',species));
    cd(sprintf('%d',species));
    dir3=fullfile(dir2,sprintf('%d',species));
    parfor i = 1:9

        mobility = (i*10)+30;
        counting=1;

        mkdir(sprintf('%d',mobility));
        cd(sprintf('%d',mobility));
        
        while true %%%% counting the number of files

            filedir=sprintf('F:/Data/RPS/data_S/inter/%d/%d_%d_stack_inter%d.csv',species,counting,species,mobility);  %%% inter

            if exist(filedir,'file')==0
                break
            else
                if mod(counting,5) == 1
                    data=load(filedir);
                    set(gcf,'visible','off');
                    h=histogram(data,100);
                    print('-dpng',sprintf('%d_%d_hist%03d.png',species,mobility,counting));
                end
                counting=counting+1;
            end

        end
        video=VideoWriter('hist_video.avi');
        video.FrameRate=5;
        open(video);

        imagefile=dir('*.png');
        num=numel(imagefile);

        for tt = 1:num
            ite2=5*(tt-1)+1;
            set(gcf,'visible','on');
            img = imread(sprintf('%d_%d_hist%03d.png',species,mobility,ite2));
            writeVideo(video,img);
        end

        close(video);
        cd(dir3);
    end
    cd(dir2)

end
cd(dir1)
end


%%%%% intra_lattice %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%
% clear all; close all; clc
% dir1=('F:/Data/RPS/hist');
% mkdir('intra_lattice');
% cd('intra_lattice');
% dir2=fullfile(dir1,'intra_lattice');
% for intra = [2.5,5.2,100]
%     mkdir(sprintf('%d',intra));
%     cd(sprintf('%d',intra))
%     dir3=fullfile(dir2,sprintf('%d',intra));
%     for j=1:3
%         species=j;
%         mkdir(sprintf('%d',species));
%         cd(sprintf('%d',species));
%         dir4=fullfile(dir3,sprintf('%d',species));
%         parfor i = 1:9
% 
%             mobility = (i*10)+30;
%             counting=2;
% 
%             mkdir(sprintf('%d',mobility));
%             cd(sprintf('%d',mobility));
%            
%             while true %%%% counting the number of files
% 
%                 filedir=sprintf('F:/Data/RPS/data_L/intra/%d/%d_%d_lattice_intra%d_%d.csv',species,counting,species,mobility,intra);  %%% intra
% 
%                 if exist(filedir,'file')==0
%                     break
%                 else
%                     if mod(counting,5) == 2
%                         data=load(filedir);
%                         set(gcf,'visible','off');
%                         h=histogram(data,100);
%                         print('-dpng',sprintf('%d_%d_hist%03d_%d.png',species,mobility,counting,intra));
%                     end
%                     counting=counting+1;
%                 end
% 
%             end
%             video=VideoWriter(sprintf('hist_video_%d.avi',intra));
%             video.FrameRate=5;
%             open(video);
% 
%             imagefile=dir('*.png');
%             num=numel(imagefile);
% 
%             for tt = 1:num
%                 ite2=5*(tt-1)+2;
%                 set(gcf,'visible','on');
%                 img = imread(sprintf('%d_%d_hist%03d_%d.png',species,mobility,ite2,intra));
%                 writeVideo(video,img);
%             end
% 
%             close(video);
%             cd(dir4);
%         end
%         cd(dir3)
% 
%     end
%     cd(dir2)
% 
% 
% end
% cd(dir1)
% 
% %%%%% inter_lattice
% %%
% clear all; close all; clc
% 
% dir1=('F:/Data/RPS/hist');
% mkdir('inter_lattice');
% cd('inter_lattice');
% dir2=fullfile(dir1,'inter_lattice');
% 
% for j=1:3
%     species=j;
%     mkdir(sprintf('%d',species));
%     cd(sprintf('%d',species));
%     dir3=fullfile(dir2,sprintf('%d',species));
%     parfor i = 1:9
% 
%         mobility = (i*10)+30;
%         counting=2;
% 
%         mkdir(sprintf('%d',mobility));
%         cd(sprintf('%d',mobility));
%        
% 
%         while true %%%% counting the number of files
% 
%             filedir=sprintf('F:/Data/RPS/data_L/inter/%d/%d_%d_lattice_inter%d.csv',species,counting,species,mobility);  %%% inter
% 
%             if exist(filedir,'file')==0
%                 break
%             else
%                 if mod(counting,5) == 2
%                     data=load(filedir);
%                     set(gcf,'visible','off');
%                     h=histogram(data,100);
%                     print('-dpng',sprintf('%d_%d_hist%03d.png',species,mobility,counting));
%                 end
%                 counting=counting+1;
%             end
% 
%         end
%         video=VideoWriter('hist_video.avi');
%         video.FrameRate=5;
%         open(video);
% 
%         imagefile=dir('*.png');
%         num=numel(imagefile);
% 
%         for tt = 1:num
%             ite2=5*(tt-1)+2;
%             set(gcf,'visible','on');
%             img = imread(sprintf('%d_%d_hist%03d.png',species,mobility,ite2));
%             writeVideo(video,img);
%         end
% 
%         close(video);
%         cd(dir3);
%     end
%     cd(dir2)
% 
% end
% cd(dir1)
% 
% 
% %%%%% inter_stack
% %%
% clear all; close all; clc
% dir1=('F:/Data/RPS/hist');
% mkdir('inter_stack');
% cd('inter_stack');
% dir2=fullfile(dir1,'inter_stack');
% 
% for j=1:3
%     species=j;
%     mkdir(sprintf('%d',species));
%     cd(sprintf('%d',species));
%     dir3=fullfile(dir2,sprintf('%d',species));
%     parfor i = 1:9
% 
%         mobility = (i*10)+30;
%         counting=1;
% 
%         mkdir(sprintf('%d',mobility));
%         cd(sprintf('%d',mobility));
%         
%         while true %%%% counting the number of files
% 
%             filedir=sprintf('F:/Data/RPS/data_S/inter/%d/%d_%d_stack_inter%d.csv',species,counting,species,mobility);  %%% inter
% 
%             if exist(filedir,'file')==0
%                 break
%             else
%                 if mod(counting,5) == 1
%                     data=load(filedir);
%                     set(gcf,'visible','off');
%                     h=histogram(data,100);
%                     print('-dpng',sprintf('%d_%d_hist%03d.png',species,mobility,counting));
%                 end
%                 counting=counting+1;
%             end
% 
%         end
%         video=VideoWriter('hist_video.avi');
%         video.FrameRate=5;
%         open(video);
% 
%         imagefile=dir('*.png');
%         num=numel(imagefile);
% 
%         for tt = 1:num
%             ite2=5*(tt-1)+1;
%             set(gcf,'visible','on');
%             img = imread(sprintf('%d_%d_hist%03d.png',species,mobility,ite2));
%             writeVideo(video,img);
%         end
% 
%         close(video);
%         cd(dir3);
%     end
%     cd(dir2)
% 
% end
% cd(dir1)
% 
% 
% 
