x=2:200;
r=0.5;
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

X = zeros(5,5)
[n,m]=size(X);  %获得X矩阵的size
r_AGO=zeros(n,n); %初始化r阶AGO矩阵
%%获得r_阶AGO矩阵
j=1;
while j<=n
    d=1;
    for i=1+j-1:1:n
        r_AGO(i,j)=Value(d);
        d=d+1;
    end
    j=j+1;
end
