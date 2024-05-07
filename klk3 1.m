#Zad1

A = [-4 3; 8 3; 8 12];
b = [-1 2 4]';

function x = LPNK_norm_jedn(A,b)
  A_adj = A';
  A_adj_A = A_adj*A;
  A_adj_b = A_adj*b;
  x = A_adj_A\A_adj_b;
end

x = LPNK_norm_jedn(A, b);
norm(A*x-b);



#SVD i ekonomicni SVD

[U,S,V] = svd(A);

[Ue, Se, Ve] = svd(A, 'econ');

#provjera da stvarno dobijemo A
U*S*V;
Ue*Se*Ve;



#Zad2

function x = LPNK_SVD(A,b)
  [U,S,V] = svd(A, 'econ');
  U_adj = U';
  U_adj_b = U_adj*b;
  S_1 = zeros(size(S));
  for ii=1:size(S,1)
    S_1(ii,ii) = 1/S(ii,ii);
  endfor
  y = S_1*U_adj_b;
  x = V*y;
end

x = LPNK_SVD(A,b);
norm(A*x-b);


#QR puna i reducirana faktorizacija

[Q,R] = qr(A);
[Qr,Rr] = qr(A,0);



#Zad3

function x = povsup(U, b)
  [n,m] = size(U);
  x = zeros(n,1);
  for j = n:-1:1
    suma = 0;
    for ii = j+1:n
      suma += U(j,ii)*x(ii);
    endfor
    x(j) = 1/U(j,j)*(b(j) - suma);
  endfor
end


function x = LPNK_QR(A,b)
  [Q,R] = qr(A,0);
  Q_adj = Q';
  Q_adj_b = Q_adj*b;
  x = povsup(R, Q_adj_b);
end

x = LPNK_QR(A,b);
norm(A*x-b);


#Zad4

A = [1 0 3; 3 14 2; 2 3 4; 1 2 5; 1 2 8];
b = [1 2 3 4 5]';

x_norm_jedn = LPNK_norm_jedn(A, b);
x_svd = LPNK_SVD(A,b);
x_qr = LPNK_QR(A,b);




###################### vj ##################



# svj vrijednosti
#Ax = lam*x x!= 0
# (A- lam I)x = 0
# ka(lam) = det(A-lam I)= 0
# pol n-tog stupnja ima n nultocki
#

# svj vektori
# jednoj svj vrijednosti pripada beskonacno svj vektora
# u diag matrici svj vrijednosti na dijagonali i u trokutastoj matrici
# det je umnzak diag elem





# zapis matrice u drugoj bazi
# nije moguce svaku matricu dijagonalizirati, koje je moguce su normalne matrice


# jordanova forma - teorijski dio
# dobiti blok dijag matrivu


# schurova forma

# slicnst martica ako postoji reg mat S tako da je A = S(-1)BS
#            - imaju isti spektar(svj vrijednosti)
# diag/trokutasta? s ugl kompleksnim elem




# realna sch forma( da nema kompleksnih matrica)

# blok trokutasta s realnim elem








# metoda potenciranja implementacija

# matrica 3x3

A = [1 2 3; 4 5 6; 7 8 10]
# singularna martica
# ima beskonacno rjesenja ili nema rjesenja

# ako je regularna onda ima samo jedno rjesenje

x0 = [1 1 1].'
e = 0.00000001
function [lambda] = mp(A,x0,e)
  #eig(A)
  y = x0;
  con = 0;
  while con != 1
    x = y/norm(y);
    y = A*x;
    lambda = x.'*y;
    if norm(y-lambda*x) < e*lambda
      con = 1;
    endif
  endwhile
endfunction

# x svj vektora




# eig(A) daje svojstvne vrijednosti matrice
# treba dobiti 16.7


# metoda inverznih iteracija

# fi svjojstvena vrijednost
#zaustavni kriterij <eplsilon
function [lambda] = mii(A,x0, sigma)
  y = x0;
  con = 0;
  while con != 1
    I = eye(size(A));
    x = y/norm(y);
    (A-sigma*I)*y = x; #########
    fi = x.'*y;
    if norm(y-fi*x)<e
      con = 1;
    endif
  endwhile
  lambda = sigma + 1/fi;
endfunction


I = eye(size(A));
#eig(A)
#dobiti sve svj vrijednosti
#svj vrije najblize nekom broju
# broj koji zadamo ne smije biti svj vrijednost
















































