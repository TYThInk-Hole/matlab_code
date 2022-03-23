function RPSLS_intra_individual_L(Lsize,pre,ite,step,reproduction_rate,selection_rate,mobility,intra1,intra2,intra3,intra4,intra5)
tic

% Lsize=300;
% pre=0;
% ite=200;
% reproduction_rate=1;
% selection_rate=1;
% mobility=80;
% intra1=1.9;
% intra2=2.0;
% intra3=[3.3, 5.65, 6.5, 100];
% intra4=1.3;
% intra5=0.7;

Lattice=randi([0,5],Lsize,Lsize); % lattice which there exist 5species and empty space

Trace=sparse(ones(Lsize,Lsize).*(Lattice>0)); % extracting life time of individual
Trace_time=sparse(zeros(Lsize,Lsize)); % new born individuals location on lattice

M=1.8*10^(-mobility*(1/20)); % mobility

eps=M*(Lsize^2)*(2); % rate of exchange

intra_sum=intra1+intra2+intra3+intra4+intra5;

interval=5;

r1=(reproduction_rate)/(reproduction_rate+selection_rate+eps+intra_sum);
r2=(selection_rate)/(reproduction_rate+selection_rate+eps+intra_sum);
r3=(eps)/(reproduction_rate+selection_rate+eps+intra_sum);
r4=(intra1)/(reproduction_rate+selection_rate+eps+intra_sum);
r5=(intra2)/(reproduction_rate+selection_rate+eps+intra_sum);
r6=(intra3)/(reproduction_rate+selection_rate+eps+intra_sum);
r7=(intra4)/(reproduction_rate+selection_rate+eps+intra_sum);
r8=(intra5)/(reproduction_rate+selection_rate+eps+intra_sum);


A=[1,0;-1,0;0,1;0, -1]; % location of neighbors

Data_Cell=cell(ite/interval,2); %1 : stack , 2 : lattice
for k=1:ite/step
    for ii=step*(k-1):step*k
        stack_intra=zeros(Lsize^2,5);

        R=randi([1,Lsize],Lsize^2,2); % pre-selection
        rr=randi([1,4],Lsize^2,1); % % choose location of neighbors
        p=rand(Lsize^2,1);

        Cpre=[R(1:Lsize^2,1)+A(rr(1:Lsize^2),1), R(1:Lsize^2,2)+A(rr(1:Lsize^2),2)];
        C1 = Cpre > Lsize;
        C2 = Cpre < 1;

        C = Cpre.*(~C1.*~C2) + C1 + C2*Lsize;

        for i = 1:Lsize^2

            neighbor=Lattice(C(i,1),C(i,2));
            main=Lattice(R(i,1),R(i,2));
            neighbor_trace=Trace(C(i,1),C(i,2));
            main_trace=Trace(R(i,1),R(i,2));
            neighbor_trace_time=Trace_time(C(i,1),C(i,2));
            main_trace_time=Trace_time(R(i,1),R(i,2));

            if p(i) < r3 %move
                Lattice(C(i,1),C(i,2))=main;
                Lattice(R(i,1),R(i,2))=neighbor;
                Trace(C(i,1),C(i,2))=main_trace;
                Trace(R(i,1),R(i,2))=neighbor_trace;
                Trace_time(C(i,1),C(i,2))=main_trace_time;
                Trace_time(R(i,1),R(i,2))=neighbor_trace_time;

            elseif p(i) < r3+r1 %reproduction
                if neighbor==0 && main~=0
                    Lattice(C(i,1),C(i,2))=main;
                    Trace(C(i,1),C(i,2))=1;
                    Trace_time(C(i,1),C(i,2))=1;
                elseif neighbor ~= 0 && main == 0
                    Lattice(R(i,1),R(i,2))=neighbor;
                    Trace(R(i,1),R(i,2))=1;
                    Trace_time(R(i,1),R(i,2))=1;
                end
            elseif p(i) < r1+r2+r3+r4+r5+r6+r7+r8 %selection
                if neighbor~=0 && main~=0
                    if p(i) < r1+r2+r3
                        if neighbor-main==1
                            if ii > pre
                                if Lattice(C(i,1),C(i,2))==2
                                    stack_intra(i,2)=Trace(C(i,1),C(i,2));
                                elseif Lattice(C(i,1),C(i,2))==3
                                    stack_intra(i,3)=Trace(C(i,1),C(i,2));
                                elseif Lattice(C(i,1),C(i,2))==4
                                    stack_intra(i,4)=Trace(C(i,1),C(i,2));
                                elseif Lattice(C(i,1),C(i,2))==5
                                    stack_intra(i,5)=Trace(C(i,1),C(i,2));
                                end
                            end
                            Lattice(C(i,1),C(i,2))=0;
                            Trace(C(i,1),C(i,2))=0;
                            Trace_time(C(i,1),C(i,2))=0;
                        elseif neighbor-main==-1
                            if ii > pre
                                if Lattice(C(i,1),C(i,2))==1
                                    stack_intra(i,2)=Trace(R(i,1),R(i,2));
                                elseif Lattice(C(i,1),C(i,2))==2
                                    stack_intra(i,3)=Trace(R(i,1),R(i,2));
                                elseif Lattice(C(i,1),C(i,2))==3
                                    stack_intra(i,4)=Trace(R(i,1),R(i,2));
                                elseif Lattice(C(i,1),C(i,2))==4
                                    stack_intra(i,5)=Trace(R(i,1),R(i,2));
                                end
                            end
                            Lattice(R(i,1),R(i,2))=0;
                            Trace(R(i,1),R(i,2))=0;
                            Trace_time(R(i,1),R(i,2))=0;
                        elseif neighbor-main==-4
                            if ii > pre
                                if Lattice(C(i,1),C(i,2))==1
                                    stack_intra(i,1)=Trace(C(i,1),C(i,2));
                                end
                            end
                            Lattice(C(i,1),C(i,2))=0;
                            Trace(C(i,1),C(i,2))=0;
                            Trace_time(C(i,1),C(i,2))=0;
                        elseif neighbor-main==4
                            if ii > pre
                                if Lattice(C(i,1),C(i,2))==5
                                    stack_intra(i,1)=Trace(R(i,1),R(i,2));
                                end
                            end
                            Lattice(R(i,1),R(i,2))=0;
                            Trace(R(i,1),R(i,2))=0;
                            Trace_time(R(i,1),R(i,2))=0;
                        end
                        %%%%% intra rate
                    elseif p(i) < r1+r2+r3+r4
                        if main== 1 && neighbor == 1
                            pp=rand;
                            if pp <= 0.5
                                if ii > pre
                                    stack_intra(i,1)=Trace(C(i,1),C(i,2));
                                end
                                Lattice(C(i,1),C(i,2))=0;
                                Trace(C(i,1),C(i,2))=0;
                                Trace_time(C(i,1),C(i,2))=0;
                            elseif pp > 0.5
                                if ii > pre
                                    stack_intra(i,1)=Trace(R(i,1),R(i,2));
                                end
                                Lattice(R(i,1),R(i,2))=0;
                                Trace(R(i,1),R(i,2))=0;
                                Trace_time(R(i,1),R(i,2))=0;
                            end
                        end
                    elseif p(i) < r1+r2+r3+r4+r5
                        if main==2 && neighbor ==2
                            pp=rand;
                            if pp <= 0.5
                                if ii > pre
                                    stack_intra(i,2)=Trace(C(i,1),C(i,2));
                                end
                                Lattice(C(i,1),C(i,2))=0;
                                Trace(C(i,1),C(i,2))=0;
                                Trace_time(C(i,1),C(i,2))=0;
                            elseif pp > 0.5
                                if ii > pre
                                    stack_intra(i,2)=Trace(R(i,1),R(i,2));
                                end
                                Lattice(R(i,1),R(i,2))=0;
                                Trace(R(i,1),R(i,2))=0;
                                Trace_time(R(i,1),R(i,2))=0;
                            end
                        end
                    elseif p(i) < r1+r2+r3+r4+r5+r6
                        if main==3 && neighbor ==3
                            pp=rand;
                            if pp <= 0.5
                                if ii > pre
                                    stack_intra(i,3)=Trace(C(i,1),C(i,2));
                                end
                                Lattice(C(i,1),C(i,2))=0;
                                Trace(C(i,1),C(i,2))=0;
                                Trace_time(C(i,1),C(i,2))=0;
                            elseif pp > 0.5
                                if ii > pre
                                    stack_intra(i,3)=Trace(R(i,1),R(i,2));
                                end
                                Lattice(R(i,1),R(i,2))=0;
                                Trace(R(i,1),R(i,2))=0;
                                Trace_time(R(i,1),R(i,2))=0;
                            end
                        end
                    elseif p(i) < r1+r2+r3+r4+r5+r6+r7
                        if main==4 && neighbor ==4
                            pp=rand;
                            if pp <= 0.5
                                if ii > pre
                                    stack_intra(i,4)=Trace(C(i,1),C(i,2));
                                end
                                Lattice(C(i,1),C(i,2))=0;
                                Trace(C(i,1),C(i,2))=0;
                                Trace_time(C(i,1),C(i,2))=0;
                            elseif pp > 0.5
                                if ii > pre
                                    stack_intra(i,4)=Trace(R(i,1),R(i,2));
                                end
                                Lattice(R(i,1),R(i,2))=0;
                                Trace(R(i,1),R(i,2))=0;
                                Trace_time(R(i,1),R(i,2))=0;
                            end
                        end
                    elseif p(i) < r1+r2+r3+r4+r5+r6+r7+r8
                        if main==5 && neighbor ==5
                            pp=rand;
                            if pp <= 0.5
                                if ii > pre
                                    stack_intra(i,5)=Trace(C(i,1),C(i,2));
                                end
                                Lattice(C(i,1),C(i,2))=0;
                                Trace(C(i,1),C(i,2))=0;
                                Trace_time(C(i,1),C(i,2))=0;
                            elseif pp > 0.5
                                if ii > pre
                                    stack_intra(i,5)=Trace(R(i,1),R(i,2));
                                end
                                Lattice(R(i,1),R(i,2))=0;
                                Trace(R(i,1),R(i,2))=0;
                                Trace_time(R(i,1),R(i,2))=0;
                            end
                        end
                    end
                end
            end
            clear main neighbor main_trace neighbor_trace...
                main_trace_time neighbor_trace_time pp
            
        end
        Trace=Trace+(Trace~=0)-Trace_time;
        clear Trace_time
        Trace_time=zeros(Lsize,Lsize);

        if mod(ii,interval)==0
            stack_lattice=zeros(Lsize^2,5);

            Trace_A = sparse(reshape(Trace.*(Lattice==1),[],1)); %species age at the time.
            Trace_B = sparse(reshape(Trace.*(Lattice==2),[],1));
            Trace_C = sparse(reshape(Trace.*(Lattice==3),[],1));
            Trace_D = sparse(reshape(Trace.*(Lattice==4),[],1));
            Trace_E = sparse(reshape(Trace.*(Lattice==5),[],1));

            stack_lattice(:,1)=Trace_A;
            stack_lattice(:,2)=Trace_B;
            stack_lattice(:,3)=Trace_C;
            stack_lattice(:,4)=Trace_D;
            stack_lattice(:,5)=Trace_E;

            Stacks=sparse(stack_intra);

            Data_Cell{(ii-pre)/interval,1}=Stacks;
            Data_Cell{(ii-pre)/interval,2}=stack_lattice;
            clear stack_lattice stack_intra Stacks;
        end
            clear R rr p Cpre C1 C2 C;
    end
end

save(sprintf('/Volumes/yoonD/Data/RPSLS1/Cell_A_%d_%d.mat',intra3,mobility),'Data_Cell','-v7.3');
toc
end
