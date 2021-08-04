%%设置需要预测的天数
days=5;
%%加载数据
rawX=flipud(LoadData());
%%归一化数据并用LLE算法降维
X=rawX(:,2:end);
X=[rawX(:,1) Normalization(PCA_DEMO(X, 3))];
[DataX,DataNextTimeX]=Dataslices(X,days);
[~,~,MAE]=NewMain(0.036,DataX,DataNextTimeX)

% X=0.001:0.001:1.0;
% Z = zeros(1000);
% r=1;
% for i=X
%         [~,~,MAE]=NewMain(i,DataX,DataNextTimeX)
%         Z(r)=MAE;
%         r = r + 1;
% end
% plot(X,Z,'k-')
% xlabel('r')
% ylabel('MAE')

