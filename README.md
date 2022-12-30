## Wasserstein distance between brain networks

The package computes the Wassersteind distance between the groups of networks. The method is introduced in

[1] Songdechakraiwut, T. Chung, M.K. 2022 Topological learning for brain networks, Annals of Applied Statistics arXiv: 2012.00675

[2] Songdechakraiwut, T., Shen, L., Chung, M.K. 2021 Topological learning and its application to multimodal brain network integration, Medical Image Computing and Computer Assisted Intervention (MICCAI), LNCS 12902:166-176

The new code [WS_pdist2.m](https://github.com/laplcebeltrami/dynamicTDA/blob/main/WS_pdist2.m) replaces pervious [WS_distancemat.m](https://pages.stat.wisc.edu/~mchung/dynamicTDA/matlab/WS_distancemat.m) that is extremly slow due to the use fo double-loop. The new codes hould be thousand times faster for large-scale network comparisions. Run SCRIPT.m






(C) 2022 Moo K. Chung
University of Wisconsin-Madison
mkchung@wisc.edu
