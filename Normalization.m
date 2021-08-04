function M=Normalization(X)
[n,m]=size(X);
M=zeros(n,m);
for i=1:m
    for j=1:n
        M(j,i)=(X(j,i)-min(X(:,i)))/(max(X(:,i))-min(X(:,i)));
    end
end
end