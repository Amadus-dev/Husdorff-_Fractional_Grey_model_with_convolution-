function [newRestoreSeries,RestoreSeries,Para,MAPE]= NGM(X,nextTimeX)
%%%%X为一个n*m的矩阵。其中，n为一共有多少条数据，m表示为一天数据有多少维
%%%%nextTimeX为下一刻时间的相关因素的输入，为一侧n*（m-1）的矩阵
%%%%最终输出一个预测序列
[n,m]=size(X);  %获得X矩阵的size
r_AGO=zeros(n,n); %初始化r阶AGO矩阵
%%获得r_阶AGO矩阵
r=0.09;%阶数
j=1;
while j<=n
    d=1;
    for i=1+j-1:1:n
        r_AGO(i,j)=d^r-(d-1)^r;
        d=d+1;
    end
    j=j+1;
end
%得到r阶累加矩阵
r_X=r_AGO*X;
%%计算背景值
Z=zeros(n-1,m+1);
for q=1:1:m
    for p=1:3:length(r_X(:,1))-3
         Z(p:p+3,q)=BackgroundValue(r_X(p:p+3,q));
    end
end
Z(:,m+1)=1;
Z=Z(1:end-1,:);
Y_R=X(2:end,1);
%%%最小二乘估计求出参数的值
Para=inv(Z'*Z)*Z'*Y_R;
%%%计算时间响应函数
PredictSeries=zeros(n,1);
PredictSeries(1,1)=r_X(1,1);
%syms j i;
for t=2:n
    %j=t;
    %i=m;
    %%%时间响应函数
    %PredictSeries(t,1)=X(1,1)*exp(-Para(1)*(t-1))+...
        %symsum(exp(-Para(1)*(t-j+1/2))*1/2*...
        %(symsum(Para(i)*r_X(j,i),2,i)+symsum(Para(i)*r_X(j-1,i),2,i)+2*Para(end:end)),2,j);
        J=0;
    for j=2:t
        I=0;
        for i=2:m
            I=I+Para(i)*r_X(j,i)+Para(i)*r_X(j-1,i)+2*Para(end:end);
        end
        J=J+exp(-Para(1)*(t-j+1/2))*1/2*I;
    end
    PredictSeries(t,1)=X(1,1)*exp(-Para(1)*(t-1))+J;
end

%计算其误差值
RestoreSeries=inv(r_AGO)*PredictSeries;
%o=n;
%MAPE=1/n*symsum(abs((RestoreSeries(o)-X(o,1))/X(o,1)),1,o);
MAPE=0;
for k=1:n
    MAPE=MAPE+abs((RestoreSeries(k)-X(k,1))/X(k,1));
end
MAPE=MAPE*(1/n)


%%%%%%%%%%%%开始样本外预测
[nt,~]=size(nextTimeX);%获得nextTimeX的size
r_nextAGO=zeros(n+nt,n+nt);%初始化r阶nextAGO矩阵
%%获得r_阶AGO矩阵
j=1;
while j<=n+nt
    d=1;
    for i=1+j-1:1:n+nt
        r_nextAGO(i,j)=d^r-(d-1)^r;
        d=d+1;
    end
    j=j+1;
end


newX=[X(:,2:end);nextTimeX];%%与原来的矩阵做拼接
r_newX=r_nextAGO*newX;
nextTimeX
%%%计算预测时间内的时间响应函数
NextSeries=zeros(nt,1);
for t=n+1:n+nt
    %j=t;
    %i=m;
    %%%时间响应函数
    %NextSeries(t,1)=X(1,1)*exp(-Para(1)*(t-1))+...
        %symsum(exp(-Para(1)*(t-j+1/2))*1/2*...
        %(symsum(Para(i)*r_newX(j,i),2,i)+symsum(Para(i)*r_newX(j-1,i),2,i)+2*Para(end:end)),2,j);
        J=0;
    for j=2:t
        I=0;
        for i=1:m-1
            I=I+Para(i)*r_newX(j,i)+Para(i)*r_newX(j-1,i)+2*Para(end:end);
        end
        J=J+exp(-Para(1)*(t-j+1/2))*1/2*I;
    end
    NextSeries(t-n,1)=X(1,1)*exp(-Para(1)*(t-1))+J;
end

%length(PredictSeries)
%length(r_nextAGO(:,1))
newSeries=[PredictSeries;NextSeries];
newRestoreSeries=inv(r_nextAGO)*newSeries;
end

