function Z=NewBackgroundValue(Y)
X=1:1:length(Y);
x=linspace(1,length(Y),length(Y)+(length(Y)-1)*3); %计算插值的数量
M=1;
[y,R,A,C,L] = Newton_Interpolation(X,Y,x,M);
Z=zeros(length(Y)-1,1);
for i=1:length(Y)-1
    Z(i)=1/2*(y(i)+y(i+1));
end
end