function [f1,f2] = zad3(x)
    f1 = exp(x)-x-1;
    syms k;
    f2 = symsum(x^k/(factorial(k)),k,1,Inf);
end