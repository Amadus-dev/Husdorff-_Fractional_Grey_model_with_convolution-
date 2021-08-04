function [BulidData,ForecastData,ForecastRelateData]=Dataslices(X,days)
%%%%X为输入的原数据矩阵，days为需要预测的天数
BulidData=[X(days+1:days+256,1) X(1:256,2:end)];
ForecastRelateData=X(257:256+days,2:end);
ForecastData=X(267:266+days,1);
%%%%X为输入的原数据矩阵，days为需要预测的天数，且为无滞后的数据
%BulidData=[X(1:256,1) X(1:256,2:end)];
%ForecastRelateData=X(257:256+days,2:end);
end