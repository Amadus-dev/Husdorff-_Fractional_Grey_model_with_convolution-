A=input('请输入原始特征序列：');
x0=input('请输入相关因素序列：');
M=input('请输入预测步长：');
N=1;
while N<=M
[n,m]=size(x0);
AGO=cumsum(A);
T=1;
x1=zeros(n,m+T);

for k=2:m
    Z1(k)=(AGO(k)+AGO(k-1))*0.5; %Z(i)为xi(1)的紧邻均值生成序列
end
for i=1:n
    for j=1:m
        for k=1:j
            x1(i,j)=x1(i,j)+x0(i,k);%原始数据一次累加,得到xi(1)
        end
    end
end
x11=x1(:,1:m);
X=x1(:,2:m)';%截取矩阵
Yn =A;%Yn为常数项向量
Yn(1)=[]; %从第二个数开始，即x(2),x(3)...
Yn=Yn';
%Yn=A(:,2:m)';
Z=Z1(:,2:m)';
B=[-Z,X];
C=(inv(B'*B))*B'*Yn;%由公式建立GM(1,n)模型
a=C(1);
C1=C';
b=C1(:,2:n+1);
F=[];
F(1)=A(1);
u=zeros(1,m);
for i=1:m
       for j=1:n
        u(i)=u(i)+(b(j)*x11(j,i));
       end
end
for k=2:m
    F(k)=(A(1)-u(k)/a)*exp(-a*(k-1))+u(k)/a;
end
G=[];
G(1)=A(1);
for k=2:m
G(k)=F(k)-F(k-1);%两者做差还原原序列，得到预测数据
end

%对下一刻进行预测
x0_y=input('请输入下一刻相关因素序列：');
U=[];
U(1)=0;
for k=1
for j=1:n
U(k)=U(k)+(b(j)*(x11(j,m)+x0_y(j)));
end
end
F_y=[];
F_y(1)=0;
for k=1
 F_y(k)=(A(1)-U(k)/a)*exp(-a*m)+U(k)/a;
end
 G_y=zeros(1,M);
 
for k=1
 G_y(N)=F_y(k)-F(m);
end
N=N+1;

end

disp('GM(1,n)预测值：');
disp(G_y(N-1));

%绘图
t1=1:m;
t2=1:m;
plot(t1,A,'bo--');
hold on;
plot(t2,G,'r*-'); 
axis([1 m 0 10000]);
title('能见度预测结果');
legend('真实值','预测值'); 
