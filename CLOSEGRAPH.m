days = 5
X1=flipud(csvread('000573_20200331.csv',1,3));
%X2=flipud(csvread('002770_20200331.csv',1,3));
X3=flipud(csvread('000985_20200331.csv',1,3));
%X4=flipud(csvread('002567_20200331.csv',1,3));
BX1 = X1(days+1:days+256,1);
%BX2 = X2(days+1:days+256,1);
BX3 = X3(days+1:days+256,1);
%BX4 = X4(days+1:days+256,1);
Y = 1:1:256
plot(Y,BX1,'r-');hold on;
%plot(Y,BX2,'m--');hold on;
plot(Y,BX3,'k-');hold on;
%plot(Y,BX4,'k--');hold on;
xlabel('Time step')
ylabel('Price')
legend('SZ000573','SZ000985');