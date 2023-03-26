%% Topological clustering through the Wasserstin distance
%% The clustering part of codes and simulations are based on 
%
% [1] Moo K. Chung, Camille Garcia Ramos, Felipe Branco De Paiva, Jedidiah Mathis, Vivek Prabharakaren, 
% Veena A. Nair, Elizabeth Meyerand, Bruce P. Hermann, Jeffery R. Binder, Aaron F. Struck, 2023 
% Unified Topological Inference for Brain Networks in Temporal Lobe Epilepsy Using the Wasserstein 
% Distance, arXiv:2302.06673.
%
% [2] Chung, M.K., Huang, S.-G., Carroll, I.C., Calhoun, V.D., Goldsmith, H.H. 
% 2023 Topological  State-Space Estimation of Functional Human Brain Networks. arXiv:2201:00087
% 
%% The Wasserstein distance part of codes are based on
% [3] Songdechakraiwut, T. Chung, M.K. 2023 Topological learning 
% for brain networks, Annals of Applied Statistics 17:403-433, arXiv: 2012.00675
%
%
% The code is downloaded from
% https://github.com/laplcebeltrami/dynamicTDA
%
% (C) 2021- Moo K. Chung
% Univeristy of Wisconsin-Madison
%
% Update history
% 2021 December 22 created
% 2022 Otober 24 updated
% 2023 March 26 WS_cluster.m added


%% ----------------------------
%% SIMULATION 1 DETECTING FALSE POSITIVES
%% Random network simulation of no topolgoical difference

nGroup1 = 5;
nGroup2 = 5;
nGroup3 = 5;
nGroup4 = 5;
g1 = cell(nGroup1, 1);
g2 = cell(nGroup2, 1);
g3 = cell(nGroup3, 1);
g4 = cell(nGroup4, 1);

sigma=0.3 %amount of noise
%--------------
%two circles horizontally

figure; subplot(2,2,1)

%coord = graph_circle([2 0],1, 60, 0)
%plot(coord(:,1),coord(:,2), 'Color',[.7 .7 .7], 'LineWidth',1)';

%coord = graph_circle([-1 0],1.5, 60, 0)
%hold on; plot(coord(:,1),coord(:,2),'Color',[.7 .7 .7], 'LineWidth',1)';

for i=1:nGroup1
    circle1 = graph_circle([2 0],1, 60, sigma);
    circle2 = graph_circle([-1 0],1.5, 60, sigma);
    obs =[circle1; circle2];
    hold on; plot(obs(:,1), obs(:,2),'.k');
    coord=[obs(:,1)  obs(:,2)];
    C = pdist(coord);
    C=squareform(C);
    %figure; imagesc(C); colorbar
    g1{i}=C;
end

axis square
figure_bigger(16)
xlim([-3 3]); ylim([-3 3])
title('Group 1')


%--------------
%two circles translated to right

subplot(2,2,2)

%coord = graph_circle([-2 0],1, 60, 0)
%plot(coord(:,1),coord(:,2), 'Color',[.7 .7 .7], 'LineWidth',1)';
%coord = graph_circle([1 0],1.5, 60, 0)
%hold on; plot(coord(:,1),coord(:,2),'Color',[.7 .7 .7], 'LineWidth',1)';

for i=1:nGroup2
    circle1 = graph_circle([-2 0],1, 60, sigma);
    circle2 = graph_circle([1 0],1.5, 60, sigma);
    obs =[circle1; circle2];
    hold on; plot(obs(:,1), obs(:,2),'.k');
    coord=[obs(:,1)  obs(:,2)];
    C = pdist(coord);
    C=squareform(C);
    %figure; imagesc(C); colorbar
    g2{i}=C;
end

axis square
figure_bigger(16)
xlim([-3 3]); ylim([-3 3])
title('Group 2')

%--------------
%two circles vertically

subplot(2,2,3)

%coord = graph_circle([0 2],1, 60, 0)
%plot(coord(:,1),coord(:,2), 'Color',[.7 .7 .7], 'LineWidth',1)';
%coord = graph_circle([0 -1],1.5, 60, 0)
%hold on; plot(coord(:,1),coord(:,2),'Color',[.7 .7 .7], 'LineWidth',1)';

for i=1:nGroup3
    circle1 = graph_circle([0 2],1, 60, sigma);
    circle2 = graph_circle([0 -1],1.5, 60, sigma);
    obs =[circle1; circle2];
    hold on; plot(obs(:,1), obs(:,2),'.k');
    coord=[obs(:,1)  obs(:,2)];
    C = pdist(coord);
    C=squareform(C);
    %figure; imagesc(C); colorbar
    g3{i}=C;
end

axis square
figure_bigger(16)
xlim([-3 3]); ylim([-3 3])
title('Group 3')
%--------------
%two circles vertically translated

subplot(2,2,4)

%coord = graph_circle([0 1],1.5, 60, 0)
%plot(coord(:,1),coord(:,2), 'Color',[.7 .7 .7], 'LineWidth',1)';
%coord = graph_circle([0 -2],1, 60, 0)
%hold on; plot(coord(:,1),coord(:,2),'Color',[.7 .7 .7], 'LineWidth',1)';

for i=1:nGroup4
    circle1 = graph_circle([0 1],1.5, 60, sigma);
    circle2 = graph_circle([0 -2],1, 60, sigma);
    obs =[circle1; circle2];
    hold on; plot(obs(:,1), obs(:,2),'.k');
    coord=[obs(:,1)  obs(:,2)];
    C = pdist(coord);
    C=squareform(C);
    g4{i}=C;
end
axis square
figure_bigger(16)
xlim([-3 3]); ylim([-3 3])
title('Group 4')

%% ---------------------------
%% SIMULATION 2 DETECTING FALSE NEGATiVEs
%% Random network simulation of topolgoical difference
%% Random network simulation of no topolgoical difference

%two circles horizontally

figure; subplot(2,2,1)

for i=1:nGroup1
    circle1 = graph_circle([2 0],1, 60, sigma);
    circle2 = graph_circle([-1 0],1.5, 60, sigma);
    obs =[circle1; circle2];
    hold on; plot(obs(:,1), obs(:,2),'.k');
    coord=[obs(:,1)  obs(:,2)];
    C = pdist(coord);
    C=squareform(C);
    %figure; imagesc(C); colorbar
    g1{i}=C;
end

axis square
figure_bigger(16)
xlim([-3 3]); ylim([-3 3])
title('Group 1')


%--------------
%two circles translated to right

subplot(2,2,2)

for i=1:nGroup2
    circle1 = graph_circle([1 0],1.5, 60, sigma);
    circle2 = graph_circle([-1 0],1.5, 60, sigma);
    obs =[circle1; circle2];
    hold on; plot(obs(:,1), obs(:,2),'.k');
    coord=[obs(:,1)  obs(:,2)];
    C = pdist(coord);
    C=squareform(C);
    %figure; imagesc(C); colorbar
    g2{i}=C;
end

axis square
figure_bigger(16)
xlim([-3 3]); ylim([-3 3])
title('Group 2')

%--------------
%two circles vertically

subplot(2,2,3);cla()

for i=1:nGroup3
    circle1 = graph_circle([-1 0],1.5, 60, sigma);
    circle2 = graph_circle([-1 0],1.5, 60, sigma);
    obs =[circle1; circle2];
    hold on; plot(obs(:,1), obs(:,2),'.k');
    coord=[obs(:,1)  obs(:,2)];
    C = pdist(coord);
    C=squareform(C);
    %figure; imagesc(C); colorbar
    g3{i}=C;
end

axis square
figure_bigger(16)
xlim([-3 3]); ylim([-3 3])
title('Group 3')
%--------------
%two circles vertically translated

subplot(2,2,4);cla()

for i=1:nGroup4
     circle1 = graph_circle([0.5 0],1.5, 60, sigma);
    circle2 = graph_circle([-0.5 0],1.5, 60, sigma);
    obs =[circle1; circle2];
    hold on; plot(obs(:,1), obs(:,2),'.k');
    coord=[obs(:,1)  obs(:,2)];
    C = pdist(coord);
    C=squareform(C);
    g4{i}=C;
end
axis square
figure_bigger(16)
xlim([-3 3]); ylim([-3 3])
title('Group 4')


%% ----------------------
%% Pairwise distance matrix 
% The Wasserstein distance is not showing clustering pattern 
% since they are all topologically equivalent while L2-norm
% is showing clustering pattern. Thus k-means clustering that 
% uses the L2-norm is expected not to perform well and reports 
% a lot of false positives. 

figure; 
subplot(2,1,1)
lossMtx = WS_L2distace2matrix(g)
imagesc(lossMtx); colorbar
axis square
figure_bigger(16)
colormap('hot')
title('L2-norm')

subplot(2,1,2)
g=[g1;g2; g3;g4];
lossMtx = WS_distace2matrix(g)
imagesc(lossMtx); colorbar
axis square
figure_bigger(16)
colormap('hot')
title('Wasserstein')

figure_bg('w')
%print_pdf('dist2')

%% -----------------------------------
%% Topological clustering using Wasserstein distance
% All the theoretical issues are explained in
%
% [1] Moo K. Chung, Camille Garcia Ramos, Felipe Branco De Paiva, Jedidiah Mathis, Vivek Prabharakaren, 
% Veena A. Nair, Elizabeth Meyerand, Bruce P. Hermann, Jeffery R. Binder, Aaron F. Struck, 2023 
% Unified Topological Inference for Brain Networks in Temporal Lobe Epilepsy Using the Wasserstein Distance, 
% arXiv:2302.06673
% 
% [2] Chung, M.K., Huang, S.-G., Carroll, I.C., Calhoun, V.D., Goldsmith, H.H. 2023 
% Topological  State-Space Estimation of Functional Human Brain Networks. arXiv:2201:00087
G=[g1 g2 g3 g4];
acc_WS  = WS_cluster(G)

%Comparision against baseline k-means clustering which is directly
%applied to correlations on edges.
acc_K = kmeans_cluster(G)

%Hierarchical clustering
acc_H = hierarchical_cluster(G)





