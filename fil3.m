A = [4, 2, -1; 2 8 4; -1 4 10];
b = [5, 30, 37]';
x0 = zeros(3, 1);

n = size(A, 1);

e = eig(A);

%sve svojstvene vrijednosti su > 0, možemo primijeniti naše metode

%metoda najbržeg silaska

r0 = b - A*x0

for ii = 1:3

  z = A*r0;
  alpha0 = ((r0)'*r0)/(r0'*z);
  x1 = x0 + alpha0*r0;
  r1 = r0 - alpha0*z;
  x0 = x1;
  r0 = r1;

end

norma_mns = norm(r0)

# metoda konjugiranih gradijenta

x0 = zeros(3, 1);
d0 = b-A*x0;
r0 = d0;

for ii = 1:3

  z = A*d0;
  alpha0 = ((r0')*r0)/(d0'*z);
  x1 = x0 + alpha0*d0;
  r1 = r0 - alpha0*z;
  beta = (r1'*r1) / (r0'*r0);
  d1 = r1 + beta*d0;

  x0 = x1;
  r0 = r1;
  d0 = d1;

end

norma_mkg = norm(r0)


% kada ce dostici ... trajlabe trajlabe

x0 = zeros(3, 1)
r0 = b - A*x0;
k = 0


while norm(r0) > norma_mkg

  z = A*r0;
  alpha0 = ((r0)'*r0)/(r0'*z);
  x1 = x0 + alpha0*r0;
  r1 = r0 - alpha0*z;
  x0 = x1;
  r0 = r1;
  k = k + 1;

end

broj_koraka = k


% zad 2 iz preze

x0 = zeros(3, 1);
r0 = b - A*x0;

k = 1;
v(k) = norm(r0);

while norm(r0) > 1e-5

  k = k + 1;
  z = A*r0;
  alpha0 = ((r0)'*r0)/(r0'*z);
  x1 = x0 + alpha0*r0;
  r1 = r0 - alpha0*z;
  x0 = x1;
  r0 = r1;
  v(k) = norm(r0);

end

%semilogy(v)

% LPNK zad 1

A = [ -4, 3; 8, 3; 8, 12];
b = [-1, 2, 4]';

x1 = (A'*A)\(A'*b);
greska1 = norm(x1 - A\b)
rezidual1 = norm(A*x1-b)


% LPNK zad 2

[U,S,V] = svd(A,0);
Ub = U'*b;


n = size(A, 2);
y = zeros(n, 1);


for ii = 1:n
  y(ii) = Ub(ii)/S(ii,ii);
end

x2 = V*y;

greska2 = norm(x2-A\b)
rezidual2 = norm(A*x2-b)

% QR pjeske

I = eye(3);
a1 = A(:,1);
e1 = I(:,1);

v1p = sign(a1(1))*norm(a1)*e1 + a1;
Hk1 = I-2*v1p*v1p'/(v1p'*v1p);
A1 = Hk1 * A;

Hk2 = [1, 0, 0; 0, 0, 1; 0, 1, 0];
R = Hk2*A1;
Q = Hk1*Hk2;

Rk = R(1:2,1:2);
Qk = Q(:,1:2);

Qkb = Qk'*b;
x3 = Rk\(Qkb);

greska3 = norm(x3-A\b)
rezidual = norm(A*x3-b)

% QR gotovo

[Q2,R2] = qr(A,0)

% itd...







