function [data_PCA, COEFF, sum_explained]=PCA_DEMO(data,k)
% k:前k个主成分
data=zscore(data);  %归一化数据
[COEFF,SCORE,latent,tsquared,explained,mu]=pca(data);
latent1=100*latent/sum(latent);%将latent特征值总和统一为100，便于观察贡献率
data= bsxfun(@minus,data,mean(data,1));
data_PCA=data*COEFF(:,1:k);

