%%  Topological clustering through the Wasserstin distance
%
%
%% The clustering part of codes and simulations are based on 
% Chung, M.K., Huang, S.-G., Carroll, I.C., Calhoun, V.D., Goldsmith, H.H. 
% 2023 Topological  State-Space Estimation of Functional Human Brain Networks. arXiv:2201:00087
% 
%% The Wasserstein distance part of codes are based on
% Songdechakraiwut, T. Chung, M.K. 2023 Topological learning 
% for brain networks, Annals of Applied Statistics 17:403-433, arXiv: 2012.00675
%
%
% The code is downloaded from
% https://github.com/laplcebeltrami/clustering
% (C) 2021- Moo K. Chung
%
% Update history
% December 22, 2021 create
% Otober 24, 2022 updated
% Mar 25, 2023 new examples added


% Simulation should generate topological differnce while there is not much
% geometric difference. 

% (C) 2021 Moo K. Chung
%  University of Wisconsin-Madison


%% Random network simulation of topological difference

nGroup1 = 5;
nGroup2 = 5;
nGroup3 = 5;
nGroup4 = 5;
g1 = cell(nGroup1, 1);
g2 = cell(nGroup2, 1);
g3 = cell(nGroup3, 1);
g4 = cell(nGroup4, 1);

sigma=0.05
npoints=200

%--------------
%two circles horizontally

figure; subplot(2,2,1);cla()

coord = graph_arc([0.5 0],1.75, [0 2*pi], npoints, 0)
hold on; plot(coord(:,1),coord(:,2),'Color',[.7 .7 .7], 'LineWidth',1)';

coord = graph_arc([1 0],1, [0   2*pi], npoints, 0)
plot(coord(:,1),coord(:,2), 'Color',[.7 .7 .7], 'LineWidth',1)';


for i=1:5
    circle1 = graph_arc([0.5 0],1.75, [0 2*pi], npoints, sigma)
    circle2 = graph_arc([1 0],1, [0 2*pi], npoints, sigma)
    obs =[circle1; circle2];
    hold on; plot(obs(:,1), obs(:,2),'.k');
    coord=[obs(:,1)  obs(:,2)];
    C = pdist(coord);
    C=squareform(C);
    %figure; imagesc(C); colorbar
    g1{i}=C;
end

axis square; box on
figure_bigger(16)
xlim([-3 3]); ylim([-3 3])
title('Group 1')

%print_pdf('simul_cir')

%--------------
%two circles translated to right


subplot(2,2,2);cla()

coord = graph_arc([0.5 0],1.75, [0 2*pi], npoints, 0)
hold on; plot(coord(:,1),coord(:,2),'Color',[.7 .7 .7], 'LineWidth',1)';

coord = graph_arc([1 0],1, [pi/15   2*pi-pi/7], npoints, 0)
plot(coord(:,1),coord(:,2), 'Color',[.7 .7 .7], 'LineWidth',1)';


for i=1:5
    circle1 = graph_arc([0.5 0],1.75, [0 2*pi], npoints, sigma)
    circle2 = graph_arc([1 0],1, [pi/15   2*pi-pi/7], npoints, sigma)
    obs =[circle1; circle2];
    hold on; plot(obs(:,1), obs(:,2),'.k');
    coord=[obs(:,1)  obs(:,2)];
    C = pdist(coord);
    C=squareform(C);
    %figure; imagesc(C); colorbar
    g2{i}=C;
end

axis square; box on
figure_bigger(16)
xlim([-3 3]); ylim([-3 3])
title('Group 2')

%--------------
%two circles vertically

subplot(2,2,3);cla()

coord = graph_arc([0.5 0],1.75, [pi+pi/20 pi-pi/20+2*pi], npoints, 0)
hold on; plot(coord(:,1),coord(:,2),'Color',[.7 .7 .7], 'LineWidth',1)';

coord = graph_arc([1 0],1, [pi/15   2*pi-pi/7], npoints, 0)
plot(coord(:,1),coord(:,2), 'Color',[.7 .7 .7], 'LineWidth',1)';


for i=1:5
    circle1 = graph_arc([0.5 0],1.75, [pi+pi/20 pi-pi/20+2*pi], npoints, sigma)
    circle2 = graph_arc([1 0],1, [pi/15   2*pi-pi/7], npoints, sigma)
    obs =[circle1; circle2];
    hold on; plot(obs(:,1), obs(:,2),'.k');
    coord=[obs(:,1)  obs(:,2)];
    C = pdist(coord);
    C=squareform(C);
    %figure; imagesc(C); colorbar
    g3{i}=C;
end

axis square; box on
figure_bigger(16)
xlim([-3 3]); ylim([-3 3])
title('Group 3')


%--------------
%two circles vertically translated

subplot(2,2,4);cla()

coord = graph_arc([0.5 0],1.75, [pi/20 2*pi-pi/20], npoints, 0)
hold on; plot(coord(:,1),coord(:,2),'Color',[.7 .7 .7], 'LineWidth',1)';

coord = graph_arc([1.75 0],1, [pi+pi/7   pi-pi/20+ 2*pi], npoints, 0)
plot(coord(:,1),coord(:,2), 'Color',[.7 .7 .7], 'LineWidth',1)';


for i=1:5
    circle1 = graph_arc([0.5 0],1.75, [pi/20 2*pi-pi/20], npoints, sigma)
    circle2 = graph_arc([1.75 0],1, [pi+pi/7   pi-pi/20+ 2*pi], npoints, sigma)
    obs =[circle1; circle2];
    hold on; plot(obs(:,1), obs(:,2),'.k');
    coord=[obs(:,1)  obs(:,2)];
    C = pdist(coord);
    C=squareform(C);
    %figure; imagesc(C); colorbar
    g4{i}=C;
end

axis square; box on
figure_bigger(16)
xlim([-3 3]); ylim([-3 3])
title('Group 4')


%% Pairwise distance matrix 
% The Wasserstein distance is showing clustering pattern 
% that seperates all 4 groups. So the topological clustering will do well
% While L2-norm is showing clustering pattern that is unable to differentiate
% group 1 and 2. Thus k-means clustering that uses the L2-norm is expected not 
% to perform better than the Wasserstein distance. 

figure; subplot(1,2,1)
g=[g1;g2; g3;g4];
lossMtx = WS_distace2matrix(g)
imagesc(lossMtx); colorbar
axis square
figure_bigger(16)
colormap('hot')
title('Wasserstein')

subplot(1,2,2)
lossMtx = WS_L2distace2matrix(g)
imagesc(lossMtx); colorbar
axis square
figure_bigger(16)
colormap('hot')
title('L2-norm')



%% Topological clustering using Wasserstein distance
% All the theoretical issues are explained in
% Chung, M.K., Huang, S.-G., Carroll, I.C., Calhoun, V.D., 
% Goldsmith, H.H. 2022 Dynamic topological data analysis 
% for brain networks via Wasserstein graph clustering. arXiv:2201:00087

n1 = length(g1);
n2 = length(g2);
n3 = length(g3);
n4 = length(g4);

nNetworks = n1+n2+n3+n4; %total number of networks

% Perform birth-death decomposition 
for i=1:n1
[b1{i}, d1{i}] =WS_decompose(g1{i});
end

for i=1:n2
[b2{i}, d2{i}] =WS_decompose(g2{i});
end

for i=1:n3
[b3{i}, d3{i}] =WS_decompose(g3{i});
end

for i=1:n4
[b4{i}, d4{i}] =WS_decompose(g4{i});
end

%Tranforms death values into a matrix form of size (nBirths+nDeaths) x nNetworks

M1=[];
for i=1:n1
    M1(:,i)=[b1{i}(:,3); d1{i}(:,3)];
end

M2=[];
for i=1:n2
    M2(:,i)=[b2{i}(:,3); d2{i}(:,3)];
end

M3=[];
for i=1:n2
    M3(:,i)=[b3{i}(:,3); d3{i}(:,3)];
end

M4=[];
for i=1:n2
    M4(:,i)=[b4{i}(:,3); d4{i}(:,3)];
end

M=[M1, M2, M3, M4];

%M is a matrix of size # of (brith + death values) x # of subjects

%The clustering_accuracy.m computation is based on the techncial report 
%https://github.com/laplcebeltrami/clustering/blob/main/clustering.accuracy.pdf
accuracy=[];
for i=1:100
    ypred = kmeans(M',4);
    ytrue = [ones(5,1); 2*ones(5,1); 3*ones(5,1); 4*ones(5,1)];
    [acc C] = clustering_accuracy(ytrue,ypred);
    accuracy(i)=acc;
end
[mean(accuracy) std(accuracy)]
% 0.9505    0.1190
% 0.9805    0.0778
% 0.9655    0.0989 
% clustering accuracy reported in mean +- s.d. reported using differnet
% version of matlab and computers



%Comparision against baseline k-means clustering which is directly
%applied to correlations on edges.

nNodes = size(coord,1);
nEdges = nNodes*(nNodes-1)/2;

C=zeros(nEdges,nNetworks);

for i=1:n1
C(:,i) =adj2vec(g1{i});
end

for i=1:n2
C(:,n1+i) =adj2vec(g2{i});
end

for i=1:n3
C(:,n1+n2+i) =adj2vec(g3{i});
end

for i=1:n4
C(:,n1+n2+n3+i) =adj2vec(g4{i});
end

accuracy = [];
for i=1:100
    ypred = kmeans(C',4);
    ytrue = [ones(5,1); 2*ones(5,1); 3*ones(5,1); 4*ones(5,1)];
    [acc Conf] = clustering_accuracy(ytrue,ypred);
    accuracy(i)=acc;
end

[mean(accuracy) std(accuracy)]
% 0.8090    0.1582
% 0.8395    0.1448 
% clustering accurasy reported as mean +- s.d.
 

%% Checking if combined features (topological + correlation) works or not
%Conclution: combining feature doesn't work in clustering

combined = [M;C]; %topology + correlation

accuracy = [];
for i=1:100
    ypred = kmeans(combined',4);
    ytrue = [ones(5,1); 2*ones(5,1); 3*ones(5,1); 4*ones(5,1)];
    [acc Conf] = clustering_accuracy(ytrue,ypred);
    accuracy(i)=acc;
end

[mean(accuracy) std(accuracy)]
%0.8485    0.1553
%0.8415    0.1562
%clustering accurasy reported as mean +- s.d.


