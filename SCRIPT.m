% The SCRIPT computes the pairwise Wasserstein distance betwen the group of
% networks. The method is published in
% 
% [1] Songdechakraiwut, T., Shen, L., Chung, M.K. 2021 Topological learning and 
%its application to multimodal brain network integration, Medical Image 
%Computing and Computer Assisted Intervention (MICCAI), LNCS 12902:166-176 
%
% [2] Songdechakraiwut, T. Chung, M.K. 2022 Topological learning for brain 
% networks, arXiv: Anals of Applied Statitics, in press 2012.00675. 
% 
%
% If you are using any part of the code, please reference the above paper.
% The function is downloaded from 
%
% https://github.com/laplcebeltrami/dynamicTDA
%
%
% (C) 2022 Moo K. Chung
%     University of Wisconsin-Madison
% mkchung@wisc.edu
%

%% Random correlation matrix simulations
% i-th group
nGroup_i=20;
signal_i = randcorr(263); %signal

for i=1:nGroup_i
    con_i(:,:,i) = signal_i + 0.1*randcorr(263); %signal plus noise
end

%j-th group
nGroup_j=30;
signal_j = randcorr(263);
for j=1:nGroup_j % 300 subjects
    con_j(:,:,j) = signal_j + 0.1*randcorr(263);
end

%% NEW FASTER METHOD
tic
lossMtx = WS_pdist2(con_i,con_j);
figure; imagesc(lossMtx.^2); colorbar
toc

%2.800029 seconds for 20 vs. 30
%3.224558 seconds for 100 vs. 200


%% OLD SLOW METHOD
% The new faster code replaces old slow code WS_distancemat.m 
% in https://pages.stat.wisc.edu/~mchung/dynamicTDA/
% It requres converting matrix into cell-array format

g1=cell(nGroup_i,1);
g2=cell(nGroup_j,1);
for i=1:nGroup_i
    g1{i}=con_i(:,:,i);
end

for j=1:nGroup_j
   g2{j}=con_j(:,:,j);
end

tic
lossMtx = WS_distancemat(g1, g2);
figure; imagesc(lossMtx); colorbar
toc

%20.050543 seconds for 20 vs. 30