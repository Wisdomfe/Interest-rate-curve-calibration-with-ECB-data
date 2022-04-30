clear all
load data.mat;

t = dati(1:33,1);
n=9;
x = zeros(n,6);
resnorm = zeros(n,3);
err_rel = zeros(n,6);
x0=zeros(6,3);
x_true=zeros(n,6);
lb=[0,-15,-30,-30,0,0]; ub=[15, 30, 30, 30, 30, 30];
date(1,:)=[datenum('2017-12-14','yyyy-mm-dd'),datenum('2017-12-15','yyyy-mm-dd'), datenum('2017-12-18','yyyy-mm-dd')...
    datenum('2017-12-19','yyyy-mm-dd'), datenum('2017-12-22','yyyy-mm-dd')];


for i = 2:n
y = dati(1:33,i);
x_true(i-1,:)= dati(34:39,i)';

x0 = [2, -2, 23, -28, 2, 2] ;

R=@(x) ynss(t,x,y);
options=optimoptions('lsqnonlin', 'Algorithm','trust-region-reflective', 'MaxFunctionEvaluations', 5000, 'Display', 'iter');

[x(i-1,:), resnorm(i-1), residual(i-1,:)] = lsqnonlin(R, x0, lb, ub, options);

err_rel(i-1,:) = abs(x(i-1,:)-x_true(i-1,:))./abs(x_true(i-1,:))*100;
f(i-1,:)=f_ynss(t,x(i-1,:));
yeld(i-1,:)=y;

end


figure
plot(t, f),hold on
plot(t, yeld,'o','LineWidth',0.5),hold on
title('fit interest rate curve '),...
    legend('14/12/17','15/12/17','18/12/17'...
    ,'19/12/17','22/12/17','12/12/13','13/12/10','13/12/04','Location', 'northwest');


figure
bar(err_rel(1:5,:)),title('% relative error');

figure
bar(err_rel(6,:)),title('relative error (12/12/2013)');
figure
bar(err_rel(7,:)),title('relative error (13/12/2010)');
figure
bar(err_rel(8,:)),title('relative error (13/12/2004)');
figure
plot(t, residual),title('Residual for the different dates (dd/mm/yy) '),...
    legend('14/12/17','15/12/17','18/12/17'...
    ,'19/12/17','22/12/17','12/12/13','13/12/10','13/12/04');
hold on;