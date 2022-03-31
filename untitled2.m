close all; clear; clc;
intra=2.5;
mobility=30;
for ite=1:5
    D=struct2cell(load(sprintf('/volumes/Data/Data/intra3/Cell_intra3_%d_%d_%d',intra,mobility,ite)));
    Data=D{1,1};
    for i = 1:500

        Lattice=Data{i,2};

        A=numel(nonzeros(Lattice(:,1)));
        B=numel(nonzeros(Lattice(:,2)));
        C=numel(nonzeros(Lattice(:,3)));
        plot(500*(ite-1)+i,A,'bo'); hold on; plot(500*(ite-1)+i,B,'ro'); hold on; plot(500*(ite-1)+i,C,'go'); hold on; pause(0.05);
        clear Lattice
    end
    clear D Data
end