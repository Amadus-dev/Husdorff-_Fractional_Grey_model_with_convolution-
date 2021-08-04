function F=fitness(x)
%F=0;
%for i=1:30
    %F=F+x(i)^2+x(i)-6;
%end
syms x;
F=cos(sqrt(x(1)^2+x(2)^2)-1)/((1+(x(1)^2-x(2)^2))^2)+0.5;
end
