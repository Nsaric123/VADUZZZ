n = 10000;
%definiranje dijagonala
d = [1:n]; 
d1 = [];
d2 = [];
d2(1)=-1;
d1(n-1) = -1/(n-1);
for j = 2:n-1
    d1(j-1) = -1/(j-1);
    d2(j) = -1/j;
end
%kontruiranje matric sustava i vektor b
A = sparse(diag(4*d)+diag(d1,-1)+diag(d2,1));
b = [1:n]';
%rjesavamo sustav Ax=b pomocu metode konjugiranih gradijenata
tol = 10^(-10); %tocnost
maxit = 1000; %maksimalni broj iteracija
M = diag(diag(A)); %dijagonalni prekondicionar
x1 = pcg(A,b,tol,maxit,M);

%rjesenje sustava pomocu LU dekompozicije
[L,U] = lu(A);
x2 = U \ (L \ b);
