x=2:200;
r=0.5;
rx=2.1;
syms k;
M=[];
Value=[];
for i=x
    M(end+1)=symprod(r+k,k,0,i-2);
end
for j=x
    Value(end+1)=M(j-1)/factorial(j-1);
end
Value=[1,Value(1:end)];
Value=Value;
X1=1:200;
Y1=[];
Y2=[];
for i=X1
    Y1(end+1)=i^r-(i-1)^r;
    Y2(end+1)=(i^rx-(i-1)^rx)^-1;
end

plot(X1,Value,'k-');hold on;
plot(X1,Y1,'k--');hold on;
xlabel('t')
ylabel('Multiplying factor')
legend('φ(·)','ω(·)');
%plot(X1,fliplr(Y2),'b-');hold off;