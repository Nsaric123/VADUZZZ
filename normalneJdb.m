A = [-4 3; 8 3; 8 12]
b = [-1; 2; 4]

function[x] = normalne(A,b)
  A1 = A'*A
  b1 = A'*b

end

function[x] = svdDekomp(A,b)
  [U, S, V] = svd(A, 'econ')
  b1 = U'*b
  y = S\b1
  x = V*y
end


#svdDekomp(A,b)

[Q, R] = qr(A, 0)

function [x] = povsup(U,b)
  [m,n] = size(U);
  x = zeros(n,1);
  for j = n:-1:1
    sum = 0;
    for k = j+1: n
      sum += U(j,k)*x(k);
    endfor
   x(j) = (b(j)- sum)/U(j,j);
 endfor
end

function[x] = QR(A,b)
  [Q, R] = qr(A, 0)
  b1 = Q'*b
  x = povsup(R, b1)
end

#QR(A,b)

A2 = [1 0 3; 3 14 2; 2 3 4; 1 2 5; 1 2 8]
b2 = [1:5]'

svdDekomp(A2, b2)
QR(A2, b2)

