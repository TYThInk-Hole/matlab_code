function RPS_inter_individual_heat(Lsize,pre,ite,reproduction_rate,selection_rate,mobility)
tic
L=randi([1,3],Lsize,Lsize);
RR=sprand(Lsize,Lsize,0.05)+0==0;
Lattice=L.*RR;

Trace=ones(Lsize,Lsize).*RR;
Trace_time=zeros(Lsize,Lsize);

M=1*10^(-mobility*(1/20));

eps=M*(Lsize^2)*(1/2);
r1=(reproduction_rate)/(reproduction_rate+selection_rate+eps);
r2=(selection_rate)/(reproduction_rate+selection_rate+eps);
r3=(eps)/(reproduction_rate+selection_rate+eps);
% stack_Lattice=zeros(Lsize,Lsize,pre+ite);
% kkk=1;
A=[1,0;-1,0;0,1;0, -1];
sur=[];
% ii=1;
% while true
for ii=1:pre+ite
% while true

    stack1=[];stack2=[];stack3=[];
    R=randi([1,Lsize],Lsize^2,2);
    rr=randi([1,4],Lsize^2,1);
    p=rand(Lsize^2,1);
    for i = 1:Lsize^2

        C1=R(i,1)+A(rr(i),1); C2=R(i,2)+A(rr(i),2);
        if C1>Lsize
            C1=1;
        elseif C2>Lsize
            C2=1;
        elseif C1<1
            C1=Lsize;
        elseif C2<1
            C2=Lsize;
        end

        neighbor=Lattice(C1,C2);
        main=Lattice(R(i,1),R(i,2));
        neighbor_trace=Trace(C1,C2);
        main_trace=Trace(R(i,1),R(i,2));
        neighbor_trace_time=Trace_time(C1,C2);
        main_trace_time=Trace_time(R(i,1),R(i,2));

        if p(i) < r3 %move
            Lattice(C1,C2)=main;
            Lattice(R(i,1),R(i,2))=neighbor;
            Trace(C1,C2)=main_trace;
            Trace(R(i,1),R(i,2))=neighbor_trace;
            Trace_time(C1,C2)=main_trace_time;
            Trace_time(R(i,1),R(i,2))=neighbor_trace_time;
        elseif p(i) < r3+r1 %reproduction
            if neighbor==0 && main~=0
                Lattice(C1,C2)=main;
                Trace(C1,C2)=1;
                Trace_time(C1,C2)=1;
            elseif neighbor~=0 && main ==0
                Lattice(R(i,1),R(i,2))=main;
                Trace(R(i,1),R(i,2))=1;
                Trace_time(R(i,1),R(i,2))=1;
            end
        elseif p(i) < r1+r2+r3 %selection
            if neighbor~=0 && main~=0
                if neighbor-main==1
                    %                     if Lattice(C1,C2)==2
                    %                         stack2(end+1,:)=Trace(C1,C2);
                    %                     elseif Lattice(C1,C2)==3
                    %                         stack3(end+1,:)=Trace(C1,C2);
                    %                     end
                    Lattice(C1,C2)=0;
                    Trace(C1,C2)=0;
                    Trace_time(C1,C2)=0;
                elseif neighbor-main==-1
                    %                     if Lattice(R(i,1),R(i,2))==2
                    %                         stack2(end+1,:)=Trace(C1,C2);
                    %                     elseif Lattice(R(i,1),R(i,2))==3
                    %                         stack3(end+1,:)=Trace(C1,C2);
                    %                     end
                    Lattice(R(i,1),R(i,2))=0;
                    Trace(R(i,1),R(i,2))=0;
                    Trace_time(R(i,1),R(i,2))=0;
                elseif neighbor-main==-2
                    %                     if Lattice(C1,C2)==1
                    %                         stack1(end+1,:)=Trace(C1,C2);
                    %                     end
                    Lattice(C1,C2)=0;
                    Trace(C1,C2)=0;
                    Trace_time(C1,C2)=0;
                elseif neighbor-main==2
                    %                     if Lattice(R(i,1),R(i,2))==1
                    %                         stack1(end+1,:)=Trace(C1,C2);
                    %                     end
                    Lattice(R(i,1),R(i,2))=0;
                    Trace(R(i,1),R(i,2))=0;
                    Trace_time(R(i,1),R(i,2))=0;
                end
            end
        end

    end
    Trace=Trace+(Trace~=0)-Trace_time;
    Trace_time=zeros(Lsize,Lsize);
    if ii>pre
        figure(1); heatmap(Trace,'colormap',jet);
        figure(2); heatmap(Lattice,'Colormap',summer);
        %     if ii>pre
        %         for iii=1:Lsize^2
        %             if Lattice(iii)==1
        %                 stack1(end+1,:)=Trace(iii);
        %             elseif Lattice(iii)==2
        %                 stack2(end+1,:)=Trace(iii);
        %             elseif Lattice(iii)==3
        %                 stack3(end+1,:)=Trace(iii);
        %                 %     L1=length(find(Lattice==1));
        %                 %     L2=length(find(Lattice==2));
        %                 %     L3=length(find(Lattice==3));
        %             end
        %         end
        %         if mod(ii,500)==0
        %             kkk=kkk+1;
        %         end
        %     end
        L1=length(find(Lattice==1));
        L2=length(find(Lattice==2));
        L3=length(find(Lattice==3));
        L4=length(find(Lattice==0));
        sur(end+1,:)=[L1,L2,L3,L4];
        figure(3); plot(ii-pre,sur(ii-pre,1),'bo'); hold on; plot(ii-pre,sur(ii-pre,2),'ro'); hold on; plot(ii-pre,sur(ii-pre,3),'go'); hold on;plot(ii-pre,sur(ii-pre,4),'ko'); hold on;
%         ii=ii+1;
    end
    %%%%%%%%%%%%%%%%  Kcore   %%%%%%%%%%%%%%%%%%%%
    %     dlmwrite(sprintf('F:/RPS/inter_dt/1/%d_1_stack_inter%d.csv',kkk,mobility),stack1,'delimiter',',','-append');
    %     dlmwrite(sprintf('F:/RPS/inter_dt/2/%d_2_stack_inter%d.csv',kkk,mobility),stack2,'delimiter',',','-append');
    %     dlmwrite(sprintf('F:/RPS/inter_dt/3/%d_3_stack_inter%d.csv',kkk,mobility),stack3,'delimiter',',','-append');
    %%%%%%%%%%%%%%%%%   dell   %%%%%%%%%%%%%%%%%%%%
    %     dlmwrite(sprintf('E:/Data/RPS/inter_dt_L/1/%d_1_stack_inter%d_%d.csv',kkk,reproduction_rate,mobility),stack1,'delimiter',',','-append');
    %     dlmwrite(sprintf('E:/Data/RPS/inter_dt_L/2/%d_2_stack_inter%d_%d.csv',kkk,reproduction_rate,mobility),stack2,'delimiter',',','-append');
    %     dlmwrite(sprintf('E:/Data/RPS/inter_dt_L/3/%d_3_stack_inter%d_%d.csv',kkk,reproduction_rate,mobility),stack3,'delimiter',',','-append');

    %     if ii > pre
    %         stack_Lattice(:,:,ii)=Lattice;
    %     end
    %
end
% dlmwrite(sprintf('F:/RPS/intra_dt/1/sur%d.csv',mobility),sur,'delimiter',',','-append');
% save('Lattice','Lattice')
% numbering=num2str(mobility);
% file_lattice=append('stack_Lattice',numbering);
% save(sprintf('file_lattice%d',mobility),'stack_Lattice');
% file_stack=append('stack',numbering);
% csvwrite(sprintf('1_stack_inter%d.csv',mobility),stack1);
% csvwrite(sprintf('2_stack_inter%d.csv',mobility),stack2);
% csvwrite(sprintf('3_stack_inter%d.csv',mobility),stack3);
toc
end



