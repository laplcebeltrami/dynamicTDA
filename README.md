## What is Dynamic Topological Data Analysis (Dynamic-TDA)?

Dynamic topological data analysis (dynamic-TDA)  focuses on analyzing dynamically changing time series data using persistent homology. The method can be applicable to wide variety of dynamically changing data including resting-state functional magnetic resonance images (rs-fMRI) and dynamically changing correlation matrices obtained from EEG. The basic terminology and concept are introduced in [1]. 



## Wasserstein distance between brain networks 

The package computes the Wasserstein distance between the collection of networks, perform topological clustering, topological inference and topological embedding  



### Topological clustering

For topological clustering using the Wasserstein distance, run [SIMULATION_cluster.m](https://github.com/laplcebeltrami/dynamicTDA/blob/main/SIMULATION_cluster.m). It is based on the core function 
[WS_cluster.m](https://github.com/laplcebeltrami/dynamicTDA/blob/main/WS_cluster.m)


The method is explained in 

[1] Chung, M.K., Huang, S.-G., Carroll, I.C., Calhoun, V.D., Goldsmith, H.H. 2023 Topological  State-Space Estimation of Functional Human Brain Networks, [arXiv:2201:00087](https://arxiv.org/abs/2201.00087).


### Topological inference
For topological inference, run  [SCRIPT.m](https://github.com/laplcebeltrami/dynamicTDA/blob/main/SCRIPT.m). The new code [WS_pdist2.m](https://github.com/laplcebeltrami/dynamicTDA/blob/main/WS_pdist2.m) replaces pervious [WS_distancemat.m](https://pages.stat.wisc.edu/~mchung/dynamicTDA/matlab/WS_distancemat.m) that is extremly slow due to the use fo double-loops. The new code should be thousand times faster for large-scale network comparisions. The method is explained in

[2] Moo K. Chung, Camille Garcia Ramos, Felipe Branco De Paiva, Jedidiah Mathis, Vivek Prabharakaren, Veena A. Nair, Elizabeth Meyerand, Bruce P. Hermann, Jeffery R. Binder, Aaron F. Struck, 2023 Unified Topological Inference for Brain Networks in Temporal Lobe Epilepsy Using the Wasserstein Distance, [arXiv:2302.06673](https://arxiv.org/abs/2302.06673).



### References:

The Wassersteind distance for graphs is explained in 

[3] Songdechakraiwut, T. Chung, M.K. 2022 Topological learning for brain networks, Annals of Applied Statistics arXiv: 2012.00675

[4] Songdechakraiwut, T., Shen, L., Chung, M.K. 2021 Topological learning and its application to multimodal brain network integration, Medical Image Computing and Computer Assisted Intervention (MICCAI), LNCS 12902:166-176








(C) 2022- Moo K. Chung
University of Wisconsin-Madison
mkchung@wisc.edu
