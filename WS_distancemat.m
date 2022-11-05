function Mtx = WS_distancemat(g1, g2)
%function Mtx = WS_distancemat(g1, g2)
%
% Compute matrix whose entries are pairwise Wasserstein distance. 
% The method is explained in Simulation study 2:
%
% Generate random modular network introduced in Songdechakraiwut, T. Chung, 
% M.K. 2020 Topological learning for brain networks, arXiv: 2012.00675.
%
%
% INPUT
% name    : algorithm name 'top' will use the topological loss in the paper
% g1,g2   : two groups of networks
% param   : parameters for baseline algorithms. Not used now
%
% OUTPUT
% lossMtx : loss matrix 
%
% Update history
%     November 10, 2020 created - Tananun
 
g = [g1; g2];
d = length(g);
Mtx = zeros(d);

for i = 1:d
    adj1 = g{i};
    for j = i + 1:d
        adj2 = g{j};
        totalTop = WS_distance(adj1, adj2);
        Mtx(i, j) = totalTop;
        Mtx(j, i) = totalTop;
    end
end

