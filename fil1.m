a = [1, 2, 3]
b = [1, 2, 3]';
% komentari
c = [1 + 1i, 2 - 1i];
c = [1 + 1i, 2 - 1i]'; % adjungiranje
c = [1 + 1i, 2 - 1i].'; % transponiranje

b = [1;2;3];

b = [1
    2
    3
    4];

A = [1,2,3; 4 5 6; 7 8 9];

B = A*A;

i*i;

j*j;

I = eye(5);
N = zeros(4);

D = [A B];

x = 1:10;
x = 1:2:10;
x = 10:-1:1;

D(1, 4)
D(1:2, [1,3:6])

D(1:2, end)

D(1, :) = []

who

whos

for ii = 1:5
  disp(['kvadrat broja: ', num2str(ii^2)])

end

i = 4

if i == 3
  ii^3
else
  ii^2
end

b = [1, 2, 3, 4]';
b*b'
b'*b
b.*b

A = rand(100, 100);
b = rand(100, 1);

x = A\b;

x = 0:0.01:10;
y = sin(x) + cos(x);
plot(y);


# Zadatak 1


function u = skalarni(x, y)
  if length(x) != length(y)
    u = NaN;
    return
  endif
  u = 0;
  for ii = 1: length(x)
    u = u + x(ii)*y(ii);
  endfor
end


x = 1:100
y = 2:101

u = skalarni(x, y);

x = 1:5
y = 1:4
u = skalarni(x, y);



function s = suma(A)
  s = 0
  for ii = 1: size(A, 1)
    for jj = 1: size(A, 2)
      s = s + A(ii, jj)
    endfor
  endfor
end


function [C, d] = mnozenje(A, B)
  if size(A, 2) != size(B, 1)
    C = NaN;
    d = NaN
    return
  endif

  C = eye(size(A, 1), size(B, 2))

  for ii = 1 : size(A, 1)
    for jj = 1: size(B, 2)
      s = 0
      for kk = 1: size(A, 2)
        s = s + A(ii, kk) * B(kk, jj)
      endfor
      C(ii, jj) = s
    endfor
  endfor
  d = det(C)
end


function [tr, fn] = frob(A)
  if size(A, 1) == size(A, 2)
    tr = sum(diag(A))
    fn = sqrt(sum(diag(A.'*A)))
    return
  endif
  fn = sqrt(sum(diag(A.'*A)))
  tr = 0
  return
end



function res = checkLU(A)
  if size(A, 1) != size(A, 2)
    res = "False"
    return
  endif
  res = "True"
  for ii = 1 : size(A, 1)
    if det(A(1:ii, 1:ii)) == 0
      res = "False"
      return
    endif
  endfor

end









