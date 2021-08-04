function [RestoreSeries,Residual,MAE, r_X]= FGMC(X,nextTimeX, r_tem)
%%%%X为一个n*m的矩阵。其中，n为一共有多少条数据，m表示为一天数据有多少维
%%%%nextTimeX为下一刻时间的相关因素的输入，为一侧n*（m-1）的矩阵
%%%%最终输出一个预测序列
[n,m]=size(X);  %获得X矩阵的size
[nt,mt]=size(nextTimeX);%获得nextTimeX的size
r_AGO=zeros(n,n); %初始化r阶AGO矩阵
%%获得r_阶AGO矩阵
r=r_tem;%阶数

x=2:365;
syms k;
M=[];
Value=[];
for i=x
    M(end+1)=symprod(r+k,k,0,i-2);
end
for j=x
    if isnan(M(j-1)/factorial(j-1))
       Value(end+1)=0;
    else
       Value(end+1)=M(j-1)/factorial(j-1);
    end
end
Value=[1,Value(1:end)];
Value=Value;

j=1;
while j<=n
    d=1;
    for i=1+j-1:1:n
        r_AGO(i,j)=Value(d);
        d=d+1;
    end
    j=j+1;
end

r_nextAGO=zeros(n+nt,n+nt);%初始化r阶nextAGO矩阵
%%获得r_阶AGO矩阵
j=1;
while j<=n+nt
    d=1;
    for i=1+j-1:1:n+nt
        r_nextAGO(i,j)=Value(d);
        d=d+1;
    end
    j=j+1;
end

%得到r阶累加矩阵
r_X=r_AGO*X;
RelateMatrix=[X(:,2:end);nextTimeX ];
relateMatrix=r_nextAGO*RelateMatrix;
newR_X=[r_X(:,1) relateMatrix(1:256,:)];
%%计算背景值
Z=zeros(n-1,m+1);

for q=1:m
    for p=1:1:length(r_X(:,1))-1
         Z(p,q)=0.5*(newR_X(p,q) + newR_X(p+1,q));
    end
end
Z(:,m+1)=1;

%Z=Z(1:end-1,:);
%Z(:,1)=Z(:,1)*(-1);
Y_R=X(2:end,1);

%%%最小二乘估计求出参数的值
Para=inv(Z'*Z)*Z'*Y_R;
%%%计算时间响应函数
PredictSeries=zeros(n+nt,1);
PredictSeries(1,1)=r_X(1,1);
%syms j i;
for t=2:n+nt
    %j=t;
    %i=m;
    %%%时间响应函数
    %PredictSeries(t,1)=X(1,1)*exp(-Para(1)*(t-1))+...
        %symsum(exp(-Para(1)*(t-j+1/2))*1/2*...
        %(symsum(Para(i)*r_X(j,i),2,i)+symsum(Para(i)*r_X(j-1,i),2,i)+2*Para(end:end)),2,j);
        J=0;
    for j=2:t
        I=0;
        for i=1:mt
            I=I+Para(i+1)*relateMatrix(j,i)+Para(i+1)*relateMatrix(j-1,i)+2*Para(end:end);
        end
        J=J+exp(-Para(1)*(t-j+1/2))*1/2*I;
    end
    PredictSeries(t,1)=X(1,1)*exp(-Para(1)*(t-1))+J;
end

%计算其误差值
%PredictSeries
X(:,1);
RestoreSeries=inv(r_nextAGO)*PredictSeries;
%o=n;
%MAPE=1/n*symsum(abs((RestoreSeries(o)-X(o,1))/X(o,1)),1,o);
MAE=0;
Residual=zeros(n,1);
for k=1:n
    MAE=MAE+abs((RestoreSeries(k)-X(k,1)));
    Residual(k,1)=RestoreSeries(k)-X(k,1);
end
MAE=MAE/n;
end

