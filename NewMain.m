function [RestoreSeries,Residual,MAE]=NewMain(r,DataX,DataNextTimeX)
%%建立NGM模型
[RestoreSeries,Residual,MAE]= FGMC(DataX,DataNextTimeX,r);
end