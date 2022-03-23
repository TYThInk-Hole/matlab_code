function RPS_intra_individual_L_Mu(Lsize,pre,ite,re1,re2,re3,selection_rate,mobility,intra1,intra2,intra3)
L=randi([1,3],Lsize,Lsize);
RR=sprand(Lsize,Lsize,0.05)+0==0;
Lattice=L.*RR;

Trace=ones(Lsize,Lsize).*RR;
Trace_time=zeros(Lsize,Lsize);

M=1.8*10^(-mobility*(1/20));

reproduction_rate=re1+re2+re3;

eps=M*(Lsize^2)*(1/2);
intra_sum=intra1+intra2+intra3;
r1=(re1)/(reproduction_rate+selection_rate+eps+intra_sum);
r2=(re2)/(reproduction_rate+selection_rate+eps+intra_sum);
r3=(re3)/(reproduction_rate+selection_rate+eps+intra_sum);
r4=(selection_rate)/(reproduction_rate+selection_rate+eps+intra_sum);
r5=(eps)/(reproduction_rate+selection_rate+eps+intra_sum);
r6=(intra1)/(reproduction_rate+selection_rate+eps+intra_sum);
r7=(intra2)/(reproduction_rate+selection_rate+eps+intra_sum);
r8=(intra3)/(reproduction_rate+selection_rate+eps+intra_sum);

kkk=1;
A=[1,0;-1,0;0,1;0, -1];
% sur=[];

for ii=1:pre+ite
    stack_intra1=[];stack_intra2=[];stack_intra3=[];
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
                elseif neighbor == 1 && main == 0
                    Lattice(R(i,1),R(i,2))=neighbor;
                    Trace(R(i,1),R(i,2))=1;
                    Trace_time(R(i,1),R(i,2))=1;
                end
            elseif p(i) < r5+r1+r2
                if neighbor==0 && main==2
                    Lattice(C1,C2)=main;
                    Trace(C1,C2)=1;
                    Trace_time(C1,C2)=1;
                elseif neighbor == 2 && main == 0
                    Lattice(R(i,1),R(i,2))=neighbor;
                    Trace(R(i,1),R(i,2))=1;
                    Trace_time(R(i,1),R(i,2))=1;
                end
            elseif p(i) < r5+r1+r2+r3
                if neighbor==0 && main==3
                    Lattice(C1,C2)=main;
                    Trace(C1,C2)=1;
                    Trace_time(C1,C2)=1;
                elseif neighbor == 3 && main == 0
                    Lattice(R(i,1),R(i,2))=neighbor;
                    Trace(R(i,1),R(i,2))=1;
                    Trace_time(R(i,1),R(i,2))=1;
                end
            end    
        elseif p(i) < r1+r2+r3+r4+r5+r6+r7+r8 %selection
            if neighbor~=0 && main~=0
                if p(i) < r1+r2+r3+r4+r5
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
                elseif p(i) < r1+r2+r3+r4+r5+r6
                    if main==1 && neighbor ==1
                        pp=rand;
                        if pp <= 0.5
                            Lattice(C1,C2)=0;
                            Trace(C1,C2)=0;
                            Trace_time(C1,C2)=0;
                        elseif pp > 0.5
                            Lattice(R(i,1),R(i,2))=0;
                            Trace(R(i,1),R(i,2))=0;
                            Trace_time(R(i,1),R(i,2))=0;
                        end
                    end
                elseif p(i) < r1+r2+r3+r4+r5+r6+r7
                    if main==2 && neighbor ==2
                        pp=rand;
                        if pp <= 0.5
                            Lattice(C1,C2)=0;
                            Trace(C1,C2)=0;
                            Trace_time(C1,C2)=0;
                        elseif pp > 0.5
                            Lattice(R(i,1),R(i,2))=0;
                            Trace(R(i,1),R(i,2))=0;
                            Trace_time(R(i,1),R(i,2))=0;
                        end
                    end
                elseif p(i) < r1+r2+r3+r4+r5+r6+r7+r8
                    if main==3 && neighbor ==3
                        pp=rand;
                        if pp <= 0.5
                            Lattice(C1,C2)=0;
                            Trace(C1,C2)=0;
                            Trace_time(C1,C2)=0;
                        elseif pp > 0.5
                            Lattice(R(i,1),R(i,2))=0;
                            Trace(R(i,1),R(i,2))=0;
                            Trace_time(R(i,1),R(i,2))=0;
                        end
                    end
                end
            end
        end

    end
    Trace=Trace+(Trace~=0)-Trace_time;
    Trace_time=zeros(Lsize,Lsize);
    Trace_A = Trace.*(Lattice==1);
    Trace_B = Trace.*(Lattice==2);
    Trace_C = Trace.*(Lattice==3);
    if ii == 1
        kkk=ii;
        writematrix(Trace_A,sprintf('F:/Data/RPS/data_L/intra_dt_L_40/1/%d_1_stack_intra%d.csv',kkk,intra1),'delimiter',',');
        writematrix(Trace_B,sprintf('F:/Data/RPS/data_L/intra_dt_L_40/2/%d_2_stack_intra%d.csv',kkk,intra1),'delimiter',',');
        writematrix(Trace_C,sprintf('F:/Data/RPS/data_L/intra_dt_L_40/3/%d_3_stack_intra%d.csv',kkk,intra1),'delimiter',',');
        writematrix(Lattice==1,sprintf('F:/Data/RPS/data_L/intra_dt_L_40/1_1/%d_1_stack_intra%d.csv',kkk,intra1),'delimiter',',');
        writematrix(Lattice==2,sprintf('F:/Data/RPS/data_L/intra_dt_L_40/2_1/%d_2_stack_intra%d.csv',kkk,intra1),'delimiter',',');
        writematrix(Lattice==3,sprintf('F:/Data/RPS/data_L/intra_dt_L_40/3_1/%d_3_stack_intra%d.csv',kkk,intra1),'delimiter',',');

    elseif mod(ii,100)==0
        kkk=ii;
        writematrix(Trace_A,sprintf('F:/Data/RPS/data_L/intra_dt_L_40/1/%d_1_stack_intra%d.csv',kkk,intra1),'delimiter',',');
        writematrix(Trace_B,sprintf('F:/Data/RPS/data_L/intra_dt_L_40/2/%d_2_stack_intra%d.csv',kkk,intra1),'delimiter',',');
        writematrix(Trace_C,sprintf('F:/Data/RPS/data_L/intra_dt_L_40/3/%d_3_stack_intra%d.csv',kkk,intra1),'delimiter',',');
        writematrix(Lattice==1,sprintf('F:/Data/RPS/data_L/intra_dt_L_40/1_1/%d_1_stack_intra%d.csv',kkk,intra1),'delimiter',',');
        writematrix(Lattice==2,sprintf('F:/Data/RPS/data_L/intra_dt_L_40/2_1/%d_2_stack_intra%d.csv',kkk,intra1),'delimiter',',');
        writematrix(Lattice==3,sprintf('F:/Data/RPS/data_L/intra_dt_L_40/3_1/%d_3_stack_intra%d.csv',kkk,intra1),'delimiter',',');
    end
end

end

