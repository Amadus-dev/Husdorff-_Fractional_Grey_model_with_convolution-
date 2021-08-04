%newton.m
%求牛顿插值多项式、差商、插值及其误差估计的MATLAB主程序
%输入的量:X是n+1个节点(x_i,y_i)(i = 1,2, ... , n+1)横坐标向量，Y是纵坐标向量，
%x是以向量形式输入的m个插值点，M在[a,b]上满足｜f~(n+1)(x)｜≤M
%注：f~(n+1)(x)表示f(x)的n+1阶导数
%输出的量：向量y是向量x处的插值，误差限R，n次牛顿插值多项式L及其系数向量C，
%差商的矩阵A
function[y,R,A,C,L] = Newton_Interpolation(X,Y,x,M)
n = length(X);
m = length(x);
for t = 1 : m
    z = x(t);
    A = zeros(n,n);
    A(:,1) = Y';
    s = 0.0; p = 1.0; q1 = 1.0; c1 = 1.0;
        for j = 2 : n
            for i = j : n
                A(i,j) = (A(i,j-1) - A(i-1,j-1))/(X(i)-X(i-j+1));
            end
            q1 = abs(q1*(z-X(j-1))); % 余项计算中的差值连乘项
            c1 = c1 * j; % 余项计算中的分母，阶乘
        end
        C = A(n, n); q1 = abs(q1*(z-X(n)));
        for k = (n-1):-1:1
            C = conv(C, poly(X(k))); 
            % poly函数把根转换为求得此根的多项式，X（k）是一个数，所以转换为一次多项式，得到其系数向量
            % conv函数的输入是多项式的系数向量时，相当于直接相乘
            d = length(C);
            C(d) = C(d) + A(k,k);%在最后一维，也就是常数项加上新的差商
        end
        y(t) = polyval(C,z); % 插值结果
        R(t) = M * q1 / c1; % 用M代替f~(n+1)(x)，即f(x)的n+1阶导数，这样求得的余项比真实值略大
end
L = vpa(poly2sym(C),3);% vpa让输出结果系数为小数而非分数,3表示用3位小数
