function RPS_inter_individual_heat_Mu(Lsize,pre,ite,re1,re2,re3,selection_rate,mobility)

L=randi([1,3],Lsize,Lsize);
RR=sprand(Lsize,Lsize,0.05)+0==0;
Lattice=L.*RR;

Trace=ones(Lsize,Lsize).*RR;
Trace_time=zeros(Lsize,Lsize);

M=1*10^(-mobility*(1/20));

reproduction_rate=re1+re2+re3;

eps=M*(Lsize^2)*(1/2);
r1=(re1)/(reproduction_rate+selection_rate+eps);
r2=(re2)/(reproduction_rate+selection_rate+eps);
r3=(re3)/(reproduction_rate+selection_rate+eps);
r4=(selection_rate)/(reproduction_rate+selection_rate+eps);
r5=(eps)/(reproduction_rate+selection_rate+eps);

% stack_Lattice=zeros(Lsize,Lsize,pre+ite);
% kkk=1;
A=[1,0;-1,0;0,1;0, -1];

% ii=1;
% while true
for ii=1:pre+ite
    % while true
    sur=[];
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

        if p(i) < r5 %move
            Lattice(C1,C2)=main;
            Lattice(R(i,1),R(i,2))=neighbor;
            Trace(C1,C2)=main_trace;
            Trace(R(i,1),R(i,2))=neighbor_trace;
            Trace_time(C1,C2)=main_trace_time;
            Trace_time(R(i,1),R(i,2))=neighbor_trace_time;
        elseif p(i) < r5+r1+r2+r3 %reproduction
            if p(i) < r5+r1
                if neighbor==0 && main==1
                    Lattice(C1,C2)=main;
                    Trace(C1,C2)=1;
                    Trace_time(C1,C2)=1;
                elseif neighbor==1 && main==1
                    Lattice(C1,C2)=main;
                    Trace(C1,C2)=1;
                    Trace_time(C1,C2)=1;
                end
            elseif p(i) < r5+r1+r2
                if neighbor==0 && main==2
                    Lattice(C1,C2)=main;
                    Trace(C1,C2)=1;
                    Trace_time(C1,C2)=1;
                elseif neighbor==2 && main==0
                    Lattice(C1,C2)=main;
                    Trace(C1,C2)=1;
                    Trace_time(C1,C2)=1;
                end
            elseif p(i) < r5+r1+r2+r3
                if neighbor==0 && main==3
                    Lattice(C1,C2)=main;
                    Trace(C1,C2)=1;
                    Trace_time(C1,C2)=1;
                elseif neighbor==3 && main ==0
                    Lattice(C1,C2)=main;
                    Trace(C1,C2)=1;
                    Trace_time(C1,C2)=1;
                end
            end
        elseif p(i) < r1+r2+r3+r4+r5 %selection
            if neighbor~=0 && main~=0
                if neighbor-main==1
                    Lattice(C1,C2)=0;
                    Trace(C1,C2)=0;
                    Trace_time(C1,C2)=0;
                elseif neighbor-main==-1
                    Lattice(R(i,1),R(i,2))=0;
                    Trace(R(i,1),R(i,2))=0;
                    Trace_time(R(i,1),R(i,2))=0;
                elseif neighbor-main==-2
                    Lattice(C1,C2)=0;
                    Trace(C1,C2)=0;
                    Trace_time(C1,C2)=0;
                elseif neighbor-main==2
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
%         figure(1); heatmap(Trace,'colormap',jet);
%         figure(2); heatmap(Lattice,'Colormap',summer);
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
%         figure(3); plot(ii-pre,sur(ii-pre,1),'bo'); hold on; plot(ii-pre,sur(ii-pre,2),'ro'); hold on; plot(ii-pre,sur(ii-pre,3),'go'); hold on;plot(ii-pre,sur(ii-pre,4),'ko'); hold on;
    end
    dlmwrite('sur.csv',sur,'delimiter',',','-append');

end

end



