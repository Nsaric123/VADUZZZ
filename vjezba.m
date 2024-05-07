#zad 1

x = [1,-1,2,5,1,3,-2,1,-1,2]';

n = size(x,1);

H = eye(n);
I1 = eye(6);
u1 = x(1:6);
v1 = u1 + sign(u1(1))*norm(u1)*I1(:,1);
Hk1 = eye(6) - 2*v1*v1'/(norm(v1)*norm(v1));

H(1:6,1:6) = Hk1;
H*x;

I2 = eye(3);
u2 = x(8:10);
v2 = u2 + sign(u2(1))*norm(u2)*I2(:,1);
Hk2 = eye(3) - 2*v2*v2'/(norm(v2)*norm(v2));

H(8:10,8:10) = Hk2;
H*x;

#zad2
minus = -1*ones(15,15);
plus = ones(15,15);
A = tril(minus) + triu(plus) + 20*eye(15,15) + diag(11*ones(14,1),-1) + diag(9*ones(14,1),1);
boolean = 1;
for ii = 1:15
  if det(A(1:ii,1:ii)) == 0
    boolean = 0;
  endif
endfor

boolean;
## svim glavnim podmatricama od A je det razlicita od 0

b = [29 -20 20 -20 20 -20 20 -20 20 -20 20 -20 20 -20 11]';

[L,U] = lu(A);

function [x] = povsub(A,b)
  n = size(A,2);
  x = zeros(n,1);
  suma = 0;
  for j = n:-1:1
    for kk = 1:n
      suma = suma + (A(j,kk)*x(kk));
    endfor
    x(j) = (b(j) - suma)/A(j,j);
  endfor
  return
end


#x = povsub(U,forward(L,b))
#U\(L\b)

function [x] = forward(A,b)
  n = size(A,2);
  x = zeros(n,1);
  for ii = 1:n
    suma = 0;
    for kk = 1:n
      suma = suma + (A(ii,kk)*x(kk));
    endfor
    x(ii) = (b(ii) - suma)/A(ii,ii);
  endfor
end

#x = forward(L,b)
#L\b

#zad 3
proba = [20:-1:11];
A = ones(10,10) + diag(proba);
x0 = zeros(10,1);
b = [2:2:20]';

#jacob
M = diag(diag(A));
N = A-M;
C = -M\N;
nC = norm(C,'inf');
eigs = eig(A);
max(abs(eigs));
tol = 0.0001;

#sve sv vrijednosti su pozitivne pa se sustav može riješiti jacobijevom metodom i metodom najbrzeg silaska
M_inv = zeros(10,10);
for ii = 1:10
  M_inv(ii,ii) = 1/M(ii,ii);
endfor
x1 = x0;

iters = 0;
while norm(A*x1-b,'inf') > tol #A\b - x1
  x0 = x1;
  x1 = M_inv * (b - N*x0);
  iters = iters + 1;
endwhile
iters
norm(A*x1-b,'inf')

#Metoda najbržeg silaska
x02 = zeros(10,1);
r0 = b - A*x02;
iters = 0;
x12 = x02;
while norm(A*x12-b,'inf') > tol
  z = A * r0;
  alpha0 = (r0'*r0)/(r0'*z);
  x12 = x02 + alpha0*r0;
  r1 = r0 - alpha0*z;
  r0 = r1;
  x02 = x12;
  iters = iters + 1;
endwhile

iters
norm(A*x1-b,'inf')








































