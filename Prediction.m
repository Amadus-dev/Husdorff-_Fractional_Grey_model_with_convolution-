function DataSeries=Prediction(Para,X)
%%%Para为建模数据所需要的参数值，X为建模的数据
[n,m]=size(X)
PredictSeries=zeros(n,1);
syms j i;
for t=2:n
    j=t;
    i=m;
    %%%时间响应函数
    PredictSeries(t,1)=X(1,1)*exp(-Para(1)*(t-1))+...
        symsum(exp(-Para(1)*(t-j+1/2))*1/2*...
        (symsum(Para(i)*r_X(j,i),2,i)+symsum(Para(i)*r_X(j-1,i),2,i)),2,j);
end

end