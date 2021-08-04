function [RestoreSeries,Residual,DataX,ForecastData,MAE, r_X]=Main(r)
%%设置需要预测的天数
days=5;
%%加载数据
rawX=flipud(LoadData());
%%归一化数据并用LLE算法降维
%X=Normalization(rawX(:,2:end));
%X=[rawX(:,1) Normalization((LLE_ALGORITHM(X(:,2:end)',K,3))')];
%[DataX,DataNextTimeX]=Dataslices(X,days);
X=rawX(:,2:end);
%X=[rawX(:,1) Normalization((LLE_ALGORITHM(X',K,3))')];
X=[rawX(:,1) Normalization(PCA_DEMO(X, 3))];
[DataX,ForecastData,DataNextTimeX]=Dataslices(X,days);
%%建立NGM模型
[RestoreSeries,Residual,MAE,r_X]= FGMC(DataX,DataNextTimeX,r);
end