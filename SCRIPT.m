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
%          2023 Febuary 9 added transposition method + Betti curves

%% Random correlation matrix simulations
% i-th group
nGroup_i=20; %20 subjects 
signal_i = randcorr(263); %signal 263 is # of nodes
for i=1:nGroup_i
    con_i(:,:,i) = signal_i + randcorr(263); %signal plus noise
end

%j-th group 
nGroup_j=30; %30 subject 
signal_j = randcorr(263);
for j=1:nGroup_j % 300 subjects
    con_j(:,:,j) = signal_j + 2*randcorr(263); %signal plus noise
end

%% Computing and visualizing Betti-0 and Betti-1 curves
thresholds=[-0.5:0.01:1]; %you can change the range
betti0_i=[]; betti1_i=[];
for i=1:nGroup_i
    [beta0, beta1, biggest0, biggest1] = PH_betti(con_i(:,:,i), thresholds);
    betti0_i=[betti0_i; beta0];
    betti1_i=[betti1_i; beta1];
end
mean0_con_i = mean(betti0_i,1); %average Betti-0 curve for i-th group
mean1_con_i = mean(betti1_i,1); %average Betti-1 curve for i-th group

betti0_j=[]; betti1_j=[];
for j=1:nGroup_j
    [beta0, beta1, biggest0, biggest1] = PH_betti(con_j(:,:,j), thresholds);
    betti0_j=[betti0_j; beta0];
    betti1_j=[betti1_j; beta1];
end
mean0_con_j = mean(betti0_j,1); %average Betti-0 curve for j-th group
mean1_con_j = mean(betti1_j,1); %average Betti-1 curve for j-th group

% visulization of all 50 Betti curves. The curves are extremly stable under
% perturbation demonstarting the robustness of the graph filration. Such
% robustnes will not be obtained if you use different filtrations such as
% Rips. 
figure; 
subplot(2,1,1); %Betti-0
for i=1:nGroup_i
     hold on; plot(thresholds,betti0_i(i,:), 'Color', 'y' , 'LineWidth',1,'LineStyle',':')
end
hold on; plot(thresholds,mean0_con_i, 'r', 'LineWidth',2,'LineStyle','-')

for j=1:nGroup_j
     hold on; plot(thresholds,betti0_j(j,:), 'Color', 'g' , 'LineWidth',1,'LineStyle',':')
end
hold on; plot(thresholds,mean0_con_j, 'b', 'LineWidth',2,'LineStyle','-')

set(gca,'FontSize',20);
xlabel('Correlations');
ylabel('\beta_0'); box on;


subplot(2,1,2); %Betti-1
for i=1:nGroup_i
     hold on; plot(thresholds,betti1_i(i,:), 'Color', 'y' , 'LineWidth',1,'LineStyle',':')
end
hold on; plot(thresholds,mean1_con_i, 'r', 'LineWidth',2,'LineStyle','-')

for j=1:nGroup_j
     hold on; plot(thresholds,betti1_j(j,:), 'Color', 'g' , 'LineWidth',1,'LineStyle',':')
end
hold on; plot(thresholds,mean1_con_j, 'b', 'LineWidth',2,'LineStyle','-')

set(gca,'FontSize',20);
xlabel('Correlations');
ylabel('\beta_1'); box on;
%Research problem 1: You will observe Betti-1 curves are extremly robust and stable under 
%some crazy amount of perturabation and noise. This requires further mathematical investigation. 
%I cannot exactly explain why this is so.
%Research problem 2: What random distribution will best decribe the pattern we observed in TLE vs. HC?
%It may be possible to build a parametric statistical model on the distribution of Betti numbers.

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
nTrans = 500000; %Total number of transpositions
permNo = 500; %Total number of intermixed permutations. This is needed to introduce randomness.

tic
[transStat, ~] = WS_transpositions(lossMtx.D01, nGroup_i, nGroup_j, nTrans, permNo); 
transPval = online_pvalues(transStat, observed);
pval = transPval(end)
toc
%Elapsed time is 0.420568 seconds.

%% histrogram. red line is observed statistic
figure; %hisgrom with 25 bins
plot_distribution(transStat, 25, observed)
