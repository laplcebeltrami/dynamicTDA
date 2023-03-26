## Wasserstein distance between brain networks 

The package computes the Wassersteind distance between the groups of networks, perform topological inference and topological clustering.  


Simply run script [SCRIPT.m](https://github.com/laplcebeltrami/dynamicTDA/blob/main/SCRIPT.m). The new code [WS_pdist2.m](https://github.com/laplcebeltrami/dynamicTDA/blob/main/WS_pdist2.m) replaces pervious [WS_distancemat.m](https://pages.stat.wisc.edu/~mchung/dynamicTDA/matlab/WS_distancemat.m) that is extremly slow due to the use fo double-loops. The new code should be thousand times faster for large-scale network comparisions. Run SCRIPT.m


The topological inference procedure is explained in

[1] Moo K. Chung, Camille Garcia Ramos, Felipe Branco De Paiva, Jedidiah Mathis, Vivek Prabharakaren, Veena A. Nair, Elizabeth Meyerand, Bruce P. Hermann, Jeffery R. Binder, Aaron F. Struck, 2023 Unified Topological Inference for Brain Networks in Temporal Lobe Epilepsy Using the Wasserstein Distance, [arXiv:2302.06673](https://arxiv.org/abs/2302.06673).


The Wassersteind distance between the groups of networks in explained in 

[2] Songdechakraiwut, T. Chung, M.K. 2022 Topological learning for brain networks, Annals of Applied Statistics arXiv: 2012.00675

[3] Songdechakraiwut, T., Shen, L., Chung, M.K. 2021 Topological learning and its application to multimodal brain network integration, Medical Image Computing and Computer Assisted Intervention (MICCAI), LNCS 12902:166-176



(C) 2022- Moo K. Chung
University of Wisconsin-Madison
mkchung@wisc.edu
