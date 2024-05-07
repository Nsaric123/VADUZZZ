####VEKTORI I MATRICE
##
##a = [1, 2, 3]; ##vektor redak
##b =[1;2;3];   ##vektor stupac
##
##C = [ 1 2 3];  # VEKTOR REDAK
##D = [ 1
##      2
##      3 ]
##
##A = [1, 2, 3; 4, 5, 6; 7, 8, 9]
##
##al = [1 2
##3 4];
##
##B= A*A;
##C = A.*A; ## mozenje matrica po pozicijama
##
##i*i  ## imaginarna jedinica i
##
##
###Generiranje matrica
##I = eye(5)  ##jedinicna matrica, dijgonalna, 5*5
##
##N= zeros(6,4); ## matr ciji su elem 0
##
##D = rand(3,4); ## MATR SA SLUCAJNIM ELEM
##
##F=[N;D];
##F = [N' D']
##
####dimenzija
##[n, m]=size(F)
##
##n = size(F,1) ##samo br redaka matr F
##
##n = size(F,2) ##samo br stupaca matr F
##
##E = [D; 1 2 3 4]
##dt = det(A) ##determinanta
##tr = trace(A)  ##trag matrice
##
####
####
##### Generaliziranje vektora
##x = 1:10  ## vektor redak sa elem od 1 do 10
##x=1:2:10  ## vektor od 1 do 10 sa nekim korakom
##x =(10:-1:1)';  ## s apostrofom transponiramo u vektor stupac  ??
##
##d = [1+1*i, 2-1*i, 3+2*i]
##dt = d'  ## d transponirano i i komplekso konjugiranje= adjungiranje
##dc = d.'  ## samo transponiranje bez konjugiranja
##
##
####Dijelovi atrice/vektora
##E;
##E(2,3);   ##elem na poziciji 2 3
##E(2,:);   ##cijeli drugi redk i svi elementi stupaca za taj redak
##E(:,3);   ##cijeli 3 stupac
##
##
####PODMATRICA
##E(2:3,3) # od kojeg do kojeg retka, od kojeg do kojeg stupca, 2-3 retka i treci stupac
##E(2:4, 3:end)
##
##
##E(:,2) =[]; ##brisanje dijela stupca metrice E, brisanje drugog stupca
##
##
##who  ##varijable, daje sve varijable
##clear E A B  ##BRISANJE VARIJABLA e a b
##who
##
##whos ##detaljnije informacije o varijablama
##
##
##
####ctrl + c - prekidanje procesa
##
####
##M=zeros(5,4) ##nulmat 5*4
##
##for ii = 1:5
##  for jj=1:4
##    if ii~=jj+1
##      M(ii,jj)=2
##    else
##      M(ii,jj)=ii+jj;
##    end
##    end
##end
##M
##
##
##
##br=0;
##while br<5
##  br=br+1;
##  rand(br)
##end
##
##
####skalarni produkt
####Ax = b  <=> x=(a na -1) b
##
##A = rand(1000,1000);
##b=rand(1000,1);
##
##tic; ##pocinjemo mjeriti vrijeme
##x1=inv(A)*b;
##v1=toc;   #zavrsavamo mjeriti vrijeme
##
##tic;
##x2=A\b;     ##4 puta brze je oristiti /??
##v2=toc;
##v1/v2;
##
##
########
##B = rand(1000, 1000);
##C=A*B*b;
##
##tic;;
##C1=(A*B)*b;
##v1=toc;
##
##tic;
##x2= A*(B*b);  ##BRZE JE OD PRETHODNOG
##v2=toc;
##v1/v2;
##
##
#####crtanje rezultata
##X = 0:0.1:10
##length(x)
##y=sin(x)+cos(x)
##plot(x,y)
##title('Ime slike')
##
##
##
##############################################
###############  ZADACI   ################3###
##
####1)
##function[s] = skalarni(x,y)
##   if size(x,1)== size(x,1)
##     for ii = 1: size
##     endfor
##   else
##     print('eror')
##   endif
##
##
##x=[1 2 3]
##y=[2 3 4]
##skalarni(x', y');
##


A = [5, 1, 3, 4; 8, 7, 0, -8; -3, 1, 2, 6]

#####2)
function [s] = suma(A)
  s = 0
  for ii = 1: size(A,1)
    for jj= 1 : size(A,2)
      s += A(ii, jj);
    endfor
  end
end

 suma(A)

B=zeros(10,10);
for ii = 1:size(B,1)
  for jj=1:size(B,2)
    if ii<jj
      B(ii,jj) = 0;
    else
      B(ii,jj) =ii-jj;
    endif
  endfor
end

suma(B)

#####3)

function [C] = mnozenje(A, B)
  C = zeros(size(A,1), size(B,2));
  if size(A,2) == size(B,1)
    for ii = 1:size(A,1)
      for jj= 1:size(A,1)
        for kk= 1:size(B,2)
          C(ii,jj)+= A(ii, kk) * B(kk, jj);
        end
      end
      d = det(C);
    end

  else
    print('error')
end
end
A=[1 2 1; 4 1 3; 5 6 1]
B=[0 1 3; 7 8 -1; -2 5 -4]
mnozenje(A,B)


#######4)  korijen sume kvadrata
function [frob] = frobenius(A)
  frob =0
  for ii = 1: size(A,1)
    for jj= 1: size(A,2)
      frob += A(ii,jj)
    endfor
  endfor
end

A = [1,2,3,4; 4, 3, 2 1; 0, 3 4 5]
frobenius(A)




































