% The SCRIPT computes the pairwise Wasserstein distance betwen the group of
% networks and performs the topological inference. The method is published in
% 
% [1] Songdechakraiwut, T., Shen, L., Chung, M.K. 2021 Topological learning and 
%its application to multimodal brain network integration, Medical Image 
%Computing and Computer Assisted Intervention (MICCAI), LNCS 12902:166-176 
%
% [2] Songdechakraiwut, T. Chung, M.K. 2023 Topological learning for brain networks, 
% Annals of Applied Statistics 17:403-433, arXiv:2012.00675.
% https://arxiv.org/pdf/2012.00675.pdf
% 
%
% If you are using any part of the code, please reference one of the above paper.
% The function is downloaded from 
%
% https://github.com/laplcebeltrami/dynamicTDA
%
%
% (C) 2022 Moo K. Chung
%     University of Wisconsin-Madison
% mkchung@wisc.edu
%
% history. 2022 November 5 created
%          2023 Febuary 9 added transposition method

%% Random correlation matrix simulations
% i-th group
nGroup_i=20; %20 subjects 
signal_i = randcorr(263); %signal

for i=1:nGroup_i
    con_i(:,:,i) = signal_i + 0.1*randcorr(263); %signal plus noise
end

%j-th group 
nGroup_j=30; %30 subject 
signal_j = randcorr(263);
for j=1:nGroup_j % 300 subjects
    con_j(:,:,j) = signal_j + 0.1*randcorr(263);
end


%% Pairwise topological distances. It includes 3 topological distances
tic
lossMtx = WS_pdist2(con_i,con_j);
toc

figure; subplot(1,3,1); imagesc(lossMtx.D0); colorbar; title('Wasserstein distance: 0D')
subplot(1,3,2); imagesc(lossMtx.D1); colorbar; title('Wasserstein distance: 1D')
subplot(1,3,3); imagesc(lossMtx.D01); colorbar;  title('Wasserstein distance: 0D and 1D combined')

%2.800029 seconds for 20 vs. 30
%3.224558 seconds for 100 vs. 200

%% p-value computation using the raio statistic (between-distance/within-distance)
%Here we show example of using the combined distance. For different
%distances,use lossMtx.D0 or lossMtx.D1

observed = WS_ratio(lossMtx.D01, nGroup_i, nGroup_j) 
nTrans = 500000; % Total number of transpositions
permNo = 1000; %Total number of intermixed permutations. This is needed to introduce randomness.

tic
[transStat, ~] = WS_transpositions(lossMtx.D01, nGroup_i, nGroup_j, nTrans, permNo); 
transPval = online_pvalues(transStat, observed);
pval = transPval(end)
toc
%Elapsed time is 0.420568 seconds.

%% histrogram. red line is observed statistic
figure; %hisgrom with 25 bins
plot_distribution(transStat, 25, observed)
