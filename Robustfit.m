rawX=flipud(LoadData())
X=rawX(:, 2:end)
y=rawX(:,1)
[b, stats]=robustfit(X, y)