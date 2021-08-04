X=0.1:0.01:0.45;
Y=45:5:100;
Z = zeros(12,35);
r=1;
for i=Y
    c=1;
    for j=X
        [~,~,~,MAE]=Main(j,i)
        Z(r,c)=MAE;
        c=c+1;
    end 
    r=r+1;
end
[X,Y]=meshgrid(X,Y);
contourf(X,Y,Z)
colorbar
xlabel('r')
ylabel('K')
zlabel('MAE')
