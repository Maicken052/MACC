function [r, req]=restricciones(x)
req(1)=x(1)*x(2) + x(2)*x(3) - 1;
r(1)=9*x(1)^2 + 4*x(2)^2 + 36*x(3)^2 - 36;

%f=@(x) x(2)*exp(x(1)-x(3))
%fmincon(f,[1;1;0],[],[],[],[],[],[],@restricciones)
