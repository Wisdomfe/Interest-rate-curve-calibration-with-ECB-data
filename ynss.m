function res = ynss(t,x,y)
res =x(1)+x(2)*((1-exp(-t./x(5)))./(t./x(5)))+x(3)*((1-exp(-t./x(5)))./(t./x(5))-exp(-t/x(5)))...
    + x(4)*((1-exp(-t./x(6)))./(t./x(6))-exp(-t/x(6)));
res = y-res;

res = res';