A = 5

% ZAD 1


function [x] = POVSUB(U,b)
  n = size(U, 1);
  x = zeros(n, 1);
  summ = 0;
  for jj = n:-1:1
    for kk = jj+1: n
      summ = summ + U(jj, kk) * x(kk);
    endfor
    x(jj) = 1 / (U(jj, jj)) * (b(jj) - summ);
    summ = 0;
  endfor
  return
end

#U = [1,2,3; 1,2,3]
b = 1:20;
U = zeros(20);
for ii = 1: size(U, 1)
  for jj = 1: size(U, 2)
    if ii <= jj
      U(ii, jj) = 1 / (ii + jj);
    endif
  endfor
endfor


x = POVSUB(U, b);
%x_rj = U\b;

%norm(x - x_rj)

% zad 3 a

x = [2, -1, 1, 4, 1, -5, 1]';
H = eye(7);
u = x(2:7);
vp = u + sign(u(1)) * norm(u) * eye(6)(:, 1);
Hk = eye(6)-2*vp*vp'/(norm(vp)*norm(vp));
H(2:7,2:7) = Hk
H*x
% zad 3 b

H = eye(7)
u1 = x(1:3);
u2 = x(5:6);
vp1 = u1 + sign(u1(1)) * norm(u1) * eye(3)(:, 1);
vp2 = u2 + sign(u2(1)) * norm(u2) * eye(2)(:, 1);
Hk1 = eye(3)-2*vp1*vp1'/(norm(vp1)*norm(vp1));
Hk2 = eye(2)-2*vp2*vp2'/(norm(vp2)*norm(vp2));
H(1:3, 1:3) = Hk1;
H(5:6, 5:6) = Hk2
H*x


% zad 1 iterativne

function bool = JacobianConv(C)
  bool = True
  sum1 = 0
  sum2 = 0
  for ii = 1: size(C, 1)
    for jj = 1: size(C, 2)
       sum1 = sum1 + abs(C(ii, jj))
       sum2 = sum2 + abs(C(jj, ii))
    endfor
    if !(abs(C(ii, ii)) > sum1 | abs(C(ii, ii)) > sum2)
      bool = False
    endif
  endfor
  return
end


A = [10 1 0 1; 1 10 1 0; 0 1 10 1; 1 0 1 10];
b = [-8, 0, 12, 20];
x0 = zeros(4, 1);
tol = 0.001;


M = diag(diag(A));
N = A - M;


C = -M\N;
nC = norm(C, 'inf');

e = eig(C);
max(abs(e));



x1 = M\(b-N*x0);
nx1 = norm(x0-x1, 'inf');
k = ceil(log(((1-nC)*tol)/(nx1))/(log(nC)));

for ii = 2: k
  x0 = x1;
  x1 = M\(b-N*x0);
endfor
x1

% zad 2 iterativne

A = [5 8 1; 1 2 10; 10 1 0];
b = [1, 1, 1]';
x0 = [0, 0, 0]';
tol = 0.001;

P = [0 0 1; 1 0 0; 0 1 0];
A = P*A;
b = P*b;

M = diag(diag(A));
N = A - M;


C = -M\N;
nC = norm(C, 'inf');

e = eig(C);
max(abs(e));



x1 = M\(b-N*x0);
nx1 = norm(x0-x1, 'inf');
k = ceil(log(((1-nC)*tol)/(nx1))/(log(nC)));

for ii = 2: k
  x0 = x1;
  x1 = M\(b-N*x0);
  if norm(A\b-x1,'inf') < tol
    break
  endif
endfor
x1
norm(A*x1-b, 'inf')


% triu A i tril A za gornje odnosno donje trokutaste matrice



