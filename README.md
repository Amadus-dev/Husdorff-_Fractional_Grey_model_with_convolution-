# Hausdorff fractional grey model with convolution

A mathematical model for forecasting time series。

## 1, Change the dataset

You can change the sequence you want to predict in the "LoadData.m" file.

## 2 , Select parameters 

Run the "PLOTGRAPH.m" file.

## 3、Forecasting

``` matlab
>>> [RestoreSeries,Residual,DataX,ForecastData,MAE, r_X]=Main(r, K)
```

The r and K are respectively the optimal parameters selected in the second step. You can also change the forecast days in the "Main.m" file.

## 4、Reference

```
@article{20211710244133 ,
language = {English},
copyright = {Compilation and indexing terms, Copyright 2021 Elsevier Inc.},
copyright = {Compendex},
title = {Stock price forecasting based on Hausdorff fractional grey model with convolution and neural network},
journal = {Mathematical Biosciences and Engineering},
author = {Dong, Wenhua and Zhao, Chunna},
volume = {18},
number = {4},
year = {2021},
pages = {3323 - 3347},
issn = {15471063},
URL = {http://dx.doi.org/10.3934/mbe.2021166},
} 
```





