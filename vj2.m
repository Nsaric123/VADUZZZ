#zadatak 1

n = 20;

b = [1:n]';

U = zeros(n);
for i = 1:n
  for j = 1:n
    if i <= j
      U(i,j) = 1/(i+j);
    endif
  endfor
endfor

x = povsup(U,b);

#zadatak 3 a
# vp- b potez, Hk - H kapa, H(:,1) - prvi stupac
x = [2,-1,1,4,1,-5,1]';
n = size(x,1);
H = eye(n);

I6 = eye(6);

u = x(2:7);
vp = u + sign(u(1))*norm(u)*I6(:,1);

Hk = eye(6)-2*vp*vp'/(norm(vp)*norm(vp));

H(2:n,2:n) = Hk; # nalijepili smo Hk na H od drugog retka i drugog stupca

H*x;

#zadatak 3 b

H1 = eye(n);

I3 = eye(3);

u1 = x(1:3);
vp1 = u1 + sign(u1(1))*norm(u1)*I3(:,1);
Hk1 = eye(3) - 2*vp1*vp1'/(norm(vp1)*norm(vp1));

H1(1:3,1:3) = Hk1;

H1*x;

I2 = eye(2);
u2 = x(5:6);
vp2 = u2 + sign(u2(1))*norm(u2)*I2(:,1);
Hk2 = eye(2) - 2*vp2*vp2'/(norm(vp2)*norm(vp2));

H1(5:6,5:6) = Hk2;

H1*x;

#zad 1 - jacobijeva metoda
#matrica je SDD, pa metoda konvergira
#nC<1 pa metoda konvergira

A = [10 1 0 1
     1 10 1 0
     0 1 10 1
     1 0 1 10];

b= [-8,0,12,20]';


x0 = zeros(4,1);
tol = 0.001;

M = diag(diag(A)); #moze i eye(4)*diag(A)
N = A-M;

C = -M\N;
nC = norm(C,'inf'); #norma beskonačno

e = eig(C); #svojstvene vrijednosti
max(abs(e)); # spektralni radijus, manje od 1 pa metoda konvergira

x1 = M\(b-N*x0);
nx1 = norm(x0-x1,'inf');

k = ceil(log(((1-nC)*tol)/(nx1))/log(nC)); #strop

for ii=2:k
  x0 = x1;
  x1 = M\(b-N*x0);
end
x1;
norm(A*x1-b,'inf'); #rezidual

#zad 2
# želimo napraviti A da bude strogo dijagonalno dominantn
# P1 = I13, P2 = I23

A = [5,8,1; 1,2,10; 10,1,0];
b = [1,1,1]';
x0 = [0,0,0]';
tol = 0.001;

P = [0,0,1; 1,0,0; 0,1,0];
A = P*A; # matrica je sada strogo dijagonalno
b = P*b;

M = diag(diag(A)); #moze i eye(4)*diag(A)
N = A-M;

C = -M\N;
nC = norm(C,'inf'); #norma beskonačno

e = eig(C); #svojstvene vrijednosti
max(abs(e)); # spektralni radijus, manje od 1 pa metoda konvergira

x1 = M\(b-N*x0);
nx1 = norm(x0-x1,'inf');

k = ceil(log(((1-nC)*tol)/(nx1))/log(nC)); #strop

for ii=2:k
  x0 = x1;
  x1 = M\(b-N*x0);
  if norm(A\b-x1,'inf') < tol # uvjet kada je norma manja od tolerancije
    break
  endif
end
x1;
norm(A*x1-b,'inf'); #norma reziduala

#inverz se računa i preko for petlje ako se ne smije koristiti \

#Zad 4
A = -2*ones(10)+22*eye(10);

b = [1:10]';

x0 = ones(10,1);
tol = 0.001;

M = tril(A) # gornji trokut
N = A-M;

C = -M\N;
nC = norm(C,'inf'); #norma beskonačno

e = eig(C); #svojstvene vrijednosti
max(abs(e)); # spektralni radijus, manje od 1 pa metoda konvergira

#x1 = M\(b-N*x0);
#nx1 = norm(x0-x1,'inf');

#k = ceil(log(((1-nC)*tol)/(nx1))/log(nC)); #strop

iter=0;
while norm(A\b-x0,'inf')>=tol
#  x0 = x1;
  iter = iter + 1;
  x1 = M\(b-N*x0);
  x0 = x1; #zato što x1 nije bio izračunat
##  if norm(A\b-x1,'inf') < tol # uvjet kada je norma manja od tolerancije
##    break
##  endif
end
x0;
norm(A*x1-b,'inf'); #norma reziduala
iter;
















