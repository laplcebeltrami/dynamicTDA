function pval = online_pvalues(rStats, observed)
%function pval = online_pvalues(rStats, observed)
%   
% Compute p-value sequentially. pval(end) will be give the most accuarate
% p-value estimate. The method is presented in
%
% [1] Chung, M.K., Xie, L., Huang, S.-G., Wang, Y., Yan, J., Shen, L. 2019. 
% Rapid Acceleration of the permutation test via transpositions, International 
% Workshop on Connectomics in NeuroImaging, Lecture Notes in Computer Science 11848:42-53. 
% A different version arXiv:1812.06696
%
% [2] Songdechakraiwut, T. Chung, M.K. 2020 Topological learning for brain networks, arXiv: 2012.00675.
%
%
%
% %If you are using any part of the code, please reference the above paper.
%
% (C) 2020 Tananun Songdechakraiwut, Moo K. Chung
%          University of Wisconsin-Madison
%
%  Contact tananun@cs.wisc.edu or mkchung@wisc.edu
%  for support/permission with the codes 
%
% Update history
%     November 11, 2020 created - Tananun Songdechakraiwut
%     December 10, 2020 edited Moo Chung



n = length(rStats);
pval = zeros(1, n);

pval(1) = rStats(1) >= observed;
for i = 2:n
    pval(i) = (pval(i - 1) * (i - 1) + (rStats(i) >= observed)) / i;
end

end