function [x] = povsup(U,b)
  [m,n] = size(U);
  x = zeros(n,1);
  for j = n:-1:1
    sum = 0;
    for k = j+1:n
      sum = sum + U(j,k)*x(k);
    endfor
    x(j) = (b(j)-sum)/U(j,j);
  endfor
  return

